//
//  SAlarmViewListener.m
//  SmartITSM
//
//  Created by Apple001 on 14-4-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SAlarmViewListener.h"


@implementation SAlarmViewListener

@synthesize delegate;

-(void)didAction:(CCActionDialect *)dialect
{
    if ([dialect.action isEqualToString:@"requestAlarmList"])
    {
        NSString *jsonStr = [dialect getParamAsString:@"data"];
        NSData *data = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *jsonDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (nil != delegate && [delegate respondsToSelector:@selector(loadAlarmList:)])
        {
            [delegate loadAlarmList:jsonDic];
        }
    }
}

@end
