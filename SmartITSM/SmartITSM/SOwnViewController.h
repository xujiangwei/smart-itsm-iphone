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


@interface SOwnViewController : UITableViewController

@property(nonatomic ,strong)NSArray *sectionArray;

@property(nonatomic, strong)NSMutableDictionary *cellDic;

@end
