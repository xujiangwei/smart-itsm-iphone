//
//  MastEngine.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#include "Cell.h"

@interface MastEngine : NSObject

/** 返回单例。
 */
+ (MastEngine *)sharedSingleton;

- (void)applicationDidFinishLaunchingWithOptions:(UIApplication *)application;

- (void)applicationDidBecomeActive:(UIApplication *)application;

- (void)applicationWillResignActive:(UIApplication *)application;

@end
