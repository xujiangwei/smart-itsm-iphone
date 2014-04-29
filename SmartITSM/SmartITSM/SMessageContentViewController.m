//
//  SMessageContentViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-24.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageContentViewController.h"
#import "SMessage.h"

@interface SMessageContentViewController ()
{
    SMessageContentView *contentView;
}
@end

@implementation SMessageContentViewController

//@synthesize contentView;
@synthesize message;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"详细信息";
    
    CGRect frame = self.view.frame;
    contentView = [[SMessageContentView alloc]initWithFrame:frame];

    [contentView updateMessage:message];

    [self.view addSubview:contentView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
