//
//  SMessageDao.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-17.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SMessage.h"

@interface SMessageDao : NSObject

-(id) init;

+(NSMutableArray *)getTaskList;

+(SMessage *)getMessageTaskDetailById:(NSString *)messageId;


@end
