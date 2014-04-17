//
//  SAlarmDao.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SAlarmDao.h"
#import "SDatabase.h"
#import "FMResultSet.h"

@implementation SAlarmDao


+ (BOOL)insertAlarm:(NSDictionary *)dic
{
    BOOL result;
    
    SDatabase *db = [SDatabase sharedSingleton];
    
    long alarmId = [[dic objectForKey:@"almId"] longValue];
    NSString *moName = [dic objectForKey:@"moName"];
    NSString *local = [dic objectForKey:@"location"];
    NSNumber *level = [dic objectForKey:@"severity"];
    NSString *ip = [dic objectForKey:@"moIp"];
    NSString *alarmType = [dic objectForKey:@"moType"];
    NSString *reason = [dic objectForKey:@"almCause"];
    NSString *detail = [dic objectForKey:@"detail"];
    NSString *status = [dic objectForKey:@"almStatus"];
    NSNumber *firstTime = [dic objectForKey:@"occurTime"];
    NSNumber *lastTime = [dic objectForKey:@"lastTime"];//long
    NSString *trend = [dic objectForKey:@"trend"];
    NSNumber *count = [dic objectForKey:@"count"];//int
    NSNumber *upgradeCount = [dic objectForKey:@"upgradeCount"];//int
    NSString *confirmor = [dic objectForKey:@"confirmUser"];
    NSNumber *confirmTime = [dic objectForKey:@"confirmTime"];//long
    NSString *deleter = [dic objectForKey:@"delUser"];
    NSNumber *delTime = [dic objectForKey:@"delTime"];//long
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO tb_alarm (alarm_id , object_management , location  , level , device_ip  , alarm_type , reason , detail ,alarm_status  , first_time , last_time , alarm_trend , repeat_num , upgrade_degrade_num , confirmor , confime_time , deleter , delete_time ) VALUES ("];
    [sql appendFormat:@"%ld",alarmId];
    [sql appendFormat:@"'%@',",moName];
    [sql appendFormat:@"'%@',",local];
    [sql appendFormat:@"%d,",[level intValue]];
    [sql appendFormat:@"'%@',",ip];
    [sql appendFormat:@"'%@',",alarmType];
    [sql appendFormat:@"'%@',",reason];
    [sql appendFormat:@"'%@',",detail];
    [sql appendFormat:@"'%@',",status];
    [sql appendFormat:@"%lld,",[firstTime longLongValue]];
    [sql appendFormat:@"%lld,",[lastTime longLongValue]];
    [sql appendFormat:@"'%@',",trend];
    [sql appendFormat:@"%d,",[count intValue]];
    [sql appendFormat:@"%d,",[upgradeCount intValue]];
    [sql appendFormat:@"'%@',",confirmor];
    [sql appendFormat:@"%lld,",[confirmTime longLongValue]];
    [sql appendFormat:@"'%@',",deleter];
    [sql appendFormat:@"%lld)",[delTime longLongValue]];
    
    if ([db executeUpdate:sql])
    {
        
        result = TRUE;
    }
    else
    {
        result = FALSE;
    }
    
    return result;
}

+ (SAlarm *)getAlarmDetailWithAlarmId:(long)index
{
    SAlarm *alarm = [[SAlarm alloc]init];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSMutableString *selectSql = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM tb_alarm WHERE alarm_id = %ld",index];
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        long alarmId = [rs longForColumnIndex:0];
        alarm.ID = alarmId;
        
        NSString *objectMgt = [rs stringForColumnIndex:1];
        alarm.objectOfManagement = objectMgt;
        
        NSString *loca = [rs stringForColumnIndex:2];
        alarm.location = loca;
        
        NSString *plevel = [rs stringForColumnIndex:3];
        alarm.level = [plevel intValue];
        
        long pResourceId = [rs longForColumnIndex:4];
        alarm.resourceId = pResourceId;
        
        NSString *ip = [rs stringForColumnIndex:5];
        alarm.deviceIp = ip;
        
        NSString *type = [rs stringForColumnIndex:6];
        alarm.resourceType = type;
        
        NSString *reson = [rs stringForColumnIndex:7];
        alarm.reason = reson;
        
        NSString *detail = [rs stringForColumnIndex:8];
        alarm.detailReason = detail;
        
        NSString * status = [rs stringForColumnIndex:9];
        alarm.alarmStatus = status;
        
        double firstT = [rs doubleForColumnIndex:10];
        alarm.firstTime = firstT;
        
        double lastT = [rs doubleForColumnIndex:11];
        alarm.lastTime = lastT;
        
        //        NSString *trend = [rs stringForColumnIndex:12];
        //        self.alarmTrend = trend;
        
        NSInteger repeatNum = [rs intForColumnIndex:13];
        alarm.numOfRepeat = repeatNum;
        
        NSInteger upgradeDegradeNum = [rs intForColumnIndex:14];
        alarm.numOfUpgradeOrDegrada = upgradeDegradeNum;
        
        NSString *tmpconfirmor = [rs stringForColumnIndex:15];
        alarm.confirmor = tmpconfirmor;
        
        double confirmT = [rs doubleForColumnIndex:16];
        alarm.confirmTime = confirmT;
        
        NSString *tmpdeleter = [rs stringForColumnIndex:17];
        alarm.deleter = tmpdeleter;
        
        double deleteT = [rs doubleForColumnIndex:18];
        alarm.deleteTime = deleteT;
        
    }
    
    return alarm;
}

