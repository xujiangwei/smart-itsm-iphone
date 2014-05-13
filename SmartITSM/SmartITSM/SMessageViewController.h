//
//  SMessageViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SMessage.h"
#import "WEPopoverController.h"
#import "SMessageListener.h"
#import "SMessageViewCell.h"

@interface SMessageViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, WEPopoverControllerDelegate, UIPopoverControllerDelegate, SMessageListenerDelegate, SMessageStatusListenerDelegate, MBProgressHUDDelegate, SMessageViewCellDelegate>
{
    Class popoverClass;
}

@property (nonatomic, strong) NSMutableArray  *messages;

@property (nonatomic,retain) WEPopoverController *popoverController;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;


@end
