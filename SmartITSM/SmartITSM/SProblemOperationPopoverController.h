//
//  SProblemOperationPopoverController.h
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SProblemContentTabBarController.h"

@interface SProblemOperationPopoverController : UITableViewController

@property(nonatomic ,strong)NSArray *operationArray;

@property(nonatomic, strong)SProblemContentTabBarController  *contentTabBarController;

@end
