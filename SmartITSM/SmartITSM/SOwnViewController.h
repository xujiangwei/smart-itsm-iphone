//
//  SOwnViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-2-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIncidentViewController.h"
#import "SProblemViewController.h"
#import "SChangeViewController.h"
#import "SAlarmViewController.h"
#import "SInspectionViewController.h"
#import "SMessageViewController.h"
#import "WEPopoverController.h"

@interface SOwnViewController : UITableViewController <WEPopoverControllerDelegate>

@property (nonatomic, strong) WEPopoverController *wePopoverController;

@property(nonatomic ,strong)NSArray *sectionArray;

@property(nonatomic, strong)NSMutableDictionary *cellDic;

@end
