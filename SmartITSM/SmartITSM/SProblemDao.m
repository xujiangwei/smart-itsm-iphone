//
//  SProblemDao.m
//  SmartITOM
//
//  Created by dwg on 13-10-17.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import "SProblemDao.h"
#import "SDatabase.h"

@implementation SProblemDao
@synthesize problemArray;
@synthesize dictionary;

-(id) init
{
    self = [super init];
    if (!self)
    {
        return nil;
    }
    return self;
}


+(NSMutableArray *)getProblemList
{
    NSMutableArray *problemArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"select id,code,state,summary,update_time from tb_problem";
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *problemId=[rs stringForColumnIndex:0];
        NSString *code = [rs stringForColumnIndex:1];
        NSString *state = [rs stringForColumnIndex:2];
        NSString *summary = [rs stringForColumnIndex:3];
        NSString *update_time = [rs stringForColumnIndex:4];
        
        SProblem *tmpProblem = [[SProblem alloc]init];
        [tmpProblem setProblemId:problemId];
        [tmpProblem setCode:code];
        [tmpProblem setState:state];
        [tmpProblem setSummary:summary];
        [tmpProblem setUpdateTime:update_time];
        [problemArray addObject:tmpProblem];
    }
    return problemArray;
}


+(NSMutableArray *)getProblemListOrderBy:(NSInteger)token
{
    NSMutableArray *problemArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *selectSql=[[NSString alloc]init];
    FMResultSet *rs;
    switch(token)
    {
        case 1:
            selectSql=  @"select id,code,state,summary,update_time from tb_problem order by code asc ";
            break;
        case 2:
            selectSql = @"select id,code,state,summary,update_time from tb_problem order by summary desc";
            break;
        case 3:
            selectSql = @"select id,code,state,summary,update_time from tb_problem order by creator desc";
            break;
        case 4:
            selectSql = @"select id,code,state,summary,update_time from tb_problem order by creat_time desc";
            break;
    }
    rs = [db executeQuery:selectSql];
    while ( [rs next])
    {
        NSString *problemId=[rs stringForColumnIndex:0];
        NSString *code = [rs stringForColumnIndex:1];
        NSString *state = [rs stringForColumnIndex:2];
        NSString *summary = [rs stringForColumnIndex:3];
        NSString *update_time = [rs stringForColumnIndex:4];
        SProblem *tmpProblem = [[SProblem alloc]init];
        [tmpProblem setProblemId:problemId];
        [tmpProblem setCode:code];
        [tmpProblem setState:state];
        [tmpProblem setSummary:summary];
        [tmpProblem setUpdateTime:update_time];
        [problemArray addObject:tmpProblem];
    }
    return problemArray;
}


+(NSMutableArray *)getLocalProblemIdList
{
    NSMutableArray *problemIdArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"select id from tb_problem";
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *problemId=[rs stringForColumnIndex:0];
      
        [problemIdArray addObject:problemId];
    }
    return problemIdArray;
}


+(NSMutableArray *) getProblemList:(NSString *)sql
{
    NSMutableArray *problemArray = [[NSMutableArray alloc]initWithCapacity:15];
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    rs = [db executeQuery:sql];
    
    while ( [rs next])
    {
        NSString *problemId=[rs stringForColumnIndex:0];
        NSString *code = [rs stringForColumnIndex:1];
        NSString *state = [rs stringForColumnIndex:2];
        NSString *summary = [rs stringForColumnIndex:3];
        NSString *update_time = [rs stringForColumnIndex:4];
        
        SProblem *tmpProblem = [[SProblem alloc]init];
        [tmpProblem setProblemId:problemId];
        [tmpProblem setCode:code];
        [tmpProblem setState:state];
        [tmpProblem setSummary:summary];
        [tmpProblem setUpdateTime:update_time];
        [problemArray addObject:tmpProblem];
    }
    return problemArray;
    
}


