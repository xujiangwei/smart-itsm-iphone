//
//  DHTaskDao.m
//  SmartITOM
//
//  Created by dwg on 13-6-24.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

//6667101473336
#import "STaskDao.h"
#import "SDatabase.h"
#import "SIncident.h"

@implementation STaskDao

@synthesize taskArray;
@synthesize dictionary;


-(id) init{
    
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    return self;
    
}

+(NSMutableArray *)getTaskList{
    
    NSMutableArray *taskArray = [[NSMutableArray alloc]initWithCapacity:15];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
       NSString *selectSql = @"select id,code,state,summary,update_time from tb_incident";
    
    rs = [db executeQuery:selectSql];
  
    while ( [rs next])
    {
            NSString *incidentId=[rs stringForColumnIndex:0];
            NSString *code = [rs stringForColumnIndex:1];
            NSString *state = [rs stringForColumnIndex:2];
            NSString *summary = [rs stringForColumnIndex:3];
            NSString *update_time = [rs stringForColumnIndex:4];
        
        SIncident *tmpIncident = [[SIncident alloc]init];
        [tmpIncident setIncidentId:incidentId];
        [tmpIncident setCode:code];
        [tmpIncident setState:state];
        [tmpIncident setSummary:summary];
        [tmpIncident setUpdateTime:update_time];
        [taskArray addObject:tmpIncident];
    }
   
    return taskArray;
}


+(NSMutableArray *)getTaskListOrderBy:(NSInteger)token
{
    NSMutableArray *taskArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *selectSql=[[NSString alloc]init];
    FMResultSet *rs;
    switch(token)
    {
        case 1:
            selectSql=  @"select id,code,state,summary,update_time from tb_incident order by code asc";
            break;
        case 2:
            selectSql = @"select id,code,state,summary,update_time from tb_incident order by summary desc";
            break;
        case 3:
            selectSql = @"select id,code,state,summary,update_time from tb_incident order by update_time desc";
            break;
    }
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *incidentId=[rs stringForColumnIndex:0];
        NSString *code = [rs stringForColumnIndex:1];
        NSString *state = [rs stringForColumnIndex:2];
        NSString *summary = [rs stringForColumnIndex:3];
        NSString *update_time = [rs stringForColumnIndex:4];
        
        SIncident *tmpIncident = [[SIncident alloc]init];
        [tmpIncident setIncidentId:incidentId];
        [tmpIncident setCode:code];
        [tmpIncident setState:state];
        [tmpIncident setSummary:summary];
        [tmpIncident setUpdateTime:update_time];
        [taskArray addObject:tmpIncident];
    }
    
    return taskArray;
    
    
}

+(NSMutableArray *)getLocalIncidentIdList
{
    NSMutableArray *incidentIdArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"select id from tb_incident";
    rs = [db executeQuery:selectSql];
    while ( [rs next])
    {
        NSString *incidentId=[rs stringForColumnIndex:0];
        [incidentIdArray addObject:incidentId];
    }
    return incidentIdArray;
}

+(NSMutableArray *) getTaskList:(NSString *)sql{
    
    NSMutableArray *taskArr = [[NSMutableArray alloc] initWithCapacity:5];
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    rs = [db executeQuery:sql];
    while ([rs next])
    {
        NSString *code = [rs stringForColumnIndex:0];
        NSString *state = [rs stringForColumnIndex:1];
        NSString *summary = [rs stringForColumnIndex:2];
        NSString *update_time = [rs stringForColumnIndex:3];
        SIncident *incident = [[SIncident alloc] init];
        [incident setCode:code];
        [incident setState:state];
        [incident setSummary:summary];
        [incident setUpdateTime:update_time];
        [taskArr addObject:incident];
    }
    return taskArr;
    
}


+(NSMutableArray *) search:(NSString *)sql{
     NSMutableArray *taskArr = [[NSMutableArray alloc] initWithCapacity:5];
    return taskArr;
}

