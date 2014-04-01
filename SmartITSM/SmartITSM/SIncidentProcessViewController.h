//
//  ControlsViewController.h
//  RETableViewManagerExample
//
//  Created by Roman Efimov on 2/28/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RETableViewManager.h"
#import "SIncident.h"

@interface SIncidentProcessViewController : UITableViewController <RETableViewManagerDelegate>

@property( nonatomic, strong) SIncident *incident;

@end
