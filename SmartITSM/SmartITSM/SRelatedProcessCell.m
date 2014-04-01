//
//  SRelatedProcessCell.m
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SRelatedProcessCell.h"

@implementation SRelatedProcessCell

@synthesize codeLabel;
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
}

- (void)build
{
    self.backgroundColor = [UIColor clearColor];
}



@end
