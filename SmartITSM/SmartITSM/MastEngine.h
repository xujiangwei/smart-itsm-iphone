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


/**
 */
- (void)addListener:(NSString *)identifier action:(NSString *)action listener:(ActionListener *)listener;

/**
 */
- (void)removeListener:(NSString *)identifier action:(NSString *)action listener:(ActionListener *)listener;

@end
