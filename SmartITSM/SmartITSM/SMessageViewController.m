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

#define kCellHeight 80

@interface SMessageViewController ()

@end

@implementation SMessageViewController

@synthesize messages;
@synthesize messageListView;
@synthesize delegate;
@synthesize popoverController;

- (id)initWithStyle:(UITableViewStyle)style
{
    
    if ((self = [super initWithStyle:style]))
    {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

//- (id)initWithCoder:(NSCoder *)aDecoder
//{
//    self = [super initWithCoder:aDecoder];
//    if (self)
//    {
//        self.messageList = [[NSArray alloc] initWithObjects:@"消息1",@"工单消息2", nil];
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //添加列表
    messageListView.dataSource = self;
    messageListView.delegate = self;
    messages = [SMessageDao getTaskList];
    
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

-(void)sorting:(UIButton*)sender
{
    
	if (!self.popoverController) {
		
		SMessageSortingPopoverController *sortingPopoverController = [[SMessageSortingPopoverController alloc] initWithStyle:UITableViewStylePlain];
//        sortingPopoverController.messageContentViewController = self;
        
        
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)updateMessageList:(NSMutableArray *)messageArray
{
    messages = messageArray;
    [messageListView reloadData];
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"MessageDetail" sender:cell];
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
    SMessage *tempMessage= [messages objectAtIndex:indexPath.row];
    cell.messageIdLabel.text = tempMessage.messageId;
    cell.senderLabel.text = tempMessage.sender;
    cell.messageTextLabel.text = tempMessage.messageText;
    cell.summaryLabel.text = tempMessage.summary;
    cell.sendTimeLabel.text = tempMessage.sendTime;
//    NSString *stateImage=[SIncidentDao getStateIcon:tempMessage];
    
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



@end
