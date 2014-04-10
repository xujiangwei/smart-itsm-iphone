//
//  SSigninViewListener.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-10.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"
#import "StatusListener.h"

@interface SSigninViewListener : ActionListener

- (void)didAction:(CCActionDialect *)dialect;

@end

/**
 * SSigninViewStatusListener
 */

@interface SSigninViewStatusListener : StatusListener

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end