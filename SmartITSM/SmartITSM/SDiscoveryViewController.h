//
//  SDiscoveryViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-2-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SResourceListViewController.h"

@interface SDiscoveryViewController : UITableViewController<UIActionSheetDelegate>

@property (nonatomic, strong) NSMutableDictionary *discoveryDic;

@property (nonatomic, strong) NSMutableArray *sectionArray;

@end
