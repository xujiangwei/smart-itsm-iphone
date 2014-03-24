//
//  SProblem.m
//  SmartITOM
//


#import "SProblem.h"

@implementation SProblem

@synthesize problemId;  //主键（无业务意义）

@synthesize code;// 工单号

@synthesize state;// 状态

@synthesize summary;// 摘要

@synthesize description;// 症状及描述

@synthesize creator;// 创建人

@synthesize creatTime;// 创建时间

@synthesize problemSource;//问题来源

@synthesize category; //问题类型

@synthesize urgent;// 紧急程度

@synthesize impact;// 影响程度

@synthesize serviceLevel; //优先级

@synthesize occurTime;    //发现时间

@synthesize findType;      //发现方式

@synthesize applicant;// 申报人

@synthesize influencer;  //影响人

@synthesize updateTime; //更新时间

@synthesize ciSet; //配置项

@synthesize bizSystemSet;  //业务系统

@synthesize assocatesBpSet;  //关联工单

@synthesize logSet;//日志集

@synthesize referenceSet;//参考集

@synthesize jbpmTransition;


@end
