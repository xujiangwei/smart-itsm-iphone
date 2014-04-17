//
//  SAlarmViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-3-23.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SAlarmViewController.h"
#import "SAlarmListViewController.h"
#import "SAlarmViewCell.h"
#import "SAlarmSet.h"

@interface SAlarmViewController ()


@end

@implementation SAlarmViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    
    if ((self = [super initWithStyle:style]))
    {
        self.alarmLevelList = [[NSArray alloc] initWithObjects:@"严重告警",@"主要告警", nil];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        self.alarmLevelList = [[NSArray alloc] initWithObjects:@"严重告警",@"主要告警", nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.alarmLevelList = [[NSArray alloc] initWithObjects:@"严重告警",@"主要告警",@"次要告警",@"告警",@"未知告警",nil];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SAlarmViewCell" bundle:nil] forCellReuseIdentifier:@"SAlarmViewCell"];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row + 1;
    NSString *row = [NSString stringWithFormat:@"%d",index];
//    NSLog(@"the row is %@",row);
    NSMutableArray *array = [SAlarmDao getAlarmListOrderByTime:*[row UTF8String]];
//    NSLog(@"the array is %@",array);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SAlarmListViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SAlarmListVC"];
    
    SAlarmViewCell *cell = (SAlarmViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [viewController setTitle:[cell.alarmLevel text]];
    [viewController setAlarmList:array];
    [viewController setIndex:indexPath.row];
    
    [self.navigationController pushViewController:viewController animated:YES];

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.alarmLevelList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SAlarmViewCell";
    
    SAlarmViewCell *cell = (SAlarmViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (nil == cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SAlarmViewCell" bundle:nil] forCellReuseIdentifier:@"SAlarmViewCell"];
    }
    [cell.alarmLevel setText:[self.alarmLevelList objectAtIndex:indexPath.row]];
    
    if (indexPath.row == 0)
    {
        cell.alarmImageV.image = [UIImage imageNamed:@"alarm_serious_lamp@2x.png"];
        cell.alarmCount.text = [NSString stringWithFormat:@"%d",[SAlarmDao getAlarmListOrderByTime:'1'].count];

    }
    else if (indexPath.row == 1)
    {
        cell.alarmImageV.image = [UIImage imageNamed:@"alarm_main_lamp@2x.png"];
        cell.alarmCount.text = [NSString stringWithFormat:@"%d",[SAlarmDao getAlarmListOrderByTime:'2'].count];
    }
    else if (indexPath.row == 2)
    {
        cell.alarmImageV.image = [UIImage imageNamed:@"alarm_minor_lamp@2x.png"];
        cell.alarmCount.text = [NSString stringWithFormat:@"%d",[SAlarmDao getAlarmListOrderByTime:'3'].count];


    }
    else if(indexPath.row == 3)
    {
        cell.alarmImageV.image = [UIImage imageNamed:@"alarm_lamp@2x.png"];
        cell.alarmCount.text = [NSString stringWithFormat:@"%d",[SAlarmDao getAlarmListOrderByTime:'4'].count];

    }
    else
    {
        cell.alarmImageV.image = [UIImage imageNamed:@"alarm_unkown_lamp@2x.png"];
        cell.alarmCount.text = [NSString stringWithFormat:@"%d",[SAlarmDao getAlarmListOrderByTime:'5'].count];

    }

    return cell;
}

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    SAlarmListViewController *viewController = (SAlarmListViewController *)[segue destinationViewController];
    viewController.title = [cell.textLabel text];
    
}
*/

#pragma mark -private

-(void)initData
{
                     
    
}



@end
