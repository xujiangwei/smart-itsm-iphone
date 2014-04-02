//
//  SProcessViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-26.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SProcessViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic, strong) NSMutableArray  * relatedProcesses;

@property (nonatomic,strong)  UITableView *relatedProcessListView;

@end
