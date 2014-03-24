//
//  SIncidentBaseInfoCell.h
//  SmartITOM
//
//  Created by dwg on 13-9-3.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SIncidentBaseInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *codeLabel;
//@property (strong, nonatomic) IBOutlet UILabel *stateLabel;
@property (strong, nonatomic) IBOutlet UIImageView *stateImage;
@property (strong, nonatomic) IBOutlet UILabel *updateTimeLabel;
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;

@end

