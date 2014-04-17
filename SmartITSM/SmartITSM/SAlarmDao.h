//
//  SAlarmDao.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SAlarm.h"
#import "SAlarmSet.h"

@interface SAlarmDao : NSObject

+ (BOOL)insertAlarm:(NSDictionary *)dic;

+ (SAlarm *)getAlarmDetailWithAlarmId:(long)index;

+ (BOOL)updateAlarm:(NSDictionary *)dic;

+(NSMutableArray *)getAlarmList;

//按时间排序
+(NSMutableArray *)getAlarmListOrderByTime:(char)level;


@end
