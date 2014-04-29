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

/** 连接服务器。
 */
- (BOOL)contactCellet:(Contact *)contact reconnection:(BOOL)reconnection;

/** 添加动作监听器。
 */
- (void)addActionListener:(NSString *)identifier listener:(ActionListener *)listener;

/** 移除动作监听器。
 */
- (void)removeActionListener:(NSString *)identifier listener:(ActionListener *)listener;

/** 添加状态监听器。
 */
- (void)addStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener;

/** 移除状态监听器。
 */
- (void)removeStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener;

/** 执行动作。
 */
- (BOOL)performAction:(NSString *)identifier action:(CCActionDialect *)action;

/** 异步发送方言。
 */
- (BOOL)asynPerformAction:(NSString *)identifier action:(CCActionDialect *)action;

@end
