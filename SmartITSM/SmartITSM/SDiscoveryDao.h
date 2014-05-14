//
//  SDiscoveryDao.h
//  SmartITSM
//
//  Created by 朱国强 on 14-5-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SDiscovery.h"

@interface SDiscoveryDao : NSObject

//插入新发现
+ (BOOL)insertDiscovery:(NSString *)content withType:(DiscoveryType)type;

//删除发现
+ (BOOL)deleteDiscovery:(NSString *)content withType:(DiscoveryType)type;

//查询Discovery的种类
+ (NSMutableArray *)selectAllDiscoveryType;


//查询具体type的Discovery
+ (NSMutableArray *)selectDiscoveryWithType:(NSString *)type;

//某台设备是否已关注为发现
+ (BOOL)isDiscovery:(NSString *)resourceId withType:(DiscoveryType)type;

@end
