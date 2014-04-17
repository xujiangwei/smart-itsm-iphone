//
//  SMessage.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface SMessage : NSObject

@property (nonatomic, strong) NSString *messageId;
@property (nonatomic, strong) NSString *receiverId;
@property (nonatomic, strong) NSString *sender;
@property (nonatomic, strong) NSString *messageText;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *subject;
@property (nonatomic, strong) NSString *sendTime;
@property (nonatomic, strong) NSString *receiveTime;

@end
