//
//  SInspectionDao.m
//  SmartITOM
//
//  Created by dwg on 13-11-20.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import "SInspectionDao.h"
#import "SDatabase.h"

@implementation SInspectionDao

-(id) init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    return self;
}

+(NSMutableArray *)getInspectionTaskList
{
    NSMutableArray *inspectionArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"select id,name,status,start_time from tb_inspection";
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *inspectionId=[rs stringForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        NSString *status = [rs stringForColumnIndex:2];
        NSString * startTime= [rs stringForColumnIndex:3];
        
        SInspection *tmpInspection = [[SInspection alloc]init];
        [tmpInspection setInspectionId:inspectionId];
        [tmpInspection setName:name];
        [tmpInspection setStatus:status];
        [tmpInspection setStartTime:startTime];
        [inspectionArray addObject:tmpInspection];
    }
    return inspectionArray;
}


+(NSMutableArray *)getInspectionTaskList:(NSString *)sql
{
    NSMutableArray *inspectionArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    rs = [db executeQuery:sql];
    while ( [rs next])
    {
        NSString *inspectionId=[rs stringForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        NSString *status = [rs stringForColumnIndex:2];
        NSString * startTime= [rs stringForColumnIndex:3];
        
        SInspection *tmpInspection = [[SInspection alloc]init];
        [tmpInspection setInspectionId:inspectionId];
        [tmpInspection setName:name];
        [tmpInspection setStatus:status];
        [tmpInspection setStartTime:startTime];
        [inspectionArray addObject:tmpInspection];
    }
    return inspectionArray;
}


+(NSMutableArray *)getLocalInspectionIdList
{
    NSMutableArray *inspectionIdArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"select id from tb_inspection";
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *inspectionId=[rs stringForColumnIndex:0];
        
        [inspectionIdArray addObject:inspectionId];
    }
    return inspectionIdArray;
}


+(NSMutableArray *)getInspectionTaskListOrderBy:(NSInteger)token
{
    NSMutableArray *inspectionArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *selectSql=[[NSString alloc]init];
    FMResultSet *rs;
    switch(token)
    {
        case 1:
            selectSql=  @"select id,name,status,start_time from tb_inspection order by start_time asc";
            break;
        case 2:
            selectSql = @"select id,name,status,start_time from tb_inspection order by name ";
            break;
        default:
            break;
    }
    rs = [db executeQuery:selectSql];
    while ( [rs next])
    {
        NSString *inspectionId=[rs stringForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        NSString *status = [rs stringForColumnIndex:2];
        NSString * startTime= [rs stringForColumnIndex:3];
        
        SInspection *tmpInspection = [[SInspection alloc]init];
        [tmpInspection setInspectionId:inspectionId];
        [tmpInspection setName:name];
        [tmpInspection setStatus:status];
        [tmpInspection setStartTime:startTime];
        [inspectionArray addObject:tmpInspection];
    }
    return inspectionArray;
}


+(SInspection *)getInspectionTaskDetailById:(NSString *)inspectionId
{
    SInspection *inspection=[[SInspection alloc]init];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSMutableString *selectSql = [[NSMutableString alloc]initWithFormat:@"select id,name,status,description,executor,principal,memo,start_time,end_time from tb_inspection where id = %@",inspectionId];
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *inspectionId = [rs stringForColumnIndex:0];
        inspection.inspectionId = inspectionId;
        
        NSString *name = [rs stringForColumnIndex:1];
        inspection.name = name;
        
        NSString *status = [rs stringForColumnIndex:2];
        inspection.status = status;
        
        NSString *description = [rs stringForColumnIndex:3];
        inspection.description = description;
        
        NSString *executor = [rs stringForColumnIndex:4];
        inspection.executor = executor;
        
        NSString *principal = [rs stringForColumnIndex:5];
        inspection.principal = principal;
        
        NSString *memo = [rs stringForColumnIndex:6];
        inspection.memo = memo;
        
        NSString *startTime = [rs stringForColumnIndex:7];
        inspection.startTime = startTime;
        
        NSString *endTime = [rs stringForColumnIndex:8];
        inspection.endTime = endTime;
    }
    return inspection;
    
}

+(BOOL) deleteLocalInspectionById:(NSString *)inspectionId
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_inspection WHERE id = \"%@\"",inspectionId];
    [db executeUpdate:sql];
    if ([db executeUpdate:sql])
    {
        return  TRUE;
    }else
    {
        return  FALSE;
    }
}


+ (BOOL)insert:(NSDictionary *)inspectionDic
{
    BOOL result=TRUE;
    SDatabase *db = [SDatabase sharedSingleton];
    
    SInspection *tmpInspection = [[SInspection alloc]init];
    
    [tmpInspection setInspectionId:[inspectionDic objectForKey:@"id"]];
    [tmpInspection setName:[inspectionDic objectForKey:@"name"]];
    [tmpInspection setStatus:[inspectionDic objectForKey:@"status"]];
    [tmpInspection setDescription:[inspectionDic objectForKey:@"description"]];
    [tmpInspection setMemo:[inspectionDic objectForKey:@"memo"]];
    [tmpInspection setExecutor:[[inspectionDic objectForKey:@"executor"] objectForKey:@"xingMing"]];
    [tmpInspection setPrincipal:[inspectionDic objectForKey:@"principal"]];
    [tmpInspection setStartTime:[inspectionDic objectForKey:@"startTime"]];
    [tmpInspection setEndTime:[inspectionDic objectForKey:@"endTime"]];

    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"replace into tb_inspection (id,name,status,description,executor,principal,memo,start_time,end_time) VALUES ("];
    
    [sql appendFormat:@"'%@',",tmpInspection.inspectionId];
    [sql appendFormat:@"'%@',",tmpInspection.name];
    [sql appendFormat:@"'%@',",tmpInspection.status];
    [sql appendFormat:@"'%@',",tmpInspection.description];
    [sql appendFormat:@"'%@',",tmpInspection.executor];
    [sql appendFormat:@"'%@',",tmpInspection.principal];
    [sql appendFormat:@"'%@',",tmpInspection.memo];
    [sql appendFormat:@"'%@',",tmpInspection.startTime];
    [sql appendFormat:@"'%@')",tmpInspection.endTime];
      
    if ([db executeUpdate:sql]) {
        result=TRUE;
    }
    else{
        result=FALSE;
    }
    return result;
    
}

+ (BOOL) update:(NSDictionary *)inspectionDic
{
    BOOL result;
    
    NSNumber *name = [inspectionDic objectForKey:@"name"] ;
    NSString *statue = [inspectionDic objectForKey:@"status"];
    NSString *startTime =[inspectionDic objectForKey:@"startTime"];
    
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_inspection SET name = \"%@\",status = \"%@\",startTime = \"%@\"",name,statue,startTime];
    
    NSLog(@"sql = %@",sql);
    if ([db executeUpdate:sql])
    {
        result = TRUE;
    }else
    {
        result = FALSE;
    }
    return result;
    
}

@end
