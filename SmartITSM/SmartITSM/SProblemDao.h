//
//  SProblemDao.h
//  SmartITOM
//
//  Created by dwg on 13-10-17.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SProblem.h"

@interface SProblemDao : NSObject

@property (nonatomic, strong) NSMutableArray *problemArray;

@property (nonatomic, strong) NSDictionary   *dictionary;


-(id) init;

+(NSMutableArray *)getProblemList;

+(NSMutableArray *)getProblemListOrderBy:(NSInteger)token;

+(NSMutableArray *)getLocalProblemIdList;

+(NSMutableArray *) getProblemList:(NSString *)sql;

+(NSMutableArray *) search:(NSString *)sql;

+(SProblem *)getProblemDetailById:(NSString *)problemId;


+(BOOL) deleteLocalProblemById:(NSString *)problemId;

+ (BOOL)insert:(NSDictionary *)problemDic;

+ (BOOL) update:(NSDictionary *)problemDic;


+ (NSArray *)getProblemOperation:(SProblem *)incident;

+ (NSString *)getStateIcon:(SProblem *)incident;

+ (NSString *)getProblemSource:(NSInteger )source;

@end
