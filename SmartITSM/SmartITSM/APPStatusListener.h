//
//  APPStatusListener.h
//  SmartITSM
//
//  Created by 朱国强 on 14-2-18.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "StatusListener.h"

@interface APPStatusListener : StatusListener

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
