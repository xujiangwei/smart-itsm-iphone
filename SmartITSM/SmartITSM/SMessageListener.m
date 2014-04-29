//
//  SMessageListener.m
//  SmartITSM
//
//  Created by Apple Developer on 14-4-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageListener.h"

@implementation SMessageListener

@synthesize delegate;

- (void)didAction:(CCActionDialect *)dialect
{
    if ([dialect.action isEqualToString:@"requestMessages"])
    {
        NSString *jsonStr = [dialect getParamAsString:@"data"];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (nil != delegate && [delegate respondsToSelector:@selector(updateMessages:)])
        {
            [delegate updateMessages:jsonDic];
        }
    }
}

@end

/*
 *
 * SMessageStatusListener
 *
 */

@implementation SMessageStatusListener

@synthesize delegate;

/** 当连接建立时，该方法被调用。
 */
- (void)didConnected:(NSString *)identifier
{
    
}


/** 当连接断开时，该方法被调用。
 */
- (void)didDisconnected:(NSString *)identifier
{
    
}


/** 当发生故障时，该方法被调用。
 */
- (void)didFailed:(NSString *)identifier failure:(Failure *)failure
{
    if (nil != delegate && [delegate respondsToSelector:@selector(didFailed:)])
    {
        [delegate didFailed:identifier ];
    }
}

@end
