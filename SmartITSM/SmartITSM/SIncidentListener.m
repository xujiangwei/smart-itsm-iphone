//
//  SIncidentListener.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SIncidentListener.h"

@implementation SIncidentListener

@synthesize delegate;

- (void)didAction:(CCActionDialect *)dialect
{
    
    if ([dialect.action isEqualToString:@"requestIncidentList"])
    {
        NSString *jsonStr = [dialect getParamAsString:@"data"];
        NSData * data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (nil != delegate && [delegate respondsToSelector:@selector(didRequestIncidentList:)])
        {
            [delegate didRequestIncidentList:jsonDic];
        }

    }
}

@end
