//
//  SMessageViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageViewController.h"
#import "SMessageContentViewController.h"
#import "SMessageDao.h"
#import "MastEngine.h"
#import "MBProgressHUD.h"
#import "SUser.h"
#import "SMessageOperationViewController.h"

#define kCellHeight 80
#define kDemoCelletName @"SmartITOM"

@interface SMessageViewController ()
{
    SMessageListener *_listener;
    SMessageStatusListener *_statusListener;
    MBProgressHUD *_HUD;
    BOOL _refreshControl;
}
@end

@implementation SMessageViewController

@synthesize messages;
@synthesize popoverController;
@synthesize currentIndexPath;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _statusListener = [[SMessageStatusListener alloc] init];
        _statusListener.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加列表
    messages = [SMessageDao getMessageList];
    
    //下拉刷新列表
    [self addRefreshViewControl];
    
    //刷新列表
    _refreshControl = true;
    //    [self refresh];
    
    //添加rightBarButton
    popoverClass = [WEPopoverController class];
    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(0,0,44,40)];
    [rightButton setTitle:@"操作" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(operation:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// 添加UIRefreshControl下拉刷新控件到UITableViewController的view中
-(void)addRefreshViewControl
{
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]init];
    refreshControl.tintColor = [UIColor blueColor];
    refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [refreshControl addTarget:self action:@selector(RefreshViewControlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
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
    _refreshControl = false;
    [self refresh];
    [self.refreshControl endRefreshing];
    [self.tableView reloadData];
    NSLog(@"refreshed");
}

//操作PopOver
-(void)operation:(UIButton *)sender
{
    
	if (!self.popoverController) {
		
		SMessageOperationViewController *operationViewController = [[SMessageOperationViewController alloc] initWithStyle:UITableViewStylePlain];
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:operationViewController];
		self.popoverController = [[popoverClass alloc] initWithContentViewController:navController];
		self.popoverController.delegate = self;
		self.popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
		
		[self.popoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem
									   permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
													   animated:YES];
        
	}
    else
    {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
	}
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
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
    
    //为delegate赋值
    cell.delegate = self;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    SMessage *msg= [messages objectAtIndex:indexPath.row];
    if (nil != messages)
    {
        [cell updateMessage:msg];
    }
    
    //标记Button的tag
    cell.btnMarkTop.tag = indexPath.row;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SMessage *msg = [self.messages objectAtIndex:indexPath.row];
    
    //标记已读
    if (!msg.hasRead)
    {
        [msg setHasRead:YES];
        [self.messages replaceObjectAtIndex:indexPath.row withObject:msg];
        [tableView reloadData];
        [SMessageDao updateMessageUnread:YES withMessageId:msg.messageId];
    }
    
    //视图跳转
    SMessage *selectMsg = [SMessageDao getMessageDetailById:msg.messageId];
    UIStoryboard *storyboard = self.storyboard;
    SMessageContentViewController *contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"SMessageContentVC"];
    contentViewController.message = selectMsg;
    [self.navigationController pushViewController:contentViewController animated:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //设置标题
    SMessageContentViewController *viewController = (SMessageContentViewController *)[segue destinationViewController];
    viewController.title = @"详细信息";
}

#pragma mark - SMessageDelegate
- (void)updateMessages:(NSDictionary *)dic
{
    NSArray *rootArray = [dic objectForKey:@"root"];
    for (int i=0; i<[rootArray count]; i++) {
        NSDictionary *dic = [rootArray objectAtIndex:i];
        [SMessageDao insertMessage:dic];
        [SMessageDao updateMessage:dic];
    }
    self.messages = [SMessageDao getMessageList];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
        [_HUD removeFromSuperview];
    });
    
    
    [[MastEngine sharedSingleton] removeListener:kDemoCelletName listener:_listener];
    
}

#pragma mark - SMessageViewCellDelegate

//置顶
- (void)btnMarkTopAction:(BOOL)top withId:(NSString *)messageId withTag:(NSInteger)index
{
    
    //置顶后更新model，相应的详情的里的model也要更新，不是仅仅改变某一个图片
    [SMessageDao updateMessageTop:top withMessageId:messageId];
    
    //通过Button的tag标记cell的位置
    SMessage *msg = [self.messages objectAtIndex:index];
    [msg setHasTop:top];
    [self.messages replaceObjectAtIndex:index withObject:msg];
    [self.tableView reloadData];
}

#pragma mark - Public Methods

- (void)refresh
{
    if (nil != _listener)
    {
        [[MastEngine sharedSingleton] removeListener:kDemoCelletName listener:_listener];
    }
    
    _listener = [[SMessageListener alloc] initWith:@"requestMessages"];
    _listener.delegate = self;
    
    [[MastEngine sharedSingleton] addListener:kDemoCelletName listener:_listener];
    
    //C2S
    if ([SUser isSignin])
    {
        CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton] createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
        dialect.action = @"requestMessages";
        NSDictionary *valueDic = [NSDictionary dictionaryWithObjectsAndKeys:@"50", @"pageSize", @"0", @"currentIndex", @"sender", @"orderBy", @"2", @"tagId", @"", @"condition", [NSString stringWithFormat:@"%@", [SUser getToken]], @"token", nil];
        NSString *value;
        if ([NSJSONSerialization isValidJSONObject:valueDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:valueDic options:NSJSONWritingPrettyPrinted error:&error];
            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        [dialect appendParam:@"data" stringValue:value];
        [[MastEngine sharedSingleton] asynPerformAction:kDemoCelletName action:dialect];
        
        if (_refreshControl)
        {
            _HUD = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:_HUD];
            _HUD.mode = MBProgressHUDModeIndeterminate;
            _HUD.labelText = @"loading...";
            _HUD.delegate = self;
            [_HUD show:YES];
        }
    }
}

#pragma mark - SMessageFailureDelegate
- (void)didFailed:(NSString *)identifier
{
    [_HUD removeFromSuperview];
}


@end
