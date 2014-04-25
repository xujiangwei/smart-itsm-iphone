//
//  SIncidentListener.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"

@protocol SIncidentListenerDelegate <NSObject>

- (void )didRequestIncidentList:(NSDictionary *)listDic;

@end

@interface SIncidentListener : ActionListener

@property (assign, nonatomic) id<SIncidentListenerDelegate>delegate;

- (void)didAction:(CCActionDialect *)dialect;

@end
