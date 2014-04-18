//
//  SMessageViewCell.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-4.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SMessageViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *messageIdLabel;
@property (strong, nonatomic) IBOutlet UILabel *senderLabel;
@property (strong, nonatomic) IBOutlet UILabel *messageTextLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;
@property (strong, nonatomic) IBOutlet UILabel *sendTimeLabel;

@end
