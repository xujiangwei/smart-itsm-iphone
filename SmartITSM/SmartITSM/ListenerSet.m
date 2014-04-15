//
//  ListenerSet.m
//  SmartITSM
//

#import "ListenerSet.h"
#import "ActionListener.h"

@implementation ListenerSet

- (id)init
{
    if (self = [super init])
    {
        self.listeners = [[NSMutableDictionary alloc] initWithCapacity:8];
    }

    return self;
}


- (void)add:(ActionListener *)listener
{
    NSMutableArray *list = [self.listeners objectForKey:[listener getAction]];
    if (nil != list)
    {
        [list addObject:listener];
    }
    else
    {
        list = [[NSMutableArray alloc] initWithCapacity:1];
        [list addObject:listener];
        [self.listeners setObject:list forKey:[listener getAction]];
    }
}


- (void)remove:(ActionListener *)listener
{
    NSMutableArray *list = [self.listeners objectForKey:[listener getAction]];
    if (nil != list)
    {
        [list removeObject:listener];
        if (list.count == 0)
        {
            [self.listeners removeObjectForKey:[listener getAction]];
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
