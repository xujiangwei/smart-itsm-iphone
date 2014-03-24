//
//  SInspection.h
//  SmartITOM
//
//  Created by dwg on 13-11-20.
//  Copyright (c) 2013年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SInspection : NSObject

@property (nonatomic, strong) NSString *inspectionId;  //主键

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *status;    

@property (nonatomic, strong) NSString *description;

@property (nonatomic, strong) NSString *executor;

@property (nonatomic, strong) NSString *principal;

@property (nonatomic, strong) NSString *memo;

@property (nonatomic, strong) NSString *startTime;

@property (nonatomic, strong) NSString *endTime;

@property(nonatomic,strong) NSMutableArray *cis;  //设备资产

@property(nonatomic,strong) NSMutableArray *cicategory;  //设备类别

@end
