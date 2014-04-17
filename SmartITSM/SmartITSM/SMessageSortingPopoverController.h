//
//  SMessageSortingPopoverController.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMessageContentViewController.h"

@interface SMessageSortingPopoverController : UITableViewController

@property(nonatomic ,strong) NSArray *sortingArray;

@property(nonatomic, strong) SMessageContentViewController  *messageContentViewController;

@end
