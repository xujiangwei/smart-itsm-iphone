//
//  SMessageViewCell.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-4.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageViewCell.h"

@implementation SMessageViewCell

@synthesize btnMarkTop;
@synthesize imageVRead;
@synthesize icon;
@synthesize senderLabel;
@synthesize summaryLabel;
@synthesize sendTimeLabel;
@synthesize messageId;
@synthesize markTop;
@synthesize delegate;

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder: aDecoder];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self build];
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
    messageId = msg.messageId;
    self.senderLabel.text = msg.sender;
    self.summaryLabel.text = msg.summary;
    self.sendTimeLabel.text = msg.sendTime;
    
    //管理员 系统
    if ([msg.sender isEqualToString:@"admin"])
    {
        [self.icon setImage:[UIImage imageNamed:@"user.png"]];
    }
    else
    {
        [self.icon setImage:[UIImage imageNamed:@"system.png"]];
    }
    
    //是否已读
    if (msg.hasRead)
    {
        [self.imageVRead setImage:[UIImage imageNamed:@"have_read.png"]];
    }
    else
    {
        [self.imageVRead setImage:[UIImage imageNamed:@"unread.png"]];
    }
    
    //是否置顶
    markTop = msg.hasTop;
    [self.btnMarkTop setTitle:nil forState:UIControlStateNormal];
    if (msg.hasTop)
    {
        [self.btnMarkTop setBackgroundImage:[UIImage imageNamed:@"marked_highlight.png"] forState:UIControlStateNormal];
    }
    else
    {
        [self.btnMarkTop setBackgroundImage:[UIImage imageNamed:@"marked_normal.png"] forState:UIControlStateNormal];
    }
    
    
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

- (IBAction)btnMarkTopAction:(id)sender
{
    markTop = !markTop;
    if (nil != self.delegate &&[self.delegate respondsToSelector:@selector(btnMarkTopAction:withId:withTag:)])
    {
        NSInteger index = btnMarkTop.tag;
        [self.delegate btnMarkTopAction:markTop withId:messageId withTag:index];
    }
}

@end
