//
//  SDiscoveryDao.m
//  SmartITSM
//
//  Created by 朱国强 on 14-5-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SDiscoveryDao.h"
#import "SResourceDao.h"
#import "SDatabase.h"
#import "FMResultSet.h"

@implementation SDiscoveryDao

//插入新的发现
+ (BOOL)insertDiscovery:(NSString *)content withType:(DiscoveryType)type
{
    SDatabase *db = [SDatabase  sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO tb_discovery (discovery_type, discovery_content) VALUES (%d, %@)",type, content];
    return  [db executeUpdate:sql];
}

//删除发现
+ (BOOL)deleteDiscovery:(NSString *)content withType:(DiscoveryType)type
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_discovery WHERE discovery_content = '%@' AND discovery_type = %d",content, type];
    return [db executeUpdate:sql];
}

//查询Discovery的种类
+ (NSMutableArray *)selectAllDiscoveryType
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:2];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT DISTINCT discovery_type FROM tb_discovery"];
    rs = [db executeQuery:sql];
    while ([rs next])
    {
        NSInteger type = [rs intForColumnIndex:0];
        
        NSString *strType = nil;
        switch (type)
        {
            case 0:
            {
                strType = DiscoveryTypeResource;
                
            }
                break;
            case 1:
            {
                strType = DiscoveryTypeKPI;
            }
                break;
            case 2:
            {
                strType = DiscoveryTypeCommutication;
            }
                break;
            case 3:
            {
                strType = DiscoveryTypeDial;
            }
                break;
                
            default:
                break;
        }
        
        [array addObject:strType];
    }
    return array;
}

//查询具体type的Discovery
+ (NSMutableArray *)selectDiscoveryWithType:(NSString *)type
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = nil;
    NSString *sql = nil;

    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:2];
    if ([type isEqualToString: DiscoveryTypeResource])
    {
        //设备
        sql = [NSString stringWithFormat:@"SELECT discovery_content FROM tb_discovery WHERE discovery_type = %d", Resource];
        rs = [db executeQuery:sql];
        while ([rs next])
        {
            long resourceId = [[rs stringForColumnIndex:0] intValue];
            
            SResource *resource = [SResourceDao getResourceWithId:resourceId];
            
            [array addObject:resource];
        }
    }
    else if ([type isEqualToString:DiscoveryTypeKPI])
    {
        //指标
        sql = [NSString stringWithFormat:@"SELECT discovery_content FROM tb_discovery WHERE discovery_type = %d",KPI];
        rs = [db executeQuery:sql];
        while ([rs next])
        {
            NSString *KPI = [rs stringForColumnIndex: 0];
            
            [array addObject:KPI];
            
        }
    }
    else if ([type isEqualToString:DiscoveryTypeCommutication])
    {
        //通讯录
        sql = [NSString stringWithFormat:@"SELECT discovery_content FROM tb_discovery WHERE discovery_type = %d",Communication];
        rs = [db executeQuery:sql];
        while ([rs next])
        {
            NSString *communication = [rs stringForColumnIndex: 0];
            
            [array addObject:communication];
            
        }
    }
    else
    {
        //拨测
        sql = [NSString stringWithFormat:@"SELECT discovery_content FROM tb_discovery WHERE discovery_type = %d",Dial];
        rs = [db executeQuery:sql];
        while ([rs next])
        {
            NSString *dial = [rs stringForColumnIndex: 0];
            
            [array addObject:dial];
        }
    }
    return array;
    
}

//某台设备是否已关注为发现
+ (BOOL)isDiscovery:(NSString *)resourceId withType:(DiscoveryType)type
{
    BOOL result = NO;
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT() FROM tb_discovery WHERE discovery_content = '%@' AND discovery_type = %d",resourceId, type];
    rs = [db executeQuery:sql];
    while ([rs next]) {
        int count = [rs intForColumnIndex:0];
        if (count != 0) {
            result = YES;
        }
    }
    return result;
}

+ (NSMutableArray *)selectAllDiscovery
{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:2];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT (dicovery_id, discovery_type, discovery_content) FROM tb_discovery"];
    rs = [db executeQuery:sql];
    while ([rs next])
    {
        long discoveryId = [rs longForColumnIndex:0];
        NSInteger discoveryType = [rs intForColumnIndex:1];
        NSString *discoveryContent = [rs stringForColumnIndex:2];
        
        SDiscovery *discovery = [[SDiscovery alloc] init];
        [discovery setDiscoveryId:discoveryId];
        [discovery setDiscoveryType:discoveryType];
        [discovery setDiscoveryContent:discoveryContent];
        
        [array addObject:discovery];
    }
    
    return  array;
}

@end
