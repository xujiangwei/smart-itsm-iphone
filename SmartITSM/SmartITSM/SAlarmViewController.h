//
//  SAlarmViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-3-23.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAlarmViewListener.h"
#import "SAlarmSet.h"

@interface SAlarmViewController : UITableViewController<SAlarmViewListenerDelegate>

@property (nonatomic, strong) NSMutableArray *alarmLevelList;

@end