+(SIncident *)getIncidentDetailWithId:(NSString *)incidentId
{
    SIncident *incident=[[SIncident alloc]init];
        
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSMutableString *selectSql = [[NSMutableString alloc]initWithFormat:@"select * from tb_incident where id = %@",incidentId];
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *incId = [rs stringForColumnIndex:0];
        incident.incidentId = incId;
        
        NSString *code = [rs stringForColumnIndex:1];
        incident.code = code;
        
        NSString *state = [rs stringForColumnIndex:2];
        incident.state = state;
        
        NSString *summary = [rs stringForColumnIndex:3];
        incident.summary = summary;
        
        NSString *description = [rs stringForColumnIndex:4];
        incident.description = description;
        
        NSString *applicant = [rs stringForColumnIndex:5];
        incident.applicant = applicant;

        NSString *creator = [rs stringForColumnIndex:6];
        incident.creator = creator;

//        NSString *closeTime = [rs stringForColumnIndex:7];
//        incident.closeTime = closeTime;

        NSString *contact = [rs stringForColumnIndex:8];
        incident.contact = contact;

        NSString *urgent = [rs stringForColumnIndex:9];
        incident.urgent = urgent;

        NSString *impact = [rs stringForColumnIndex:10];
        incident.impact = impact;
        
        NSString *serviceLevel = [rs stringForColumnIndex:11];
        incident.serviceLevel = serviceLevel;
        
        NSString *category = [rs stringForColumnIndex:12];
        incident.category = category;
        
        NSString *influencer = [rs stringForColumnIndex:13];
        incident.influencer = influencer;
        
        NSString *occurTime = [rs stringForColumnIndex:14];
        incident.occurTime = occurTime;
        
        NSString *replyMode = [rs stringForColumnIndex:15];
        incident.replyMode = replyMode;
        
//        BOOL*isMajor = [rs stringForColumnIndex:16];
//        incident.isMajor = isMajor;
        
        NSString *reportWays = [rs stringForColumnIndex:17];
        incident.reportWays = reportWays;
        
        NSString *createTime = [rs stringForColumnIndex:18];
        incident.creatTime = createTime;

        NSString *updateTime = [rs stringForColumnIndex:19];
        incident.updateTime = updateTime;

        
       
    }
        return incident;
}


+(BOOL) deleteLocalIncidentById:(NSString *)incidentId
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_incident WHERE id = \"%@\"",incidentId];
    [db executeUpdate:sql];
    if ([db executeUpdate:sql])
    {
        return  TRUE;
    }else
    {
        return  FALSE;
    }
}


+ (BOOL)insert:(NSDictionary *)incidentDic{
    BOOL result=TRUE;
    SDatabase *db = [SDatabase sharedSingleton];
    
    SIncident *tmpIncident = [[SIncident alloc]init];
    
    [tmpIncident setIncidentId:[incidentDic objectForKey:@"id"]];
    [tmpIncident setCode:[incidentDic objectForKey:@"code"]];
    [tmpIncident setState:[incidentDic objectForKey:@"stateName"]];
    [tmpIncident setSummary:[incidentDic objectForKey:@"summary"]];
    [tmpIncident setCreatTime:[incidentDic objectForKey:@"createdOn"]];
    [tmpIncident setUpdateTime:[incidentDic objectForKey:@"updatedOn"]];
     NSMutableString *sql = [NSMutableString stringWithFormat:@"replace into tb_incident (id,code,state,summary,description,applicant,creator,close_time,contact,urgent,impact,service_level,category,influencer,occur_time,reply_mode,is_major,report_ways,creat_time,update_time) VALUES ("];
   
    [sql appendFormat:@"'%@',",tmpIncident.incidentId];
    [sql appendFormat:@"'%@',",tmpIncident.code];
    [sql appendFormat:@"'%@',",tmpIncident.state];
    [sql appendFormat:@"'%@',",tmpIncident.summary];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];

    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];

    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];

    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"'%@',",tmpIncident.creatTime];
    [sql appendFormat:@"'%@')",tmpIncident.updateTime];

    if ([db executeUpdate:sql]) {
        result=TRUE;
    }
    else{
        result=FALSE;
    }

    return result;
}



