//
//  SConfigServerView.m
//  SmartITSM
//
//  Created by 朱国强 on 14-3-18.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SConfigServerView.h"

@implementation SConfigServerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self build];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self build];
    }
    return self;
}

- (void)build
{
    [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"signin_view_bg.png"]]];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
