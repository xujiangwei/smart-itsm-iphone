//
//  SAlarmList.h
//  SmartITSM
//
//  Created by Apple001 on 14-4-10.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SAlarmList : NSObject

+(NSMutableArray *)getAlarmList;

//按时间排序
+(NSMutableArray *)getAlarmListOrderByTime:(char)level;

@end
