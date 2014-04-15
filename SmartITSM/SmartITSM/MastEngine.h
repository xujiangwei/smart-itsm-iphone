//
//  MastEngine.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "MastPrerequisites.h"

@interface MastEngine : NSObject <CCTalkListener, CCActionDelegate>

/** 返回单例。
 */
+ (MastEngine *)sharedSingleton;

- (void)applicationDidFinishLaunchingWithOptions:(UIApplication *)application;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)applicationWillResignActive:(UIApplication *)application;


/** 启动引擎。
 */
- (BOOL)start;

/** 停止引擎。
 */
- (void)stop;

/** 是否已启动。
 */
- (BOOL)hasStarted;

/** 添加服务器联系人。
 */
- (void)addContact:(Contact *)contact;

/** 删除服务器联系人。
 */
- (void)removeContact:(NSString *)identifier;

/** 重置联系服务器。
 */
- (void)resetContact;

/** 添加监听器
 */
- (void)addListener:(NSString *)identifier listener:(ActionListener *)listener;

/** 移除监听器
 */
- (void)removeListener:(NSString *)identifier listener:(ActionListener *)listener;

/** 添加状态监听器
 */
- (void)addStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener;

/** 移除状态监听器
 */
- (void)removeStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener;

/** 执行动作。
 */
- (BOOL)performAction:(NSString *)identifier action:(CCActionDialect *)action;

/** 异步发送方言。
 */
- (BOOL)asynPerformAction:(NSString *)identifier action:(CCActionDialect *)action;

@end
