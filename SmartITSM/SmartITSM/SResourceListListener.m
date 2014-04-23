//
//  SResourceListListener.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-23.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SResourceListListener.h"


@implementation SResourceListListener

@synthesize delegate;

- (void)didAction:(CCActionDialect *)dialect
{
    if ([dialect.action isEqualToString:@"requestDevice"])
    {
        NSString *jsonStr = [dialect getParamAsString:@"data"];
        NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (nil != delegate && [delegate respondsToSelector:@selector(updateResourceList:)])
        {
            [delegate updateResourceList:jsonDic ];
        }
        
    }
    
}

@end



/*
 * SResourceListStatusListener
 */
@implementation SResourceListStatusListener

- (void)didConnected:(NSString *)identifier
{
//    if (nil != delegate && [delegate respondsToSelector:@selector(didConnected:)])
//    {
//        [delegate didConnected:identifier ];
//    }
}

- (void)didDisconnected:(NSString *)identifier
{
    
}

- (void)didFailed:(NSString *)identifier failure:(Failure *)failure
{
//    if (nil != delegate && [delegate respondsToSelector:@selector(didFailed:)])
//    {
//        [delegate didFailed:identifier ];
//    }
}

@end