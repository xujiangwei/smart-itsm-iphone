//
//  SResourceListViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-3-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SResourceList.h"

@interface SResourceListViewController : UITableViewController <UISearchBarDelegate>

@property (strong, nonatomic) IBOutlet UISearchBar *searchBar;

@property (strong, nonatomic) SResourceList *resourceList;

@end
