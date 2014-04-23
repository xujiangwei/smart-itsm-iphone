//
//  SResourceListListener.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-23.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"
#import "StatusListener.h"

@protocol SResourceListListenerDelegate <NSObject>

- (void)updateResourceList:(NSDictionary *)dic;

@end

@interface SResourceListListener : ActionListener

@property (nonatomic, assign) id<SResourceListListenerDelegate> delegate;

- (void)didAction:(CCActionDialect *)dialect;

@end


/*
 * SResourceListStatusListener
 */
@interface SResourceListStatusListener : StatusListener

- (void)didConnected:(NSString *)identifier;

- (void)didDisconnected:(NSString *)identifier;

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end