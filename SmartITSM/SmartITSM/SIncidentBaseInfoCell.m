//
//  SIncidentBaseInfoCell.m
//  SmartITOM
//
//  Created by dwg on 13-9-3.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import "SIncidentBaseInfoCell.h"

@implementation SIncidentBaseInfoCell

@synthesize codeLabel;
//@synthesize stateLabel;
@synthesize stateImage;
@synthesize updateTimeLabel;
@synthesize summaryLabel;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        [self build];
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
    
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    
    [super setSelected:selected animated:animated];
    UIView *view = [[UIView alloc]initWithFrame:self.frame];
    [view setBackgroundColor:[UIColor colorWithRed:71.0/255.0 green:78.0/255.0 blue:96.0/255.0 alpha:0.8]];
    self.selectedBackgroundView = view;
}

- (void)build
{
    self.backgroundColor = [UIColor clearColor];
}

@end

