//
//  SOwnViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-2-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SOwnViewController.h"
#import "SOwnDetailViewController.h"

@interface SOwnViewController ()

@end

@implementation SOwnViewController

@synthesize sectionArray;
@synthesize cellDic;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString *index=[sectionArray objectAtIndex:section];
    return [[cellDic objectForKey:index] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section=indexPath.section;
    NSInteger  row=indexPath.row;
    
    NSString *CellIdentifier =[NSString stringWithFormat:@"owncell%d%d",section,row];
    
    NSString *sectionTitle=[sectionArray objectAtIndex:section];
    NSArray *cellAttributes=[cellDic objectForKey:sectionTitle];

    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] ;
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    NSString * attribute=[cellAttributes objectAtIndex:row];
    if([attribute isEqualToString:@"incident"]){
        cell.textLabel.text=@"故障";
        [cell.detailTextLabel setText:@"5"];
    }else if([attribute isEqualToString:@"problem"]){
        cell.textLabel.text=@"问题";
          [cell.detailTextLabel setText:@"9"];
    }else if([attribute isEqualToString:@"change"]){
        cell.textLabel.text=@"变更";
          [cell.detailTextLabel setText:@"1"];
    }else if([attribute isEqualToString:@"inspection"]){
        cell.textLabel.text=@"巡检";
          [cell.detailTextLabel setText:@"2"];
    }else if([attribute isEqualToString:@"notice"]){
        cell.textLabel.text=@"公告";
          [cell.detailTextLabel setText:@"8"];
    }else if ([attribute isEqualToString:@"message"]){
        cell.textLabel.text=@"消息";
          [cell.detailTextLabel setText:@"36"];
    }else if ([attribute isEqualToString:@"alarm"]){
        cell.textLabel.text=@"告警";
        [cell.detailTextLabel setText:@"3"];
    }

    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger section=indexPath.section;
    NSInteger row=indexPath.row;
    
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    
    if(section==0 && row==0){
        [self performSegueWithIdentifier:@"IncidentList" sender:cell];
    }else if(section==0 && row==1){
        [self performSegueWithIdentifier:@"ProblemList" sender:cell];
    }else if(section==0 && row==2){
        [self performSegueWithIdentifier:@"ChangeList" sender:cell];
    }else if(section==0 && row==3){
        [self performSegueWithIdentifier:@"InspectionList" sender:cell];
    }
    else if(section==3 && row==0){
        [self performSegueWithIdentifier:@"AlarmList" sender:cell];
    }


}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"Signin"])
    {
        
    }
    else if ([segue.identifier isEqualToString:@"OwnDetail"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        SOwnDetailViewController *detailVC = (SOwnDetailViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }
    else if ([segue.identifier isEqualToString:@"IncidentList"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        SIncidentViewController *detailVC = (SIncidentViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }
    else if ([segue.identifier isEqualToString:@"ProblemList"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        SProblemViewController *detailVC = (SProblemViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }else if ([segue.identifier isEqualToString:@"ChangeList"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        SChangeViewController *detailVC = (SChangeViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }else if ([segue.identifier isEqualToString:@"InspectionList"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        SOwnDetailViewController *detailVC = (SOwnDetailViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }
    else if ([segue.identifier isEqualToString:@"AlarmList"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        SAlarmViewController *detailVC = (SAlarmViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }

}


-(void)initData
{
   sectionArray =[NSArray arrayWithObjects:@"待办",@"公告",@"消息", @"告警" ,nil];
    NSArray  *taskInfo=[[NSArray alloc]initWithObjects:@"incident",@"problem",@"change",@"inspection", nil];
    NSArray  *noticeInfo   =[[NSArray alloc] initWithObjects:@"notice", nil];
    NSArray  *messageInfo   =[[NSArray alloc] initWithObjects:@"message", nil];
    NSArray  *alarmInfo = [[NSArray alloc] initWithObjects:@"alarm", nil];
    
   cellDic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:taskInfo,[sectionArray objectAtIndex:0], noticeInfo ,[sectionArray objectAtIndex:1],messageInfo ,[sectionArray objectAtIndex:2],alarmInfo, [sectionArray objectAtIndex:3], Nil];
}


@end