+(NSMutableArray *) search:(NSString *)sql
{
    NSMutableArray *taskArr = [[NSMutableArray alloc] initWithCapacity:5];
    return taskArr;
}


+(SProblem *)getProblemDetailById:(NSString *)problemId
{
    SProblem *problem=[[SProblem alloc]init];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
  
    NSMutableString *selectSql = [[NSMutableString alloc]initWithFormat:@"select id,code,state,summary,description,creator,creat_time,problem_source,category,urgent,impact,service_level,occur_time,find_way,applicant,influencer,update_time from tb_problem where id = %@",problemId];
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *problemId = [rs stringForColumnIndex:0];
        problem.problemId = problemId;
        
        NSString *code = [rs stringForColumnIndex:1];
        problem.code = code;
        
        NSString *state = [rs stringForColumnIndex:2];
        problem.state = state;
        
        NSString *summary = [rs stringForColumnIndex:3];
        problem.summary = summary;
        
        NSString *description = [rs stringForColumnIndex:4];
        problem.description = description;
        
        NSString *creator = [rs stringForColumnIndex:5];
        problem.creator = creator;
        
        NSString *creatTime = [rs stringForColumnIndex:6];
        problem.creatTime = creatTime;
        
        NSString *problemSource = [rs stringForColumnIndex:7];
        problem.problemSource = problemSource;
        
        NSString *category = [rs stringForColumnIndex:8];
        problem.category = category;
        
                
        NSString *urgent = [rs stringForColumnIndex:9];
        problem.urgent = urgent;
        
        NSString *impact = [rs stringForColumnIndex:10];
        problem.impact = impact;
        
        NSString *serviceLevel = [rs stringForColumnIndex:11];
        problem.serviceLevel = serviceLevel;
        
        NSString *occurTime = [rs stringForColumnIndex:12];
        problem.occurTime = occurTime;

        NSString *findType = [rs stringForColumnIndex:13];
        problem.findType = findType;
        
        NSString *applicant = [rs stringForColumnIndex:14];
        problem.applicant = applicant;
        
        NSString *influencer = [rs stringForColumnIndex:15];
        problem.influencer = influencer;
        
        NSString *updateTime = [rs stringForColumnIndex:16];
        problem.updateTime = updateTime;

    }
    return problem;
}


+(BOOL) deleteLocalProblemById:(NSString *)problemId
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_problem WHERE id = \"%@\"",problemId];
    [db executeUpdate:sql];
    if ([db executeUpdate:sql])
    {
        return  TRUE;
    }else
    {
        return  FALSE;
    }
}

+ (BOOL)insert:(NSDictionary *)problemDic
{
    
    BOOL result=TRUE;
    SDatabase *db = [SDatabase sharedSingleton];
    
    SProblem *tmpProblem = [[SProblem alloc]init];
    
    [tmpProblem setProblemId:[problemDic objectForKey:@"id"]];
    [tmpProblem setCode:[problemDic objectForKey:@"code"]];
    [tmpProblem setState:[problemDic objectForKey:@"stateName"]];
    [tmpProblem setSummary:[problemDic objectForKey:@"summary"]];
//    [tmpProblem setCreator:[problemDic objectForKey:@"processors"]];    `
    [tmpProblem setUpdateTime:[problemDic objectForKey:@"updatedOn"]];
     NSMutableString *sql = [NSMutableString stringWithFormat:@"replace into tb_problem (id,code,state,summary,description,creator,creat_time,problem_source,category,urgent,impact,service_level,occur_time,find_way,applicant,influencer,update_time) values ("];
    
    
    [sql appendFormat:@"'%@',",tmpProblem.problemId];
    [sql appendFormat:@"'%@',",tmpProblem.code];
    [sql appendFormat:@"'%@',",tmpProblem.state];
    [sql appendFormat:@"'%@',",tmpProblem.summary];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"'%@',",tmpProblem.creatTime];
    [sql appendFormat:@"%@,",NULL];
  
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"%@,",NULL];
    [sql appendFormat:@"'%@')",tmpProblem.updateTime];
    
    if ([db executeUpdate:sql]) {
        result=TRUE;
    }
    else{
        result=FALSE;
    }
    return result;
}


