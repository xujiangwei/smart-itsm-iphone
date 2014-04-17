//
//  SAlarmContentViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-3-23.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SAlarmContentViewController.h"

@interface SAlarmContentViewController ()
{
    UITableView *tableview;
    NSArray *imageName;
    NSArray *rowList;
}

@end

@implementation SAlarmContentViewController
@synthesize alarm;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        imageName = [NSArray arrayWithObjects:@"alarm_serious@2x.png",@"alarm_main@2x.png",@"alarm_minor@2x.png",@"alarm@2x.png",@"alarm_unkown@2x.png", nil];
        rowList = [NSArray arrayWithObjects:@"管理对象",@"定位：",@"IP:",@"原因：",@"初始发生时间：",@"告警状态：",@"详情：",@"重复次数：",@"最近发生时间：",@"确认人：",@"确认时间：", nil];
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    tableview = [[UITableView alloc] initWithFrame:CGRectMake(0, 65, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    tableview.dataSource = self;
    tableview.delegate = self;
    [self.view addSubview:tableview];
    
    self.title = @"详细信息";
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Tableview Datasource

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return rowList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SAlarmContentViewCell";
    UITableViewCell *cell = [tableview dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [rowList objectAtIndex:indexPath.row];
    
    if (nil != alarm)
    {
        switch (indexPath.row)
        {
            case 0:
            {
                if (0 != [alarm.objectOfManagement length])
                {
                    cell.detailTextLabel.text = alarm.objectOfManagement;
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
            case 1:
            {
                if (0 != [alarm.location length])
                {
                    cell.detailTextLabel.text = alarm.location;
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
            case 2:
            {
                if (0 != [alarm.deviceIp length])
                {
                    cell.detailTextLabel.text = alarm.deviceIp;
                    
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
                
            case 3:
            {
                if (0 != [alarm.reason length ])
                {
                    cell.detailTextLabel.text = alarm.reason;
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
            }
                break;
            case 4:
            {
                if (0 != alarm.firstTime)
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSDate *firstT = [NSDate dateWithTimeIntervalSince1970:alarm.firstTime/1000];
                    cell.detailTextLabel.text = [dateFormatter stringFromDate:firstT];
                }
                else
                {
                    cell.detailTextLabel.text = @"0";
                }
                break;
            }
                
            case 5:
            {
                if (0 != [alarm.alarmStatus length])
                {
                    cell.detailTextLabel.text = alarm.alarmStatus;
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
                
            case 6:
            {
                if (0 != [alarm.detailReason length])
                {
                    cell.detailTextLabel.text = alarm.detailReason;
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
                
            case 7:
            {
                if (0 != alarm.numOfRepeat)
                {
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", alarm.numOfRepeat];
                }
                else
                {
                    cell.detailTextLabel.text = @"0";
                }
                break;
            }
            case 8:
                
            {
                //                    NSLog(@"++++++++++++alarm.lastTime = %f",alarm.lastTime);
                if (0 != alarm.lastTime)
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSDate *lastT = [NSDate dateWithTimeIntervalSince1970:alarm.lastTime/1000];
                    cell.detailTextLabel.text = [dateFormatter stringFromDate:lastT];
                    //                    cell.detailTextLabel.text = @"正在加载数据……";
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
                
            case 9:
            {
                if (0 != [alarm.confirmor length])
                {
                    cell.detailTextLabel.text = alarm.confirmor;
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
                
            case 10:
            {
                //                    NSLog(@"++++++++++++alarm.confirmTime = %f",alarm.confirmTime);
                if (0 != alarm.confirmTime)
                {
                    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
                    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSDate *confirmT = [NSDate dateWithTimeIntervalSince1970:alarm.confirmTime/1000];
                    cell.detailTextLabel.text = [dateFormatter stringFromDate:confirmT];
                }
                else
                {
                    cell.detailTextLabel.text = @"无";
                }
                break;
            }
            default:
                break;
        }
        
    }
    

    
    
    cell.userInteractionEnabled = NO;
    
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    CGRect rectangle = CGRectMake(CGRectGetMidX(self.view.bounds) - 27.5, 0, 55, 44);
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 44)];
    view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:rectangle];
    imageView.image = [UIImage imageNamed:[imageName objectAtIndex:self.index]];
    [view addSubview:imageView];
    
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
}



@end
