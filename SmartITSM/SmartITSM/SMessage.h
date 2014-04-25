//
//  SMessage.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SMessage : NSObject

typedef enum _MarkedType
{
    Inbox  = 1,            //收件箱 1
    Outbox = 1 <<1,        //发件箱 2
    Dustbin = 1 << 2,      //垃圾箱 4
    Emphasis = 1 << 3,     //重要   8
    Sticky  = 1 << 4,      //置顶   16
    SystemAlarm = 1 << 5,  //系统告警 32
    Event = 1 << 6         //事件    64
} MarkedType;

@property (nonatomic, strong) NSString *messageId;//消息id
@property (nonatomic, strong) NSString *receiverId;//接收人
@property (nonatomic, strong) NSString *sender;//发件人
@property (nonatomic, strong) NSString *messageText;//消息内容
@property (nonatomic, strong) NSString *summary;//摘要
@property (nonatomic, strong) NSString *subject;//主题
@property (nonatomic, strong) NSString *sendTime;//发送时间
@property (nonatomic, strong) NSString *receiveTime;//接收时间
@property (nonatomic, strong) NSString *messageType;//消息类型
@property (nonatomic, assign) BOOL      hasTop;//是否置顶
@property (nonatomic, assign) BOOL      hasRead;//是否已读
@property (nonatomic, assign) MarkedType   markedType;//标签
@property (nonatomic, assign) BOOL      hasAttachments;//是否有附件
@property (nonatomic, assign) BOOL      hasThumbnailPic;//是否有缩略图
@property (nonatomic, strong) NSString *thumbnailPic;//缩略图


@end
