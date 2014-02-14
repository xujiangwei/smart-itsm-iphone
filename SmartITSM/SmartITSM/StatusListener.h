//
//  StatusListener.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "Failure.h"

@interface StatusListener : NSObject

/** 当连接建立时，该方法被调用。
 */
- (void)didConnected:(NSString *)identifier;


/** 当连接断开时，该方法被调用。
 */
- (void)didDisconnected:(NSString *)identifier;


/** 当发生故障时，该方法被调用。
 */
- (void)didFailed:(NSString *)identifier failure:(Failure *)failure;

@end
