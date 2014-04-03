//
//  SProblemBaseViewController.h
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SProblemBaseViewController : UITableViewController
{
    NSMutableArray  * problems;
}

@property (nonatomic, strong) SProblem *problem;

@end