+ (BOOL) update:(NSDictionary *)incidentDic{
    BOOL result;
    NSString *incidentId= [incidentDic objectForKey:@"id"];
    NSNumber *code = [incidentDic objectForKey:@"code"] ;
    NSString *state = [incidentDic objectForKey:@"stateName"];
    NSString *summary = [incidentDic objectForKey:@"summary"];
    NSString *updateTime = [incidentDic objectForKey:@"updatedOn"];
    
    SDatabase *db = [SDatabase sharedSingleton];
    //\"%@\"
    NSMutableString *sql = [NSMutableString stringWithFormat:@"update tb_incident SET code = \"%@\",state = \"%@\",summary = \"%@\",update_time = \"%@\" WHERE id=\"%@",code,state,summary,updateTime,incidentId];
    
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



+(NSArray *)getTaskOperation:(SIncident *)incident{
    NSString *state=incident.state;
    
    NSMutableArray *operationArray=[[NSMutableArray alloc]init];
    if([state rangeOfString:@"草案"].length>0){
        [operationArray addObject:@"提交"];
    }else if([state rangeOfString:@"提交"].length>0){
        [operationArray addObject:@"受理"];
    }else if([state isEqual:@"服务台已受理"]){
        [operationArray addObject:@"退回"];
        [operationArray addObject:@"解决"];
        [operationArray addObject:@"转派一线"];
    }else if([state isEqualToString:@"已转派一线"]){
        [operationArray addObject:@"受理"];
    }else if([state isEqualToString:@"一线已受理"]){
        [operationArray addObject:@"退回"];
        [operationArray addObject:@"解决"];
        [operationArray addObject:@"转派二线"];
    }else if([state rangeOfString:@"退回"].length>0){
        [operationArray addObject:@"受理"];
    }else if([state rangeOfString:@"转派二线"].length>0){
        [operationArray addObject:@"受理"];
    }else if([state isEqualToString:@"二线已受理"]){
        [operationArray addObject:@"退回"];
        [operationArray addObject:@"解决"];
    }else if([state rangeOfString:@"解决"].length>0){
        [operationArray addObject:@"回访"];
    }else if([state rangeOfString:@"回访"].length>0){
        [operationArray addObject:@"受理"];
        [operationArray addObject:@"关闭"];
    }else if([state isEqualToString:@"关闭"]){
        [operationArray addObject:@"评价"];
    }
    
    return [operationArray copy];
    
}

+(NSString *)getIncidentReportWay:(NSInteger )way
{
    NSString *value=nil;
    switch(way)
    {
        case 1:
                value= @"电话";
                break;
        case 2:
                value= @"短信";
                break;
        case 3:
                value= @"邮件";
                break;
        case 4:
                value =@"自服务台";
                break;
        case 5:
                value =@"其他";
                break;
        case 6:
                value =@"监控工具";
                break;
    }
    return value;
}



+(NSString *)getStateIcon:(SIncident *)incident{
    NSString *state=incident.state;
    
    NSString *stateIcon=[[NSString alloc]init];
    if([state rangeOfString:@"草案"].length>0){
        stateIcon =@"Images/inct_state_indraft.png";
    }else if([state rangeOfString:@"提交"].length>0){
        stateIcon =@"Images/inct_state_submitted.png";
    }else if([state isEqual:@"服务台已受理"]){
        stateIcon =@"Images/inct_state_sdaccept.png";
    }else if([state rangeOfString:@"转派一线"].length>0){
        stateIcon =@"Images/inct_state_ transmitfl.png";
    }else if([state rangeOfString:@"一线已受理"].length>0){
        stateIcon =@"Images/inct_state_flaccept.png";
    }else if([state isEqualToString:@"一线已退回"]){
        stateIcon =@"Images/inct_state_flreturn.png";
    }else if([state isEqualToString:@"已转派二线"]){
        stateIcon =@"Images/inct_state_transmitsl.png";
    }else if([state isEqualToString:@"二线已受理"]){
        stateIcon =@"Images/inct_state_slaccept.png";
    }else if([state rangeOfString:@"解决"].length>0){
        stateIcon =@"Images/inct_state_solved.png";
    }else if([state rangeOfString:@"退回"].length>0){
        stateIcon =@"Images/inct_state_slreturn.png";
    } else if([state isEqualToString:@"已回访"]){
        stateIcon =@"Images/inct_state_feedbacked.png";
    }else if([state isEqualToString:@"已关闭"]){
        stateIcon =@"Images/inct_state_closed.png";
    }
    return stateIcon;
}



@end
