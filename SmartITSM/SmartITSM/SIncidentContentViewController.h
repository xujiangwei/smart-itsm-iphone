//
//  SIncidentContentViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIncident.h"
//#import "MBProgressHUD.h"
#import "WEPopoverController.h"

@interface SIncidentContentViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,WEPopoverControllerDelegate, UIPopoverControllerDelegate>

{
    NSMutableArray  * incidents;
    WEPopoverController *popoverController;
    NSInteger currentPopoverCellIndex;
	Class popoverClass;
}

@property (nonatomic, strong) SIncident *incident;

@property (nonatomic, strong)UITableView  *_tableView;

@property (nonatomic, retain) WEPopoverController *popoverController;


/**设置当前任务的可操作列表*/
-(void) setTaskOperation:(NSArray *)operation;

-(void)updateSelectCell:(UITableViewCell *)cell selectedValue:(NSString*)value;


@end
