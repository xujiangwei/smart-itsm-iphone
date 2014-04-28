//
//  DHTaskDao.h
//  SmartITOM
//
//  Created by dwg on 13-6-24.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SIncident.h"

@interface STaskDao : NSObject

@property (nonatomic, strong) NSMutableArray *taskArray;

@property (nonatomic, strong) NSDictionary   *dictionary;


-(id) init;

+(NSMutableArray *)getTaskList;

+(NSMutableArray *)getTaskListOrderBy:(NSInteger)token;

+(NSMutableArray *)getLocalIncidentIdList;

+(NSMutableArray *) getTaskList:(NSString *)sql;

+(NSMutableArray *) search:(NSString *)sql;

+(SIncident *)getIncidentDetailWithId:(NSString *)incidentId;

+(BOOL) deleteLocalIncidentById:(NSString *)incidentId;

+ (BOOL)insert:(NSDictionary *)incidentDic;

+ (BOOL) update:(NSDictionary *)tasksDic;


+ (NSArray *)getTaskOperation:(SIncident *)incident;

+ (NSString *)getStateIcon:(SIncident *)incident;

+(NSString *)getIncidentReportWay:(NSInteger )way;

@end
