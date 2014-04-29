//
//  SMessageContentView.m
//  SmartITSM
//
//  Created by Apple Developer on 14-4-29.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageContentView.h"

@implementation SMessageContentView

@synthesize summaryView;
@synthesize receiveTimeLabel;
@synthesize hasTopButton;
@synthesize summaryLabel;
@synthesize scrollView;
@synthesize content;
@synthesize originalPicView;
@synthesize messageArray;
@synthesize currentIndexPath;
//@synthesize delegate;
@synthesize hasTop;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        NSArray *nibs = [[NSBundle mainBundle] loadNibNamed:@"SMessageContentView" owner:self options:nil];
        UIView *view = [nibs objectAtIndex:0];
        [self addSubview:view];
    }
    return self;
}

- (void)updateMessage:(SMessage *)message
{
    if (nil != message)
    {
        self.senderLabel.text = message.sender;
        self.summaryLabel.text = message.summary;
        self.receiveTimeLabel.text = message.receiveTime;
        self.content.text = message.messageText;
        //        float origin_x = 120;
        //        SSenderButton *senderButton = [[SSenderButton alloc] init];
        //        CGSize size = [msg.sender sizeWithFont:senderButton.font];
        //
        //        senderButton.frame = CGRectMake(origin_x, 3.0f, size.width+20.0f, 40.0f);
        //        senderButton.leftImageV.frame = CGRectMake(0, 0, 5, senderButton.frame.size.height);
        //        senderButton.centerImageV.frame = CGRectMake(5, 0, senderButton.frame.size.width - 10, senderButton.frame.size.height);
        //        senderButton.rightImageV.frame = CGRectMake(senderButton.frame.size.width - 10, 0, 5, senderButton.frame.size.height);
        //        origin_x += size.width + 3.0f + 10.0f ;
        //        senderButton.text = msg.sender;
        //        [self.summaryView addSubview:senderButton];
        
        //        NSString *str = [NSString stringWithFormat:@"%f",msg.receiveTime];
        //        [self updateReceiveTime:str];
        
        //置顶
        if (message.hasTop)
        {
            [self.hasTopButton setBackgroundImage:[UIImage imageNamed:@"marked_highlight.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.hasTopButton setBackgroundImage:[UIImage imageNamed:@"marked_normal.png"] forState:UIControlStateNormal];
        }
        
        //附件
        //        if (msg.hasAttachments) {
        //            NSLog(@"%d",msg.hasAttachments);
        //            if (msg.thumbnailPic) {
        //                return;
        //            } else {
        //                self.originalPicView.hidden = YES;
        //            }
        //
        //        } else {
        //            NSLog(@"%d",msg.hasAttachments);
        //            self.attachView.hidden = YES;
        //            self.content.frame = CGRectMake(28, 20, 652, 80);
        //            if (msg.thumbnailPic) {
        //                self.originalPicView.frame = CGRectMake(68, 28+80+20, 398, 269);
        //            } else {
        //                self.originalPicView.hidden = YES;
        //            }
        //            
        //        }
    }
}

@end
