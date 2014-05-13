//
//  SDiscovery.h
//  SmartITSM
//
//  Created by 朱国强 on 14-5-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _DiscoveryType
{
    Rource = 0,           //设备
    
    KPI = 1,              //指标
    
    Communication = 2,    //通讯录
    
    Dial = 4              //拨测
    
} DiscoveryType;

@interface SDiscovery : NSObject

@property (nonatomic, assign) long discoveryId;             //发现ID

@property (nonatomic, assign) DiscoveryType discoveryType;  //发现类型

@property (nonatomic, strong) NSString *discoveryContent;   //发现内容

@end
