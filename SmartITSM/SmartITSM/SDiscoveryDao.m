//
//  SDiscoveryDao.m
//  SmartITSM
//
//  Created by 朱国强 on 14-5-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SDiscoveryDao.h"
#import "SDiscovery.h"
#import "SDatabase.h"
#import "FMResultSet.h"

@implementation SDiscoveryDao

- (BOOL)insertDiscovery:(NSString *)content withType:(DiscoveryType)type
{
    BOOL result ;
    SDatabase *db = [SDatabase  sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"INSERT INTO tb_discovery (dicovery_id, discovery_type, discovery_content) VALUES (0,%d, %@)",type, content];
    if ([db executeUpdate:sql])
    {
        result = YES;
        NSLog(@"succesed");
        
    }else
    {
        result = NO;
        NSLog(@"failed");
    }
    
    return result;
}

- (NSMutableArray *)selectAllDiscovery
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
