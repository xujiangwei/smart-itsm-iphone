//
//  SResourceDao.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-14.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SResourceDao.h"
#import "SDatabase.h"
#import "FMResultSet.h"

@implementation SResourceDao

+ (SResource *)getResourceWithId:(long)resourceId
{
    SResource *resource = [[SResource alloc]init];
    
    [resource setResourceId:resourceId];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = nil;
    NSString *sql = [NSString stringWithFormat:@"SELECT category_id, vendor_id, base_json FROM tb_resource WHERE resource_id = %ld",resourceId];
    NSLog(@"%@", sql);
    rs = [db executeQuery:sql];
    int categoryId = 0;
    int vendorId = NSNotFound;

    while ([rs next])
    {
        categoryId = [rs intForColumnIndex:0];
        vendorId = [rs intForColumnIndex:1];
        NSString *baseJson = [rs stringForColumnIndex:2];
        
        NSData *data = [baseJson dataUsingEncoding:NSUTF8StringEncoding];
        NSError *error;
        NSDictionary *baseDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        
        NSString *resourceName = [baseDic objectForKey:@"alias"];
        NSString *resourceIp = [baseDic objectForKey:@"moIp"];
        
        [resource setSecondCategory:categoryId];
        [resource setVendorId:vendorId];
        [resource setResourceName:resourceName];
        [resource setResourceIp:resourceIp];
        
    }
  
    sql = [NSString stringWithFormat:@"SELECT category,  parent_category_id, parent_category, category_picture FROM tb_resource_type WHERE category_id = %d", categoryId];
    NSLog(@"%@", sql);
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        NSString *category = [rs stringForColumnIndex:0];
        int topCategory = [rs intForColumnIndex:1];
        NSString *topCategoryName  = [rs stringForColumnIndex:2];
        NSString *categoryPic = [rs stringForColumnIndex:3];
        
        [resource setSecondCategoryName:category];
        [resource setTopCategory:topCategory];
        [resource setTopCategoryName:topCategoryName];
        [resource setCategoryPic:categoryPic];
        
    }
    
    sql = [NSString stringWithFormat:@"SELECT vendor, vendor_picture FROM tb_resource_vendor WHERE id = %d", vendorId];
    NSLog(@"%@", sql);
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        NSString *vendor = [rs stringForColumnIndex:0];
        NSString *vendorPic = [rs stringForColumnIndex:1];

        [resource setVendor:vendor];
        [resource setVendorLogo:vendorPic];
        
    }
    return resource;
}

+ (BOOL) insertResource:(NSDictionary *)resourcesDic
{
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    
    long resourceId = [[resourcesDic objectForKey:@"moId"] longValue];
    
    long vendorId = [[resourcesDic objectForKey:@"vendorID"] longValue];
    
    
    long categoryId = [[resourcesDic objectForKey:@"typeCode"] longValue];
    
    NSDictionary *baseJson = [resourcesDic objectForKey:@"base_info"] ;
    
    NSString *strBase = nil;
    
    if ([NSJSONSerialization isValidJSONObject:baseJson])
    {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:baseJson options:NSJSONWritingPrettyPrinted error:&error];
        strBase = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }

    //    NSLog(@"strBase = %@",strBase);
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO  tb_resource(resource_id, vendor_id, category_id, base_json) VALUES ("];
    [sql appendFormat:@"%ld,",resourceId];
    [sql appendFormat:@"%ld,",vendorId];
    [sql appendFormat:@"%ld,",categoryId];
    [sql appendFormat:@"'%@')",strBase];
    
    //    NSLog(@"sql = %@",sql);
    
    if ([db executeUpdate:sql])
    {
        result = TRUE;
        NSLog(@"resource insert a data successed");
        
    }
    else
    {
        result = FALSE;
        NSLog(@"resource insert a data failed");
    }
    
    return result;
}