+ (BOOL) update:(NSDictionary *)problemDic
{
    BOOL result;
    NSNumber *problemId = [problemDic objectForKey:@"id"] ;
    NSNumber *code = [problemDic objectForKey:@"code"] ;
    NSString *state = [problemDic objectForKey:@"state"];
    NSString *summary = [problemDic objectForKey:@"summary"];
    NSString *occurTime = [problemDic objectForKey:@"occurTime"];
    
    SDatabase *db = [SDatabase sharedSingleton];
    //\"%@\"
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_incident SET code = \"%@\",state = \"%@\",summary = \"%@\",occur_time = \"%@\" where id=\"%@\"",code,state,summary,occurTime,problemId];
    
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


+ (NSArray *)getProblemOperation:(SProblem *)problem
{
    NSString *state=problem.state;
    NSMutableArray *operationArray=[[NSMutableArray alloc]init];
    if([state isEqualToString:@"草案"]){
        [operationArray addObject:@"提交"];
    }else if([state isEqualToString:@"已提交"]||[state isEqualToString:@"已退回"]){
        [operationArray addObject:@"拒绝"];
         [operationArray addObject:@"分派"];
    }else if([state isEqual:@"已分派支持人员"]){
        [operationArray addObject:@"退回"];
        [operationArray addObject:@"受理"];
    }else if([state isEqualToString:@"支持人员已受理"]){
        [operationArray addObject:@"处理"];
    }else if([state isEqualToString:@"已诊断"]){
         [operationArray addObject:@"解决"];
    }else if([state isEqualToString:@"已解决"]){
        [operationArray addObject:@"关闭"];
    }else if([state isEqualToString:@"已关闭"]){
        [operationArray addObject:@"评审"];
    }else if([state isEqualToString:@"已拒绝"]){
        [operationArray addObject:@"受理"];
    }else if([state isEqualToString:@"已评审"]){
        [operationArray addObject:nil];
    }
    
    return [operationArray copy];

}

+ (NSString *)getStateIcon:(SProblem *)problem
{
    NSString *state=problem.state;
    
    NSString *stateIcon=[[NSString alloc]init];
    if([state isEqualToString:@"草案"]){
        stateIcon =@"Images/inct_state_indraft.png";
    }else if([state isEqualToString:@"已提交"]){
        stateIcon =@"Images/inct_state_submitted.png";
    }else if([state isEqual:@"支持人员已受理"]){
        stateIcon =@"Images/inct_state_sdaccept.png";
    }else if([state isEqualToString:@"已分派支持人员"]){
        stateIcon =@"Images/inct_state_ transmitfl.png";
    }else if([state isEqualToString:@"已退回"]){
        stateIcon =@"Images/inct_state_flreturn.png";
    }else if([state isEqualToString:@"已诊断"]){
        stateIcon =@"Images/inct_state_transmitsl.png";
    }else if([state isEqualToString:@"已解决"]){
        stateIcon =@"Images/inct_state_solved.png";
    }else if([state isEqualToString:@"已拒绝"]){
        stateIcon =@"Images/inct_state_flreturn.png";
    }else if([state isEqualToString:@"已关闭"]){
        stateIcon =@"Images/inct_state_closed.png";
    }else if([state isEqualToString:@"已评审"]){
        stateIcon =@"Images/inct_state_solved.png";
    }
    return stateIcon;
}


+ (NSString *)getProblemSource:(NSInteger )source
{
    NSString *value=nil;
    switch(source)
    {
        case 1:
            value= @"服务台";
            break;
        case 2:
            value= @"事件管理";
            break;
        case 3:
            value= @"故障管理";
            break;
        case 4:
            value =@"主动问题管理";
            break;
        case 5:
            value =@"供应商与合同管理";
            break;
        }
    return value;
}

@end
