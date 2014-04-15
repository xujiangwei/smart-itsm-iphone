//
//  SSigninViewListener.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-10.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SSigninViewListener.h"

@implementation SSigninViewListener

@synthesize delegate;

- (void)didAction:(CCActionDialect *)dialect
{
    if ([dialect.action isEqualToString:@"login"])
    {
        NSString *jsonStr = [dialect getParamAsString:@"data"];
        NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (nil != delegate && [delegate respondsToSelector:@selector(didSignin:)])
        {
            [delegate didSignin:jsonDic ];
        }
   
    }
    
    else if([dialect.action isEqualToString:@"connectionCheck"])
    {
        NSString *jsonStr = [dialect getParamAsString:@"data"];
        NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        NSInteger statusCode = [[jsonDic objectForKey:@"status"] integerValue];
        
        if (nil != delegate && [delegate respondsToSelector:@selector(didConnectServer:)])
        {
            [delegate didConnectServer:statusCode ];
        }
    }
}

@end


/**
 * SSigninViewStatusListener
 */

@implementation SSigninViewStatusListener

@synthesize delegate;

- (void)didConnected:(NSString *)identifier
{
    if (nil != delegate && [delegate respondsToSelector:@selector(didConnected:)])
    {
        [delegate didConnected:identifier ];
    }
}

- (void)didDisconnected:(NSString *)identifier
{
    
}

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure
{
    
}

@end