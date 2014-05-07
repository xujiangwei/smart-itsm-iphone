//
//  SMessageViewCell.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-4.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMessage.h"

@protocol SMessageViewCellDelegate <NSObject>

- (void)btnMarkTopAction:(BOOL)top withId:(NSString *)messageId withTag:(NSInteger)index;

@end

@interface SMessageViewCell : UITableViewCell

//是否置顶
@property (strong, nonatomic) IBOutlet UIButton *btnMarkTop;

//已读 未读
@property (strong, nonatomic) IBOutlet UIImageView *imageVRead;

//用户图表
@property (strong, nonatomic) IBOutlet UIImageView *icon;

//发送者
@property (strong, nonatomic) IBOutlet UILabel *senderLabel;

//内容概括
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;

//发送时间
@property (strong, nonatomic) IBOutlet UILabel *sendTimeLabel;

//消息编号
@property (assign, nonatomic) NSString *messageId;

//置顶
@property (assign, nonatomic) BOOL markTop;

@property (assign, nonatomic) id<SMessageViewCellDelegate>delegate;

- (void) updateMessage:(SMessage *)msg;

- (IBAction)btnMarkTopAction:(id)sender;

@end
