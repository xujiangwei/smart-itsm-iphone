//
//  SIncident.m
//  SmartITOM
//


#import "SIncident.h"

@implementation SIncident

@synthesize incidentId;

@synthesize  code;// 工单号

@synthesize  state;// 状态

@synthesize  summary;// 摘要

@synthesize  description;// 描述

@synthesize  applicant;// 申报人

@synthesize  creator;// 创建人

@synthesize creatTime; //创建时间

@synthesize updateTime; //更新时间

@synthesize  closeTime;// 关闭时间

@synthesize  urgent;// 紧急程度

@synthesize  impact;// 影响程度

@synthesize  serviceLevel; //优先级

@synthesize  ciSet;  //相关的配置项

@synthesize  logSet;//日志集

@synthesize assocatesBpSet;

@synthesize  referenceSet;//参考集

@synthesize  category;       //类别

@synthesize  influencer;     //影响人

@synthesize  occurTime;      //发生时间

@synthesize  replyMode;      //回复方式

@synthesize  isMajor;        //是否重大事故

//@synthesize  triggerType;    //触发类型

@synthesize  contact;      //联系人

@synthesize  reportWays;     //报告方式

@synthesize jbpmTransition;




@end
