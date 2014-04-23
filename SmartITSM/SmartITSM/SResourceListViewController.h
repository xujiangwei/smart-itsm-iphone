//
//  SResourceListViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-3-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SResourceList.h"
#import "SResourceListListener.h"

@interface SResourceListViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate, SResourceListListenerDelegate>

@property (strong, nonatomic) SResourceList *resourceList;

@property (assign, nonatomic) BOOL fromDiscovery;

@property (assign, nonatomic) BOOL fromTool;

@end
