//
//  ListenerSet.m
//  SmartITSM
//

#import "ListenerSet.h"

@implementation ListenerSet

- (id)init
{
    if (self = [super init])
    {
        self.listeners = [[NSMutableDictionary alloc] initWithCapacity:8];
    }
    
    return self;
}


- (void)add:(NSString *)name listener:(ActionListener *)listener
{
    NSMutableArray *list = [self.listeners objectForKey:name];
    if (nil != list)
    {
        [list addObject:listener];
    }
    else
    {
        list = [[NSMutableArray alloc] initWithCapacity:1];
        [list addObject:listener];
        [self.listeners setObject:listener forKey:name];
    }
}


- (void)remove:(NSString *)name listener:(ActionListener *)listener
{
    NSMutableArray *list = [self.listeners objectForKey:name];
    if (nil != list)
    {
        [list removeObject:listener];
        if (list.count == 0)
        {
            [self.listeners removeObjectForKey:name];
        }
    }
}


- (NSArray *)getListenersWithName:(NSString *)name
{
    return [self.listeners objectForKey:name];
}


- (BOOL)isEmpty
{
    return (self.listeners.count == 0 ? YES : NO);
}

@end
