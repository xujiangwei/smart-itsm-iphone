//
//  SMessageListener.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"
#import "StatusListener.h"

@protocol SMessageListenerDelegate <NSObject>

- (void)updateMessages:(NSDictionary *)dic;

@end

@interface SMessageListener : ActionListener

@property (nonatomic, assign) id <SMessageListenerDelegate> delegate;

- (void)didAction:(CCActionDialect *)dialect;

@end


/*
 *
 * SMessageStatusListener
 *
 */

@protocol SMessageStatusListenerDelegate <NSObject>

- (void)didFailed:(NSString *)identifier;

@end

@interface SMessageStatusListener : StatusListener

@property (nonatomic, assign)id <SMessageStatusListenerDelegate> delegate;

/** 当连接建立时，该方法被调用。
 */
- (void)didConnected:(NSString *)identifier;


/** 当连接断开时，该方法被调用。
 */
- (void)didDisconnected:(NSString *)identifier;


/** 当发生故障时，该方法被调用。
 */
- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end