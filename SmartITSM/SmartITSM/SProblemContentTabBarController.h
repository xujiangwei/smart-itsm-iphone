//
//  SProblemContentViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WEPopoverController.h"

@interface SProblemContentTabBarController :UITabBarController<WEPopoverControllerDelegate, UIPopoverControllerDelegate>
{
    WEPopoverController *popoverController;
    NSInteger currentPopoverCellIndex;
	Class popoverClass;
    
}


@property (nonatomic, retain) WEPopoverController *popoverController;

@end
