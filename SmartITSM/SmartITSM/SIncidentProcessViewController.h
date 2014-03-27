//
//  SIncidentProcessViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-27.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "SIncident.h"
#import "MBProgressHUD.h"

@interface SIncidentProcessViewController : UITableViewController<RETableViewManagerDelegate>


@property( nonatomic, strong) NSString *processTag;

@property( nonatomic, strong) SIncident *incident;

@property (nonatomic, strong) MBProgressHUD *HUD;

@end
