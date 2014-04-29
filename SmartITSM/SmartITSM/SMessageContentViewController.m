//
//  SMessageContentViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-24.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageContentViewController.h"
#import "SMessage.h"
//#import "SSenderButton.h"

@interface SMessageContentViewController ()

@end

@implementation SMessageContentViewController

@synthesize summaryView;
@synthesize receiveTimeLabel;
@synthesize hasTopButton;
@synthesize summaryLabel;
@synthesize scrollView;
@synthesize content;
@synthesize originalPicView;
@synthesize message;
@synthesize messageArray;
@synthesize currentIndexPath;
@synthesize delegate;
@synthesize hasTop;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

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
	
    [self updateMessage:message];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)updateMessage:(SMessage *)selectMsg
{
    if(Nil != selectMsg)
    {
        self.senderLabel.text = selectMsg.sender;
        self.summaryLabel.text = selectMsg.summary;
        self.receiveTimeLabel.text = selectMsg.receiveTime;
        self.content.text = selectMsg.messageText;
        
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
        if (selectMsg.hasTop)
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
