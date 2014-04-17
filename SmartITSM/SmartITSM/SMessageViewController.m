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

#define kCellHeight 80

@interface SMessageViewController ()

@end

@implementation SMessageViewController

@synthesize messages;
@synthesize messageListView;
@synthesize delegate;

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
    
//    [self.tableView registerNib:[UINib nibWithNibName:@"SMessageViewCell" bundle:nil] forCellReuseIdentifier:@"SMessageViewCell"];
    
    messageListView.dataSource = self;
    messageListView.delegate = self;
    messages = [SMessageDao getTaskList];
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


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    SMessageContentViewController *viewController = (SMessageContentViewController *)[segue destinationViewController];
    viewController.title = [cell.textLabel text];
 
}
 */



@end
