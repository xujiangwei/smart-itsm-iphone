//
//  APPListener.h
//  SmartITSM
//
//  Created by 朱国强 on 14-2-18.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "ActionListener.h"

@interface APPListener : ActionListener
/** 当发生指定的动作时，该方法被调用。
 */
- (void)didAction:(CCActionDialect *)dialect;
@end
