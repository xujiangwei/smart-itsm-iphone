//
//  SMessageViewCell.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-4.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageViewCell.h"

@implementation SMessageViewCell

@synthesize imageVRead;
@synthesize icon;
@synthesize senderLabel;
@synthesize summaryLabel;
@synthesize sendTimeLabel;
@synthesize messageIdLabel;

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

- (void) updateMessage:(SMessage *)msg
{
//    Theme *theme = [[ThemeManager sharedSingleton] theme];
//    NSLog(@"%@",msg.receiveTime);
//    messageId = msg.messageId;
    
    self.senderLabel.text = msg.sender;
    self.summaryLabel.text = msg.summary;
    self.sendTimeLabel.text = msg.sendTime;
    
    if ([msg.sender isEqualToString:@"admin"])
    {
        [self.icon setImage:[UIImage imageNamed:@"user.png"]];
    }
    else
    {
        [self.icon setImage:[UIImage imageNamed:@"system.png"]];
    }
    
    //是否已读
//    if (msg.hasRead)
//    {
//        [self.imageVRead setImage:[UIImage imageNamed:theme.readed]];
//    }
//    else
//    {
//        [self.imageVRead setImage:[UIImage imageNamed:theme.unread]];
//        
//    }
    
/*
    if (msg.hasAttachments)
    {
        [self.imageVAttachment setImage:[UIImage imageNamed:theme.attachment]];
    }
    else
    {
        [self.imageVAttachment setImage:nil];
    }
    
    markTop = msg.hasTop;
    
    if (msg.hasTop)
    {
        [self.btnMarkTop setBackgroundImage:[UIImage imageNamed:theme.markTopHighlight] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnMarkTop setBackgroundImage:[UIImage imageNamed:theme.markTopNormal] forState:UIControlStateNormal];
    }
    
    if (msg.hasThumbnailPic)
    {
        [self.imageVContentBg setImage:[UIImage imageNamed:theme.thumbnail]];
        [self.imageVContent setImage:[UIImage imageNamed:msg.thumbnailPic]];
    }
    else
    {
        [self.imageVContentBg setImage:nil];
        [self.imageVContent setImage:nil];
    }
*/
}

@end
