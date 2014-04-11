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

- (void)didConnectServer:(NSInteger)statusCode;

@end

@interface SSigninViewListener : ActionListener

@property (nonatomic, assign) id <SSigninVListenerDelegate> delegate;

- (void)didAction:(CCActionDialect *)dialect;

@end

/**
 * SSigninViewStatusListener
 */

@interface SSigninViewStatusListener : StatusListener

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end