//
//  SIncidentViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIncident.h"
#import "SIncidentContentTabBarController.h"
#import "SIncidentListener.h"

@protocol SIncidentListDelegate <NSObject>

//获取当前工单可用的操作，由产品提供接口
-(NSArray *)getTaskOperation:(SIncident *)incident;

@end

@interface SIncidentViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, SIncidentListenerDelegate>

@property (nonatomic, strong) NSMutableArray  * incidents;

@property (nonatomic,strong)  UITableView *incidentListView;

@property (nonatomic, assign) id<SIncidentListDelegate> delegate;

//更新事故工单列表
- (void)updateIncidentList:(NSMutableArray *)incidentArray;

@end
