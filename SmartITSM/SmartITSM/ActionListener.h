//
//  ActionListener.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "MastPrerequisites.h"

@interface ActionListener : NSObject

/** 当发生指定的动作时，该方法被调用。
 */
- (void)didAction:(CCActionDialect *)dialect;

@end
