//
//  ListenerSet.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "MastPrerequisites.h"

@interface ListenerSet : NSObject

@property (strong, nonatomic) NSMutableDictionary *listeners;

- (void)add:(ActionListener *)listener;

- (void)remove:(ActionListener *)listener;

- (NSArray *)getListenersWithName:(NSString *)name;

- (BOOL)isEmpty;

@end
