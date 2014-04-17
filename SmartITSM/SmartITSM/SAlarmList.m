//
//  SAlarmList.m
//  SmartITSM
//
//  Created by Apple001 on 14-4-10.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SAlarmList.h"
#import "SAlarm.h"
#import "SDatabase.h"

@implementation SAlarmList

+ (NSMutableArray *)getAlarmList
{
    NSMutableArray *almArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"SELECT alarm_id ,object_management,location, level,resource_id, device_ip,alarm_type, reason FROM tb_alarm WHERE alarm_status = '发生'";
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        long alarmId = [rs longForColumnIndex:0];
        NSString *obj_management = [rs stringForColumnIndex:1];
        NSString *plocation = [rs stringForColumnIndex:2];
        NSString *plevel = [rs stringForColumnIndex:3];
        long resourceID = [rs longForColumnIndex:4];
        NSString *pip = [rs stringForColumnIndex:5];
        NSString *type = [rs stringForColumnIndex:6];
        NSString *reason = [rs stringForColumnIndex:7];
        
        SAlarm *tmpAlarm = [[SAlarm alloc]init];
        [tmpAlarm setID:alarmId];
        [tmpAlarm setObjectOfManagement:obj_management];
        [tmpAlarm setLocation:plocation];
        [tmpAlarm setLevel:[plevel intValue]];
        [tmpAlarm setDeviceIp:pip];
        [tmpAlarm setResourceType:type];
        [tmpAlarm setReason:reason];
        [tmpAlarm setResourceId:resourceID];
        
        [almArray addObject:tmpAlarm];
    }
    
    return almArray;
}

+ (NSMutableArray *)getAlarmListOrderByTime:(char)level
{
    NSMutableArray *almArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql =[NSString stringWithFormat: @"SELECT alarm_id ,object_management,location, level, resource_id, device_ip,alarm_type FROM tb_alarm WHERE alarm_status = '发生' AND level = %c  ORDER BY first_time" ,level];
    NSLog(@"%@",selectSql);
    rs = [db executeQuery:selectSql];
    while ( [rs next])
    {
        long alarmId = [rs longForColumnIndex:0];
        NSString *obj_management = [rs stringForColumnIndex:1];
        NSString *plocation = [rs stringForColumnIndex:2];
        NSString *plevel = [rs stringForColumnIndex:3];
        long resourceID = [rs longForColumnIndex:4];
        NSString *pip = [rs stringForColumnIndex:5];
        NSString *type = [rs stringForColumnIndex:6];
        
        SAlarm *tmpAlarm = [[SAlarm alloc]init];
        [tmpAlarm setID:alarmId];
        [tmpAlarm setObjectOfManagement:obj_management];
        [tmpAlarm setLocation:plocation];
        [tmpAlarm setLevel:[plevel intValue]];
        [tmpAlarm setResourceId:resourceID];
        [tmpAlarm setDeviceIp:pip];
        [tmpAlarm setResourceType:type];
        
        [almArray addObject:tmpAlarm];
    }
    
    return almArray;
}



@end
