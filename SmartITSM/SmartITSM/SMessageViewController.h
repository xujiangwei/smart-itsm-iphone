//
//  SMessageViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMessage.h"

@protocol SMessageListDelegate <NSObject>

//获取当前工单可用的操作，由产品提供接口
-(NSArray *)getTaskOperation:(SMessage *)message;

@end

@interface SMessageViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray  * messages;

@property (nonatomic,strong)  UITableView *messageListView;

@property (nonatomic, assign) id<SMessageListDelegate> delegate;

//更新事故工单列表
- (void)updateMessageList:(NSMutableArray *)messageArray;

@end