+ (BOOL)updateAlarm:(NSDictionary *)dic
{
    BOOL result;
    
    long alarmId = [[dic objectForKey:@"almId"] longValue];
    NSString *moName = [dic objectForKey:@"moName"];
    NSString *local = [dic objectForKey:@"location"];
    NSNumber *level = [dic objectForKey:@"severity"];
    NSString *ip = [dic objectForKey:@"moIp"];
    NSString *alarmType = [dic objectForKey:@"typeCode"];
    NSString *reason = [dic objectForKey:@"almCause"];
    NSString *detail = [dic objectForKey:@"detail"];
    NSString *status = [dic objectForKey:@"almStatus"];
    NSNumber *firstTime = [dic objectForKey:@"occurTime"];
    NSNumber *lastTime = [dic objectForKey:@"lastTime"];//long
    NSString *trend = [dic objectForKey:@"trend"];
    NSNumber *count = [dic objectForKey:@"count"];//int
    NSNumber *upgradeCount = [dic objectForKey:@"upgradeCount"];//int
    NSString *confirmor = [dic objectForKey:@"confirmUser"];
    NSNumber *confirmTime = [dic objectForKey:@"confirmTime"];//long
    NSString *deleter = [dic objectForKey:@"delUser"];
    NSNumber *delTime = [dic objectForKey:@"delTime"];//long
    NSNumber *resourceId = [dic objectForKey:@"moId"];
    
    SDatabase *db = [SDatabase sharedSingleton];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_alarm SET object_management = \"%@\" , location = \"%@\"  , level = %d , resource_id = \"%ld\", device_ip = \"%@\"  , alarm_type = \"%@\"  , reason = \"%@\", detail = \"%@\" ,alarm_status = \"%@\" , first_time = %lld, last_time = %lld, alarm_trend = \"%@\", repeat_num = %d, upgrade_degrade_num = %d , confirmor = \"%@\", confime_time = %lld, deleter = \"%@\" , delete_time = %lld WHERE alarm_id = %ld",moName,local,[level intValue],[resourceId longValue],ip,alarmType,reason,detail,status,[firstTime longLongValue],[lastTime longLongValue],trend,[count intValue],[upgradeCount intValue],confirmor,[confirmTime longLongValue],deleter,[delTime longLongValue],alarmId];
    
    //    NSLog(@"sql = %@", sql);
    if ([db executeUpdate:sql])
    {
        result = TRUE;
    }
    else
    {
        result = FALSE;
    }
    return result;
}


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
