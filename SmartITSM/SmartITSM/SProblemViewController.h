//
//  SProblemViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SProblem.h"
#import "SProblemContentTabBarController.h"


@protocol SProblemListDelegate <NSObject>

//获取当前工单可用的操作，由产品提供接口
-(NSArray *)getTaskOperation:(SProblem *)problem;

@end

@interface xxx123 : NSObject

@end

@interface SProblemViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  * problems;

@property (nonatomic,strong)  UITableView *problemListView;

@property (nonatomic, assign) id<SProblemListDelegate> delegate;

//更新事故工单列表
//- (void)updateIncidentList:(NSMutableArray *)problemArray;

@end


