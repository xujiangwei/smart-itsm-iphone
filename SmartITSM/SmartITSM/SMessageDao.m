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
    
    NSString *selectSql = @"SELECT message_id,receiver_id,sender,message_text,summary,subject,send_time,receive_time,\
    message_Type,has_top,has_read,marked_Type,has_attachments,has_thumbnailPic,thumbnail_picture FROM tb_message";
//    NSLog(@"sql = \n%@",selectSql);
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *messageId=[rs stringForColumnIndex:0];
        NSString *sender = [rs stringForColumnIndex:2];
        NSString *messageText = [rs stringForColumnIndex:3];
        NSString *summary = [rs stringForColumnIndex:4];
        NSString *sendTime = [rs stringForColumnIndex:6];
        BOOL hasTop = [rs boolForColumnIndex:9];
        BOOL hasRead = [rs boolForColumnIndex:10];
        
        SMessage *tmpMessage = [[SMessage alloc]init];
        [tmpMessage setMessageId:messageId];
        [tmpMessage setSender:sender];
        [tmpMessage setMessageText:messageText];
        [tmpMessage setSummary:summary];
        [tmpMessage setSendTime:sendTime];
        [tmpMessage setHasTop:hasTop];
        [tmpMessage setHasRead:hasRead];
        [taskArray addObject:tmpMessage];
    }
    
    return taskArray;
}

+(SMessage *)getMessageTaskDetailById:(NSString *)messageId
{
    SMessage *message=[[SMessage alloc]init];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSMutableString *selectSql = [[NSMutableString alloc]initWithFormat:@"SELECT * FROM tb_message where message_id = '%@'",messageId];
    
    rs = [db executeQuery:selectSql];
    
    while ( [rs next])
    {
        NSString *messageId = [rs stringForColumnIndex:0];
        message.messageId = messageId;

        NSString *receiverId = [rs stringForColumnIndex:1];
        message.receiverId = receiverId;
        
        NSString *sender = [rs stringForColumnIndex:2];
        message.sender = sender;
        
        NSString *messageText = [rs stringForColumnIndex:3];
        message.messageText = messageText;
        
        NSString *summary = [rs stringForColumnIndex:4];
        message.summary = summary;
        
        NSString *subject = [rs stringForColumnIndex:5];
        message.subject = subject;
        
        NSString *sendTime = [rs stringForColumnIndex:6];
        message.sendTime = sendTime;
        
        NSString *receiveTime = [rs stringForColumnIndex:7];
        message.receiveTime = receiveTime;
        
        NSString *messageType = [rs stringForColumnIndex:8];
        message.messageType = messageType;
        
        BOOL hasTop = [rs boolForColumnIndex:9];
        message.hasTop = hasTop;
        
        BOOL hasRead = [rs boolForColumnIndex:10];
        message.hasRead = hasRead;
        
    }
    return message;
    
}


@end
