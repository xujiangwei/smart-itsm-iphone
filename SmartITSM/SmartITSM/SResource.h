//
//  SResource.h
//  SmartITSM
//
//  Created by 朱国强 on 14-4-14.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum _ResourceCategory
{
    Unkown = 0,                   //未知
    NetEquipment  = 1 ,           //网络设备
    DataBase  = 2,                //数据库
    Host = 3,                     //主机
    SavetyEquipment = 4,          //安全设备
    Middleware = 5,               //中间件
    Environment = 6,              //环境
    Storage = 7,                  //存储
    Other = 8,                    //其他
    All = 9                       //全部
    
    
} ResourceCategory;

@interface SResource : NSObject

@property (nonatomic, assign) BOOL        hasAttention;             //是否关注

@property (nonatomic, strong) NSString    *attentionTime;           //关注时间

@property (nonatomic, assign) NSInteger   resourceAlarmCount;

@property (nonatomic, assign) BOOL        hasMonitored;             //是否监控

@property (nonatomic, assign) int         resourceIpCount;

@property (nonatomic, strong) NSString    *vendor;                  //供应商name

@property (nonatomic, assign) int         vendorId;                 //供应商id

@property (nonatomic, strong) NSString    *vendorLogo;              //供应商logo

@property (nonatomic, assign) long        resourceId;               //资resourcesDicresourcesDic源id

@property (nonatomic, strong) NSString    *resourceName;            //资源名称

@property (nonatomic, strong) NSString    *resourceIp;              //资源ip

@property (nonatomic, assign) ResourceCategory   topCategory;      //资源一级分类：1，2，3，4

@property (nonatomic, strong) NSString     *topCategoryName;       //资源一级分类：主机，网络设备，数据库，中间件，安全设备

//@property (nonatomic, strong) NSString    *topCategoryPic;         //一级分类图片

@property (nonatomic, assign) NSInteger   secondCategory;          //资源二级分类：1010， 1206，1208

@property (nonatomic, strong) NSString    *secondCategoryName;   //资源二级分类：windows， linux, 路由器， 交换机，DB2,

@property (nonatomic, strong) NSString    *categoryPic;           //二级分类图片

@end
