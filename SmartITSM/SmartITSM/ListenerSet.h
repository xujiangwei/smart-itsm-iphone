//
//  ListenerSet.h
//  SmartITSM
//

#import <Foundation/Foundation.h>
#import "MastPrerequisites.h"

@interface ListenerSet : NSObject

@property (strong, nonatomic) NSMutableDictionary *listeners;

- (void)add:(NSString *)name listener:(ActionListener *)listener;

- (void)remove:(NSString *)name listener:(ActionListener *)listener;

- (NSArray *)getListenersWithName:(NSString *)name;

- (BOOL)isEmpty;

@end
