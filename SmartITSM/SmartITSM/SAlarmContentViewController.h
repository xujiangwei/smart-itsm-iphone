//
//  SAlarmContentViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-3-23.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAlarm.h"

@interface SAlarmContentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) SAlarm *alarm;
@property (nonatomic,assign) NSInteger index;

@end
