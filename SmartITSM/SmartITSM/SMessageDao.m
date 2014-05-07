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

+(NSMutableArray *)getMessageList
{
    
    NSMutableArray *messageArray = [[NSMutableArray alloc]init];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *selectSql = @"SELECT message_id,receiver_id,sender,message_text,summary,subject,send_time,receive_time,\
    message_Type,has_top,has_read,marked_Type,has_attachments,has_thumbnailPic,thumbnail_picture FROM tb_message";
    
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
        [messageArray addObject:tmpMessage];
    }
    
    return messageArray;
}

+(BOOL) deleteMessageWithMessageId:(NSString *)index
{
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_message WHERE message_id = ‘%@’",index];
    [db executeUpdate:sql];
    if ([db executeUpdate:sql])
    {
        NSLog(@"delete  a message successed");
        result = TRUE;
    }
    else
    {
        NSLog(@"delete a message failed");
        result = FALSE;
    }
    return result;
}

+ (BOOL)insertMessage:(NSDictionary *)messages
{
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *messageId = [messages objectForKey:@"id"] ;//消息Id
    NSDictionary *senderDic = [messages objectForKey:@"sender"];
    NSString *sender = [senderDic objectForKey:@"xingMing"];//发件人
    NSDictionary *recieverDic = [messages objectForKey:@"reciever"];
    NSInteger recieverId = [[recieverDic objectForKey:@"id"] integerValue];
    NSString *sendTime = [messages objectForKey:@"sendTime"];
    NSString *receiveTime = sendTime;
    NSString *summary = [messages objectForKey:@"title"];
    NSString *content = [messages objectForKey:@"content"];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO  tb_message (message_id,receiver_id,sender,message_Text,summary,send_time,receive_time) VALUES ("];
    [sql appendFormat:@"'%@',",messageId];
    [sql appendFormat:@"%d,",recieverId];
    [sql appendFormat:@"'%@',",sender];
    [sql appendFormat:@"'%@',",content];
    [sql appendFormat:@"'%@',",summary];
    [sql appendFormat:@"'%@',",sendTime];
    [sql appendFormat:@"'%@')",receiveTime];
    
    if ([db executeUpdate:sql]) {
        result = 1;
    }else{
        result = 0;
    }
    return result;
    
}

+ (BOOL) updateMessage:(NSDictionary *)messages
{
    
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    NSString * messageId = [messages objectForKey:@"id"] ;//消息Id
    NSDictionary *senderDic = [messages objectForKey:@"sender"];
    NSString *sender = [senderDic objectForKey:@"xingMing"];//发件人
    NSDictionary *recieverDic = [messages objectForKey:@"reciever"];
    NSInteger recieverId = [[recieverDic objectForKey:@"id"] integerValue];
    NSString *sendTime = [messages objectForKey:@"sendTime"];
    NSString *receiveTime = sendTime;
    NSString *summary = [messages objectForKey:@"title"];
    NSString *content = [messages objectForKey:@"content"];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_message SET message_id = \"%@\",receiver_id = %d,sender = \"%@\",message_Text = \"%@\",summary = \"%@\",send_time = \"%@\",receive_time = \"%@\" where message_id = \"%@\"",messageId,recieverId,sender,content,summary,sendTime,receiveTime,messageId];
    //    NSLog(@"\n%@",sql);
    
    if ([db executeUpdate:sql])
    {
        result = TRUE;
        NSLog(@"update tb_message successed");
        
    }else
    {
        result = FALSE;
        NSLog(@"update tb_message failed");
    }
    return result;
}

+(SMessage *)getMessageDetailById:(NSString *)messageId
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

+ (NSMutableArray *)getMessageListOrderBy:(NSString *)str withMark:(MarkedType )markType
{
    NSMutableArray *messagesArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSMutableString *sql = [[NSMutableString alloc]initWithFormat:@"SELECT message_id,user_name,message_text,receive_time,favorited,thumbnail_pictuer,unread FROM tb_message WHERE marked_type = %d ORDER BY %@ ASC",markType, str];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        NSString *messageId = [rs stringForColumnIndex:0];
        
        NSString *userName = [rs stringForColumnIndex:1];
        
        NSString *messageText = [rs stringForColumnIndex:2];
        
        NSString *receiveTime = [rs stringForColumnIndex:3];
        
        NSString *pictuer = [rs stringForColumnIndex:5];
        
        BOOL unread = [rs boolForColumnIndex:6];
        
        SMessage *tmpMessage = [[SMessage alloc] init];
        [tmpMessage setMessageId:messageId];
        [tmpMessage setSender:userName];
        [tmpMessage setMessageText:messageText];
        [tmpMessage setReceiveTime:receiveTime];
        [tmpMessage setThumbnailPic:pictuer];
        [tmpMessage setHasRead:unread];
        
        [messagesArray addObject:tmpMessage];
    }
    return messagesArray;
}

+ (NSMutableArray *) getMessageListWithMark:(MarkedType )markType
{
    NSMutableArray *messagesArray = [[NSMutableArray alloc] initWithCapacity:10];
    NSString *sql = @"SELECT message_id,sender,message_text,receive_time,hasTop,has_thumbnailPic,hasread FROM tb_message WHERE marked_type = 2";
    //    NSMutableString *sql = [[NSMutableString alloc]initWithFormat:@"SELECT message_id,sender,message_text,receive_time,hasTop,has_thumbnailPic,hasread FROM tb_message WHERE marked_type = %d",markType];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        NSString * messageId = [rs stringForColumnIndex:0];
        
        NSString *userName = [rs stringForColumnIndex:1];
        
        NSString *messageText = [rs stringForColumnIndex:2];
        NSString *receiveTime = [rs stringForColumnIndex:3];
        
        BOOL unread = [rs boolForColumnIndex:6];
        
        SMessage *tmpMessage = [[SMessage alloc] init];
        [tmpMessage setMessageId:messageId];
        [tmpMessage setSender:userName];
        [tmpMessage setMessageText:messageText];
        [tmpMessage setReceiveTime:receiveTime];
        [tmpMessage setHasRead:unread];
        [messagesArray addObject:tmpMessage];
    }
    return messagesArray;
}

+ (BOOL)updateMessageUnread:(BOOL)unread withMessageId:(NSString *)index
{
    BOOL result = FALSE;
    
    SDatabase *db = [SDatabase sharedSingleton];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_message SET has_read = %d WHERE message_id  = '%@'",unread,index];
    
    //    NSLog(@"sql = %@", sql);
    if ([db executeUpdate:sql])
    {
        result = TRUE;
        
        NSLog(@"uddate tb_message successed");
        
    }else
    {
        result = FALSE;
        
        NSLog(@"update tb_message failed");
    }
    
    return result;
}

+ (BOOL)updateMessageTop:(BOOL)top withMessageId:(NSString *)index
{
    BOOL result = FALSE;
    
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_message SET has_top = %d WHERE message_id  = '%@'",top,index];
    
    if ([db executeUpdate:sql])
    {
        result = TRUE;
        
        NSLog(@"uddate tb_message successed");
        
    }else
    {
        result = FALSE;
        
        NSLog(@"update tb_message failed");
    }
    
    return result;
}

@end
