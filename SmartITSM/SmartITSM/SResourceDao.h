//
//  SResourceDao.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-14.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SResource.h"
#import "SResourceList.h"

@interface SResourceDao : NSObject

+ (SResource *)getResourceWithId:(long)resourceId;

//插入数据
+ (BOOL) insertResource:(NSDictionary *)resourcesDic;

//更新数据
+ (BOOL) updateResource:(NSDictionary *)resourcesDic;

//删除一条数据
+ (BOOL) deleteResourceWithResourceId:(long)resourceId;

//删除所有数据
+ (BOOL) deleteAllResource;

//获取分类后的数据
+ (NSMutableArray *) getResourceListArrayWithCategory:(ResourceCategory)topCategory;

//查询资源基本信息，别名和IP地址
+ (NSMutableArray *) searchBasicInformationWithVendorId:(NSInteger)vendorId andCategoryId:(NSInteger)categoryId;

//获取所有的数据
+ (SResourceList *) getAllResource;



@end
