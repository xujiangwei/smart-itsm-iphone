//
//  WEPopoverContentViewController.h
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIncidentContentTabBarController.h"

@interface SIncidentOperationPopoverController : UITableViewController

@property(nonatomic ,strong)NSArray *operationArray;

@property(nonatomic, strong)SIncidentContentTabBarController  *contentTabBarController;

@end
