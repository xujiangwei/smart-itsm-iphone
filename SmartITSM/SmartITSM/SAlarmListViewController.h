//
//  SAlarmListViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-3.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAlarmDao.h"

@interface SAlarmListViewController : UITableViewController

@property (nonatomic, strong) NSArray *alarmList;

@property (nonatomic,strong) UIImage *image;

@property (nonatomic,assign) NSInteger index;

@end
