//
//  SMessageDao.m
//  SmartITSM
//
//  Created by Apple Developer on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageDao.h"
#import "SDatabase.h"

@implementation SMessageDao


-(id) init{
    
    self = [super init];
    if (!self)
    {
        return nil;
    }
    
    return self;
}

+(NSMutableArray *)getTaskList{
    
    NSMutableArray *taskArray = [[NSMutableArray alloc]init];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"select message_id,sender,message_Text,summary,send_time from tb_message";
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *messageId=[rs stringForColumnIndex:0];
        NSString *sender = [rs stringForColumnIndex:1];
        NSString *messageText = [rs stringForColumnIndex:2];
        NSString *summary = [rs stringForColumnIndex:3];
        NSString *sendTime = [rs stringForColumnIndex:4];
        
        SMessage *tmpMessage = [[SMessage alloc]init];
        [tmpMessage setMessageId:messageId];
        [tmpMessage setSender:sender];
        [tmpMessage setMessageText:messageText];
        [tmpMessage setSummary:summary];
        [tmpMessage setSendTime:sendTime];
        [taskArray addObject:tmpMessage];
    }
    
    return taskArray;
}




@end
