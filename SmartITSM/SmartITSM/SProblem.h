//
//  SProblem.h
//  SmartITOM
//


#import <Foundation/Foundation.h>

@interface SProblem : NSObject

/*************基本信息*/
@property (nonatomic, strong) NSString *problemId;  //主键（无业务意义）

@property(nonatomic,strong) NSString  *code;// 工单号

@property(nonatomic,strong) NSString *state;// 状态

@property(nonatomic,strong) NSString *summary;// 摘要

@property(nonatomic,strong) NSString *description;// 症状及描述

@property(nonatomic,strong) NSString *creator;// 创建人

@property(nonatomic,strong)  NSString  *creatTime;// 创建时间

@property(nonatomic,strong) NSString *problemSource;//问题来源

@property(nonatomic,strong) NSString  *category; //问题类型

@property(nonatomic,strong)  NSString *urgent;// 紧急程度

@property(nonatomic,strong)  NSString *impact;// 影响程度

@property (nonatomic,strong) NSString * serviceLevel; //优先级

@property(nonatomic,strong) NSString  *occurTime;    //发现时间

@property(nonatomic,strong) NSString  *findType;      //发现方式

/*************人员信息*/
@property(nonatomic,strong) NSString *applicant;// 申报人

@property(nonatomic,strong) NSString  *influencer;  //影响人

@property(nonatomic,strong) NSString *updateTime; //更新时间

/**************集合信息******/

@property(nonatomic,strong) NSMutableArray *ciSet;//配置项

@property(nonatomic,strong) NSMutableArray *bizSystemSet;  //相关的业务系统

@property(nonatomic,strong) NSMutableArray *assocatesBpSet;//关联工单

@property(nonatomic,strong) NSMutableArray *logSet;//日志集

@property(nonatomic,strong) NSMutableArray *referenceSet;//参考集

@property(nonatomic,strong) NSString *jbpmTransition;//参考集


@end
