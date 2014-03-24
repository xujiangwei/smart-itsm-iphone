//
//  SInspectionDao.h
//  SmartITOM
//
//  Created by dwg on 13-11-20.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SInspection.h"

@interface SInspectionDao : NSObject

-(id) init;

+(NSMutableArray *)getInspectionTaskList;

+(NSMutableArray *)getInspectionTaskList:(NSString *)sql;

+(NSMutableArray *)getLocalInspectionIdList;

+(NSMutableArray *)getInspectionTaskListOrderBy:(NSInteger)token;

+(SInspection *)getInspectionTaskDetailById:(NSString *)inspectionId;

+(BOOL) deleteLocalInspectionById:(NSString *)problemId;

+ (BOOL)insert:(NSDictionary *)inspectionDic;

+ (BOOL) update:(NSDictionary *)inspectionDic;

@end
