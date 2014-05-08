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
#import "SUser.h"
#import "MastEngine.h"
#import "MBProgressHUD.h"

#define kDemoCelletName @"SmartITOM"

@interface SAlarmViewController ()
{
    SAlarmViewListener *_listener;
    MBProgressHUD *_HUD;
}


@end

@implementation SAlarmViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    
    if ((self = [super initWithStyle:style]))
    {
        self.alarmLevelList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.alarmLevelList = [[NSMutableArray alloc] init];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.alarmLevelList = [[NSMutableArray alloc] init];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];

    [self refresh];
    
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
    UIStoryboard *storyboard = self.storyboard;
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
//发送网络请求
-(void)refresh
{
    _listener = [[SAlarmViewListener alloc] initWith:@"requestAlarmList"];
    _listener.delegate = self;
    [[MastEngine sharedSingleton] addActionListener:kDemoCelletName listener:_listener];
    
    _HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.labelText = @"数据加载中...";

    if ([SUser isSignin])
    {
        CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton] createDialect:@"ActionDialect" tracker:@"dhcc"];
        dialect.action = @"requestAlarmList";
        NSDictionary *valueDic = [NSDictionary dictionaryWithObjectsAndKeys:@"10",@"pagesize",@"1",@"currentIndex", nil];
        NSString *value;
        if ([NSJSONSerialization isValidJSONObject:valueDic])
        {
            NSError *error;
            NSData *data = [NSJSONSerialization dataWithJSONObject:valueDic options:NSJSONWritingPrettyPrinted error:&error];
            value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        }
        [dialect appendParam:@"data" stringValue:value];
        [[MastEngine sharedSingleton] asynPerformAction:kDemoCelletName action:dialect];
    }
}

-(void)loadData
{
    if (self.alarmLevelList != nil)
    {
        [self.alarmLevelList removeAllObjects];
    }
    
  
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

#pragma mark SAlarmViewListenerDelegate

-(void)loadAlarmList:(NSDictionary *)dic
{
    NSInteger statusCode = [[dic objectForKey:@"status"] integerValue];
    if (statusCode == 300)
    {
        NSArray *alarmList = [dic objectForKey:@"almList"];
        for (int i = 0; i < [alarmList count]; i++)
        {
            NSDictionary *dic = [alarmList objectAtIndex:1];
            if (![SAlarmDao insertAlarm:dic])
            {
                [SAlarmDao updateAlarm:dic];
            }
        }
        
        [self loadData];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_HUD removeFromSuperview];
            [self.tableView reloadData];
        });
    }
    else if (statusCode == 900)
    {
        [_HUD removeFromSuperview];
        NSLog(@"网络数据请求失败");
        
    }
 
    [[MastEngine sharedSingleton] removeActionListener:kDemoCelletName listener:_listener];
}


@end
