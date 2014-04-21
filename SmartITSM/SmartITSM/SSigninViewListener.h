//
//  SSigninViewListener.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-10.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"
#import "StatusListener.h"

@protocol SSigninVListenerDelegate <NSObject>

- (void)didSignin:(NSDictionary *)dic;

@end

@interface SSigninViewListener : ActionListener

@property (nonatomic, assign) id <SSigninVListenerDelegate> delegate;

- (void)didAction:(CCActionDialect *)dialect;

@end

/**
 * SSigninViewStatusListener
 */

@protocol SSigninVStatusListenerDelegate <NSObject>

- (void)didConnected:(NSString *)identifier;

- (void)didFailed:(NSString *)identifier;

@end

@interface SSigninViewStatusListener : StatusListener

@property (nonatomic, assign) id<SSigninVStatusListenerDelegate> delegate;

- (void)didConnected:(NSString *)identifier;

- (void)didDisconnected:(NSString *)identifier;

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end