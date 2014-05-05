//
//  SAlarmViewListener.h
//  SmartITSM
//
//  Created by Apple001 on 14-4-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"
#import "StatusListener.h"

@protocol SAlarmViewListenerDelegate <NSObject>

-(void)loadAlarmList:(NSDictionary *)dic;

@end

@interface SAlarmViewListener : ActionListener

@property (assign,nonatomic) id<SAlarmViewListenerDelegate>delegate;

-(void)didAction:(CCActionDialect *)dialect;

@end
