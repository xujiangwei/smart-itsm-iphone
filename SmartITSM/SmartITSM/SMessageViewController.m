//
//  SMessageViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageViewController.h"
#import "SMessageContentViewController.h"
#import "SMessageViewCell.h"
#import "SMessageDao.h"
#import "SMessageSortingPopoverController.h"
#import "MastEngine.h"
#import "MBProgressHUD.h"
#import "SUser.h"

#define kCellHeight 80

@interface SMessageViewController ()
{
    SMessageContentViewController *messageContentViewController;
    SMessageListener *_listener;
    SMessageStatusListener *_failureListener;
    MBProgressHUD *HUD;
}
@end

@implementation SMessageViewController

@synthesize messages;
@synthesize delegate;
@synthesize popoverController;
@synthesize currentIndexPath;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {

    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _listener = [[SMessageListener alloc] initWith:@"requestMessages"];
        _failureListener = [[SMessageStatusListener alloc] init];
        _listener.delegate = self;
        _failureListener.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加列表
    messages = [SMessageDao getTaskList];
    
    //刷新列表
    [self addRefreshViewControl];
    
    [self refresh];
    
    [[MastEngine sharedSingleton] addListener:@"SmartITOM" listener:_listener];
    
    //添加rightBarButton
    popoverClass = [WEPopoverController class];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,44,40)];
    
    [rightButton setTitle:@"操作" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(sorting:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [[MastEngine sharedSingleton] removeListener:@"SmartITOM" listener:_listener];
}

// 添加UIRefreshControl下拉刷新控件到UITableViewController的view中
-(void)addRefreshViewControl
{
    self.refreshControl = [[UIRefreshControl alloc]init];
    self.refreshControl.tintColor = [UIColor blueColor];
    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [self.refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
}

-(void)RefreshViewControlEventValueChanged
{
    if (self.refreshControl.refreshing) {
        NSLog(@"refreshing");
        self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"刷新中"];
        //模拟网络加载数据，延迟2秒
        [self performSelector:@selector(handleData) withObject:nil afterDelay:2];
    }
}

- (void)handleData
{
    NSLog(@"refreshed");
    [self.refreshControl endRefreshing];

    [self.tableView reloadData];
}

//排序
-(void)sorting:(UIButton*)sender
{
    
	if (!self.popoverController) {
		
		SMessageSortingPopoverController *sortingPopoverController = [[SMessageSortingPopoverController alloc] initWithStyle:UITableViewStylePlain];
		self.popoverController = [[popoverClass alloc] initWithContentViewController:sortingPopoverController];
		self.popoverController.delegate = self;
		self.popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
		
		[self.popoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem
									   permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
													   animated:YES];
        
	} else {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
	}
    
}


#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMessage *msg = [self.messages objectAtIndex:indexPath.row];
    NSLog(@"msg = %@",msg);
    NSLog(@"msgId = %@",msg.messageId);
    SMessage *selectMsg = [SMessageDao getMessageTaskDetailById:msg.messageId];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SMessageContentViewController *contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"SMessageContentVC"];
    contentViewController.message = selectMsg;
    [self.navigationController pushViewController:contentViewController animated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SMessageViewCell";
    SMessageViewCell *cell = (SMessageViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if (nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier
                                                     owner:self
                                                   options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SMessage *msg= [messages objectAtIndex:indexPath.row];
    if (nil != messages)
    {
        [cell updateMessage:msg];
    }
    return cell;
}



#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //设置sender为标题
    SMessageViewCell *cell = (SMessageViewCell *)sender;
    
    SMessageContentViewController *viewController = (SMessageContentViewController *)[segue destinationViewController];
    viewController.title = [cell.senderLabel text];
 
}

#pragma mark - SMessageDelegate
- (void)updateMessages:(NSDictionary *)dic
{
    NSLog(@"123456");
//    dispatch_async(dispatch_get_main_queue(), ^{
//        NSArray *rootArray = [dic objectForKey:@"root"];
//        for (int i=0; i<[rootArray count]; i++) {
//            NSDictionary *dic = [rootArray objectAtIndex:i];
//            [SMessageList insertMessage:dic];
//            [SMessageList updateMessage:dic];
//        }
//        self.messages = [SMessageList getMessageList:12];
//        [HUD removeFromSuperview];
//        [self.listView reloadData];
//    });
    
}

#pragma mark - ServiceDelegate

- (void)startup
{
    [[MastEngine sharedSingleton] addListener:@"requestMessages" listener:_listener];
//    [[MastEngine sharedSingleton] addFailureListener:_failureListener];
    
    [self refresh];
}

- (void)shutdown
{
    [[MastEngine sharedSingleton] removeListener:@"requestMessages" listener:_listener];
//    [[MastEngine sharedSingleton] removeFailureListener:_failureListener];
}

#pragma mark - Public Methods

- (void)refresh
{
    //C2S
    if ([SUser isSignin])
    {
        CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton] createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
        dialect.action = @"requestMessages";
        NSString *stringValue=[NSString stringWithFormat:@"{\"pageSize\":\"50\",\"currentIndex\":\"0\",\"orderBy\":\"sender\",\"tagId\":\"2\",\"condition\":\"\",\"token\":\"%@\"}",[SUser getToken]];
        [dialect appendParam:@"data" stringValue:stringValue];
        [[MastEngine sharedSingleton] asynPerformAction:@"SmartITOM" action:dialect];

//        HUD = [[MBProgressHUD alloc]initWithView:self.view];
//        [self.view addSubview:HUD];
//        HUD.mode = MBProgressHUDModeIndeterminate;
//        HUD.labelText = @"loading...";
//        HUD.delegate = self;
//        [HUD show:YES];
    }
}

#pragma mark - SMessageFailureDelegate
- (void)didFailed:(NSString *)identifier
{
    [HUD removeFromSuperview];
//    [iConsole info:@"message: %@",failure.description];
}

#pragma mark - Private Methods

- (void)refreshView
{
//    self.listView.frame = CGRectMake(0, 44, 310, self.view.frame.size.height - 44);
}

- (void)requestData
{
    
}
- (void)loadData
{
    self.messages = [SMessageDao getTaskList];
    
}

@end
