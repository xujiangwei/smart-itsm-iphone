//
//  SAlarm.h
//  SmartITOM
//


#import <Foundation/Foundation.h>

typedef enum
{
    //严重警告
    seriousAlarm = 1,
    //主要警告
    mainAlarm = 2,
    //次要警告
    minorAlarm = 3,
    //警告
    Alarm = 4,
    //未知
    UnkownAlarm = 5,
    
}  AlarmLevel;

@interface SAlarm : NSObject

@property (nonatomic, assign) long ID;                   //告警id

@property (nonatomic, strong) NSString *objectOfManagement;   //管理对象

@property (nonatomic, strong) NSString *location;             //定位

@property (nonatomic, assign) AlarmLevel level;                //级别

@property (nonatomic, assign) long resourceId;                //设备ID

@property (nonatomic, strong) NSString *deviceIp;             //IP

@property (nonatomic, strong) NSString *resourceType;          //设备类型

@property (nonatomic, strong) NSString *reason;               //原因

@property (nonatomic, strong) NSString *detailReason;         //详情

@property (nonatomic, strong) NSString *alarmStatus;          //告警状态

@property (nonatomic, assign) double firstTime;            //初始发生时间

@property (nonatomic, assign) double lastTime;             //最近发生时间

//@property (nonatomic, strong) NSString *alarmTrend;           //告警趋势

@property (nonatomic, assign) NSInteger numOfRepeat;          //重复次数

@property (nonatomic, assign) NSInteger numOfUpgradeOrDegrada;//自动升/降级次数

@property (nonatomic, strong) NSString *confirmorAndTime;     //确认人/时间

@property (nonatomic, strong) NSString *confirmor;            //确认人

@property (nonatomic, assign) double confirmTime;          //确认时间

@property (nonatomic, strong) NSString *deleterAndTime;       //删除人/时间

@property (nonatomic, strong) NSString *deleter;              //删除人

@property (nonatomic, assign) double deleteTime;           //删除时间

@property (nonatomic, strong) NSMutableArray *alarmHandleArray;          //告警处理   类型需修改

//@property (nonatomic, strong) NSString *maintainExperience;   //维护经验   类型需修改
//
//@property (nonatomic, strong) NSString *effectArea;           //影响范围   类型需修改



@end
