//
//  ActionListener.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "MastPrerequisites.h"

@interface ActionListener : NSObject

- (id)initWith:(NSString *)pAction;

/** 设置动作名。
 */
- (void)setAction:(NSString *)pAction;

/** 返回动作名。
 */
- (NSString *)getAction;

/** 当发生指定的动作时，该方法被调用。
 */
- (void)didAction:(CCActionDialect *)dialect;

@end
