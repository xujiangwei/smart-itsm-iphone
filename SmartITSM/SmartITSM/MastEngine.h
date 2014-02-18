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


/** 启动引擎。
 */
- (BOOL)start:(Contacts *)contacts;

/** 停止引擎。
 */
- (void)stop;


/** 添加监听器
 */
- (void)addListener:(NSString *)identifier action:(NSString *)action listener:(ActionListener *)listener;

/** 移除监听器
 */
- (void)removeListener:(NSString *)identifier action:(NSString *)action listener:(ActionListener *)listener;

/** 添加状态监听器
 */
- (void)addStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener;

/** 移除状态监听器
 */
- (void)removeStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener;


@end
