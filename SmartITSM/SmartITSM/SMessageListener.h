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


@protocol SMessageStatusListenerDelegate <NSObject>

- (void)didFailed:(NSString *)identifier;

@end

@interface SMessageStatusListener : StatusListener

@property (nonatomic, assign)id <SMessageStatusListenerDelegate> delegate;

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end