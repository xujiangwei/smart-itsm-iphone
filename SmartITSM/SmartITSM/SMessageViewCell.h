//
//  SMessageViewCell.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-4.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMessage.h"

@interface SMessageViewCell : UITableViewCell

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

@property (assign, nonatomic) IBOutlet UILabel *messageIdLabel;

- (void) updateMessage:(SMessage *)msg;

@end
