//
//  SMessageViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "SMessage.h"
#import "WEPopoverController.h"
#import "SMessageListener.h"

@protocol SMessageListDelegate <NSObject>

//获取当前消息可用的操作，由产品提供接口
-(NSArray *)getTaskOperation:(SMessage *)message;

@end

@interface SMessageViewController : UITableViewController<UITableViewDelegate, UITableViewDataSource, WEPopoverControllerDelegate, UIPopoverControllerDelegate, SMessageListenerDelegate, SMessageStatusListenerDelegate, MBProgressHUDDelegate>
{
//    WEPopoverController *popoverController;
    Class popoverClass;
}

@property (nonatomic, strong) NSMutableArray  * messages;

//@property (nonatomic,strong)  UITableView *messageListView;

@property (nonatomic, assign) id<SMessageListDelegate> delegate;

@property (nonatomic,retain) WEPopoverController *popoverController;

@property (nonatomic, strong) NSIndexPath *currentIndexPath;


@end
