//
//  SMessageDao.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMessage.h"

@interface SMessageDao : NSObject

-(id) init;

//消息列表获取数据
+(NSMutableArray *)getMessageList;

//删除数据
+(BOOL) deleteMessageWithMessageId:(NSString *)index;

//插入数据
+ (BOOL)insertMessage:(NSDictionary *)messages;

//更新数据
+ (BOOL) updateMessage:(NSDictionary *)messagesDic;

//通过消息ID获取详细内容
+(SMessage *)getMessageDetailById:(NSString *)messageId;

//排序
+ (NSMutableArray *)getMessageListOrderBy:(NSString *)str withMark:(MarkedType )markType;

//消息MarkedType切换 已调测
+ (NSMutableArray *) getMessageListWithMark:(MarkedType )markType;

//更新未读消息
+ (BOOL)updateMessageUnread:(BOOL)unread withMessageId:(NSString *)index;

//更新置顶消息
+ (BOOL)updateMessageTop:(BOOL)top withMessageId:(NSString *)index;
@end
