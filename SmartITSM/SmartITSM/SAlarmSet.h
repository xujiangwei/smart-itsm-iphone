//
//  SAlarmSet.h
//  SmartITSM
//
//  Created by Apple001 on 14-4-10.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAlarm.h"

@interface SAlarmSet : NSObject

@property (nonatomic, strong) NSMutableArray *alarmArray;

@property (nonatomic, assign) AlarmLevel level;

@end
