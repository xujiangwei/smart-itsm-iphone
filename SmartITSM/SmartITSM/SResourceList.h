//
//  SResourceList.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-14.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SResource.h"

@interface SResourceList : NSObject

@property (nonatomic, strong) NSMutableArray *resourceArray;        //资源数组

@property (nonatomic, assign) NSInteger    count;                   //数量

@property (nonatomic, assign) NSInteger firstIndex;                //首索引

//@property (nonatomic, assign) NSInteger lastIndex;                 //尾索引

@property (nonatomic, assign) NSInteger length;                    //索引长度

@end