+ (BOOL) updateResource:(NSDictionary *)resourcesDic
{
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    
    long resourceId = [[resourcesDic objectForKey:@"moId"] longValue];
    
    long vendorId = [[resourcesDic objectForKey:@"vendorID"] longValue];
    
    long categoryId = [[resourcesDic objectForKey:@"typeCode"] longValue];
    
    NSDictionary *baseJson = [resourcesDic objectForKey:@"base_info"] ;
    
    NSString *strBase = nil;
    
    if ([NSJSONSerialization isValidJSONObject:baseJson])
    {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:baseJson options:NSJSONWritingPrettyPrinted error:&error];
        strBase = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }
    
    //    NSLog(@"strBase = %@",strBase);
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_resource SET  vendor_id = %ld, category_id = %ld, base_json = '%@' WHERE resource_id = %ld ",vendorId,categoryId,strBase,resourceId];
    
    //    NSLog(@"sql = %@",sql);
    if ([db executeUpdate:sql])
    {
        result = TRUE;
        NSLog(@"update tb_resource successed");
    }
    else
    {
        result = FALSE;
        NSLog(@"update tb_resource failed");
    }
    return result;
}

//删除一条数据
+ (BOOL) deleteResourceWithResourceId:(long)resourceId
{
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_resource WHERE resource_id = %ld", resourceId];
    
    result = [db executeUpdate:sql];
    if (result)
    {
        NSLog(@"delete a data from tb_resource successed");
    }
    else
    {
        NSLog(@"delete a data from tb_resource failed");
    }
    return result;
}

//删除所有数据
+ (BOOL) deleteAllResource
{
    BOOL result;
    SDatabase *db = [SDatabase sharedSingleton];
    NSString *sql = [NSString stringWithFormat:@"DELETE FROM tb_resource "];
    
    result = [db executeUpdate:sql];
    if (result)
    {
        NSLog(@"delete all data from tb_resource successed");
    }
    else
    {
        NSLog(@"delete all data from tb_resource failed");
    }
    return result;
}

+ (NSMutableArray *) getResourceListArrayWithCategory:(ResourceCategory)topCategory
{
    //FIX ME
    NSMutableArray *resourceListArray = [[NSMutableArray alloc] initWithCapacity:5];
//    SDatabase *db = [SDatabase sharedSingleton];
//    FMResultSet *rs = nil;
//    
//    NSMutableArray * vendorArray = [[NSMutableArray alloc] initWithCapacity:5];
//    NSString *sql = [NSString stringWithFormat:@"select id from tb_resource_vendor where id in (select  vendor_id from tb_resource where category_id in (select category_id from tb_resource_type where parent_category_id = %d))",topCategory];
//    NSLog(@"%@", sql);
//    rs = [db executeQuery:sql];
//    while ([rs next])
//    {
//        int vendorId = [rs intForColumnIndex:0];
//        [vendorArray addObject:[NSNumber numberWithInt:vendorId]];
//    }
//    NSMutableArray * categoryArray = [[NSMutableArray alloc] initWithCapacity:5];
//    NSString *sql2 = [NSString stringWithFormat:@"select distinct  category_id from tb_resource where category_id in (select category_id from tb_resource_type where parent_category_id = %d)",topCategory];
//    NSLog(@"sql2 = %@",sql2);
//    rs = [db executeQuery:sql2];
//    while ([rs next])
//    {
//        int categoryId = [rs intForColumnIndex:0];
//        [categoryArray addObject:[NSNumber numberWithInt:categoryId]];
//    }
//    for (NSNumber *vendorId in vendorArray)
//    {
//        for (NSNumber *categoryId in categoryArray)
//        {
//            NSString *sql3 = [NSString stringWithFormat:@"select count(*) from tb_resource where vendor_id = %d and category_id = %d",[vendorId intValue],[categoryId intValue]];
//            NSLog(@"sql3 = %@",sql3);
//            rs = [db executeQuery:sql3];
//            while ([rs next])
//            {
//                NSString *vendor = nil;
//                NSString *vendorLogo = nil;
//                NSString *category = nil;
//                NSString *categoryPic = nil;
//                NSInteger parentCategoryId;
//                FMResultSet *result = nil;
//                //数据库取厂商图片
//                NSString *sql4 = [NSString stringWithFormat:@"select vendor,vendor_picture from tb_resource_vendor where id = %d",[vendorId intValue]];
//                NSLog(@"sql4 = %@",sql4);
//                result = [db executeQuery:sql4];
//                
//                while ([result next])
//                {
//                    vendor = [result stringForColumnIndex:0];
//                    vendorLogo = [result stringForColumnIndex:1];
//                }
//                //数据库取设备类型图片
//                NSString *sql5 = [NSString stringWithFormat:@"select category,category_picture,parent_category_id from tb_resource_type where category_id = %d",[categoryId intValue]];
//                NSLog(@"sql5 = %@",sql5);
//                result = [db executeQuery:sql5];
//                while ([result next])
//                {
//                    category = [result stringForColumnIndex:0];
//                    categoryPic = [result stringForColumnIndex:1];
//                    parentCategoryId = [result intForColumnIndex:2];
//                }
//                
//                NSString *name = nil;
//                if ([vendor isEqualToString:@"未知"])
//                {
//                    name = [NSString stringWithFormat:@"%@",category];
//                }
//                else
//                {
//                    name = [NSString stringWithFormat:@"%@ %@",vendor,category];
//                }
//                
//                //华为交换机 的数量 取sql3数量
//                NSInteger count = [rs intForColumnIndex:0];
//                if (0 !=count)
//                {
//                    SResourceList *resourceList = [[SResourceList alloc]init];
//                    resourceList.vendorLogo = [NSString stringWithFormat:@"Images/%@",vendorLogo];
//                    resourceList.categoryPic = [NSString stringWithFormat:@"Images/%@",categoryPic];
//                    resourceList.name = name;
//                    resourceList.count = count;
//                    resourceList.vendorName = vendor;
//                    resourceList.categoryName = category;
//                    resourceList.vendorId = [vendorId intValue];
//                    resourceList.category = [categoryId intValue];
//                    resourceList.parentCategory = parentCategoryId;
//                    [resourceListArray addObject:resourceList];
//                }
//            }
//        }
//    }
//    NSLog(@"resourceListArray count = %d",[resourceListArray count]);
    return resourceListArray;
}

