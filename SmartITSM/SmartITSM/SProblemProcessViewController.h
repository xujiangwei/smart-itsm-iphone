//
//  SProblemProcessViewController.h
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "RETableViewOptionsController.h"
#import "SProblem.h"

@interface SProblemProcessViewController : UITableViewController <RETableViewManagerDelegate>

@property( nonatomic, strong) SProblem *problem;
