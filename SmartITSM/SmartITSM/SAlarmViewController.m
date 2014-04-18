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
        self.alarmLevelList = [[NSMutableArray alloc] initWithObjects:@"严重告警",@"主要告警", nil];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
        self.alarmLevelList = [[NSMutableArray  alloc] initWithObjects:@"严重告警",@"主要告警", nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
//        self.alarmLevelList = [[NSArray alloc] initWithObjects:@"严重告警",@"主要告警",@"次要告警",@"告警",@"未知告警",nil];
        self.alarmLevelList = [[NSMutableArray alloc] init];
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
    NSArray *array = [self.alarmLevelList objectAtIndex:indexPath.row];
    SAlarm *alarm = [array objectAtIndex:0];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SAlarmListViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SAlarmListVC"];
    
    SAlarmViewCell *cell = (SAlarmViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [viewController setTitle:[cell.alarmLevel text]];
    [viewController setAlarmList:array];
    [viewController setIndex:alarm.level - 1];
    
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
    NSArray *array = [self.alarmLevelList objectAtIndex:indexPath.row];
    SAlarm *alarm = [array objectAtIndex:0];
    
    switch (alarm.level)
    {
        case seriousAlarm:
            cell.alarmImageV.image = [UIImage imageNamed:@"alarm_serious_lamp.png"];
            cell.alarmLevel.text = @"严重告警";
            cell.alarmCount.text = [NSString stringWithFormat:@"%d",array.count];
            break;
        case mainAlarm:
            cell.alarmImageV.image = [UIImage imageNamed:@"alarm_main_lamp.png"];
            cell.alarmLevel.text = @"主要告警";
            cell.alarmCount.text = [NSString stringWithFormat:@"%d",array.count];
            break;
        case minorAlarm:
            cell.alarmImageV.image = [UIImage imageNamed:@"alarm_minor_lamp.png"];
            cell.alarmLevel.text = @"次要告警";
            cell.alarmCount.text = [NSString stringWithFormat:@"%d",array.count];
            break;
        case Alarm:
            cell.alarmImageV.image = [UIImage imageNamed:@"alarm_lamp.png"];
            cell.alarmLevel.text = @"告警";
            cell.alarmCount.text = [NSString stringWithFormat:@"%d",array.count];
            break;
        default:
            cell.alarmImageV.image = [UIImage imageNamed:@"alarm_unkown_lamp.png"];
            cell.alarmLevel.text = @"未知告警";
            cell.alarmCount.text = [NSString stringWithFormat:@"%d",array.count];
            break;
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
  
    for (int i = 1; i < 6; i++)
    {
        NSString *index = [NSString stringWithFormat:@"%d",i];

        NSMutableArray *array = [SAlarmDao getAlarmListOrderByTimeWithLevel:*[index UTF8String]];
        if (array.count)
        {
            [self.alarmLevelList addObject:array];
        }

    }
    
}



@end
