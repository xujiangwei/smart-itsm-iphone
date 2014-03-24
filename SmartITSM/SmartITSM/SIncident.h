//
//  SIncident.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "SUser.h"
@interface SIncident : NSObject

/**************Incident基本信息******/
@property (nonatomic, strong) NSString *incidentId;  //主键（无业务意义）

@property(nonatomic,strong) NSString  *code;// 工单号

@property(nonatomic,strong) NSString *state;// 状态

@property(nonatomic,strong) NSString *summary;// 摘要

@property(nonatomic,strong) NSString *description;// 描述

@property(nonatomic,strong) NSString *applicant;// 申报人

@property(nonatomic,strong) NSString *creator;// 创建人

@property(nonatomic,strong)  NSString  *closeTime;// 关闭时间

@property(nonatomic,strong)  NSString *urgent;// 紧急程度

@property(nonatomic,strong)  NSString *impact;// 影响程度

@property (nonatomic,strong) NSString * serviceLevel; //优先级

@property(nonatomic,strong) NSString  *category;       //类别

@property(nonatomic,strong) NSString  *influencer;     //影响人

@property(nonatomic,strong) NSString  *occurTime;      //发生时间

@property(nonatomic,strong) NSString  *replyMode;      //回复方式

@property(nonatomic,assign) BOOL  isMajor;        //是否重大事故

// @property(nonatomic,strong) NSString *;    //触发类型

@property(nonatomic,strong) NSString  *contact;      //联系人

@property(nonatomic,strong) NSString *reportWays;     //报告方式

@property(nonatomic,strong) NSString *creatTime; //创建时间

@property(nonatomic,strong) NSString *updateTime; //更新时间

@property(nonatomic,strong) NSString *jbpmTransition;     //临时变量，不持久化

/*************Incident 关联模块信息*/
@property(nonatomic,strong) NSMutableArray *ciSet;  //相关的配置项

@property(nonatomic,strong) NSMutableArray *bizSystemSet;  //相关的配置项

@property(nonatomic,strong) NSMutableArray *logSet;//日志集

@property(nonatomic,strong) NSMutableArray *assocatesBpSet;//关联工单

@property(nonatomic,strong) NSMutableArray *referenceSet;//参考集

@end