+ (NSMutableArray *) searchBasicInformationWithVendorId:(NSInteger)vendorId andCategoryId:(NSInteger)categoryId
{
    //FIX ME
    NSMutableArray *resourceArray = [[NSMutableArray alloc]initWithCapacity:10];
//    SDatabase *db = [SDatabase sharedSingleton];
//    
//    FMResultSet *rs = nil;
//    NSString *sql = [NSString stringWithFormat:@"select resource_id,category_id,base_json from tb_resource where vendor_id = %d  and category_id = %d",vendorId,categoryId];
//    //    NSLog(@"%@",sql);
//    rs = [db executeQuery:sql];
//    
//    while ([rs next])
//    {
//        FMResultSet *result;
//        
//        NSString *categoryPic;
//        NSInteger parentCategoryId;
//        
//        NSString * selectSql = [NSString stringWithFormat:@"SELECT category_picture, parent_category_id FROM tb_resource_type WHERE category_id =  %d",categoryId];
//        //        NSLog(@"selectSql = \n%@", selectSql);
//        result = [db executeQuery:selectSql];
//        while ([result next])
//        {
//            categoryPic = [result stringForColumnIndex:0];
//            parentCategoryId = [result intForColumnIndex:1];
//        }
//        
//        long resourceId = [rs longForColumnIndex:0];
//        NSString *baseJson = [rs stringForColumnIndex:2];//json字段，需要解析出设备的信息
//        
//        NSData *data = [baseJson dataUsingEncoding:NSUTF8StringEncoding];
//        NSError *error;
//        NSDictionary *baseInfo = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments
//                                                                   error:&error];
//        
//        NSString *resourceName = [baseInfo objectForKey:@"alias"];
//        NSString *resourceIp = [baseInfo objectForKey:@"moIp"];
//        
//        SResource *resource = [[SResource alloc]init];
//        [resource setResourceId:resourceId];
//        [resource setResourceName:resourceName];
//        [resource setResourceIp:resourceIp];
//        [resource setCategoryPic:[NSString stringWithFormat:@"Images/%@",categoryPic]];
//        [resource setTopCategory:parentCategoryId];
//        [resource setSecondCategory:categoryId];
//        
//        [resourceArray addObject:resource];
//        
//    }
    return resourceArray;
}

//获取所有的数据
+ (SResourceList *) getAllResource
{
    NSMutableArray *resourceListArray = [[NSMutableArray alloc] initWithCapacity:4];
    
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs = nil;
    NSString *sql = [NSString stringWithFormat:@"select distinct resource_id from tb_resource"];
    //    NSLog(@"%@",sql);
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        long resourceId = [rs longForColumnIndex:0];
        
        SResource *resource = [self getResourceWithId:resourceId];
        
        [resourceListArray addObject:resource];
    }
    
    SResourceList *resourceList = [[SResourceList alloc] init];
    [resourceList setResourceArray:resourceListArray];
    
     return resourceList;
}



@end
