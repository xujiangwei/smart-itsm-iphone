//
//  MastEngine.m
//  SmartITSM
//

#import "MastEngine.h"
#import "ActionListener.h"
#import "StatusListener.h"
#import "Contacts.h"
#import "ListenerSet.h"

@interface MastEngine ()

// 动作监听器，key: cellet identifier
@property (strong, nonatomic) NSMutableDictionary *listeners;

@end


@implementation MastEngine

/// 实例
static MastEngine *sharedInstance = nil;

+ (MastEngine *)sharedSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[MastEngine alloc] init];
    });
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        self.listeners = [[NSMutableDictionary alloc] initWithCapacity:2];
    }

    return self;
}

- (BOOL)start
{
    return YES;
}

- (void)stop
{
    
}

#pragma mark - Listener methods

- (void)addListener:(NSString *)identifier action:(NSString *)action listener:(ActionListener *)listener
{
    ListenerSet *set = [self.listeners objectForKey:identifier];
    if (nil != set)
    {
        [set add:action listener:listener];
    }
    else
    {
        set = [[ListenerSet alloc] init];
        [set add:action listener:listener];
        [self.listeners setObject:set forKey:identifier];
    }
}

- (void)removeListener:(NSString *)identifier action:(NSString *)action listener:(ActionListener *)listener
{
    ListenerSet *set = [self.listeners objectForKey:identifier];
    if (nil != set)
    {
        [set remove:action listener:listener];
        if ([set isEmpty])
        {
            [self.listeners removeObjectForKey:identifier];
        }
    }
}

#pragma mark - Action dialect

- (void)doAction:(CCActionDialect *)dialect
{
    ListenerSet *set = [self.listeners objectForKey:dialect.celletIdentifier];
    if (nil != set)
    {
        NSArray *list = [set getListenersWithName:dialect.action];
        for (ActionListener *listener in list)
        {
            [listener didAction:dialect];
        }
    }
}

#pragma mark - Talk Listener

- (void)dialogue:(NSString *)identifier primitive:(CCPrimitive *)primitive
{
    if (![primitive isDialectal])
    {
        [CCLogger d:@"Primitive is not a dialect"];
        return;
    }

    if (![primitive.dialect.name isEqualToString:ACTION_DIALECT_NAME])
    {
        [CCLogger d:@"Primitive is not an action dialect"];
        return;
    }

    CCActionDialect *action = (CCActionDialect *)primitive.dialect;

    ListenerSet *set = [self.listeners objectForKey:identifier];
    if (nil != set)
    {
        // 使用委派方式
        [action act:self];
    }

    [CCLogger d:@"action acted (thread:%@)", [NSThread currentThread]];
}

- (void)contacted:(NSString *)identifier tag:(NSString *)tag
{
    [CCLogger d:@"contacted : identifier=%@ tag=%@", identifier, tag];
}

- (void)quitted:(NSString *)identifier tag:(NSString *)tag
{
    [CCLogger d:@"quitted : identifier=%@ tag=%@", identifier, tag];
}

- (void)suspended:(NSString *)identifier tag:(NSString *)tag
        timestamp:(NSTimeInterval)timestamp mode:(CCSuspendMode)mode
{
    [CCLogger d:@"suspended : identifier=%@ tag=%@", identifier, tag];
}

- (void)resumed:(NSString *)identifier tag:(NSString *)tag
      timestamp:(NSTimeInterval)timestamp primitive:(CCPrimitive *)primitive
{
    [CCLogger d:@"resumed : identifier=%@ tag=%@", identifier, tag];
}

- (void)failed:(CCTalkServiceFailure *)failure
{
    [CCLogger d:@"failed - Code:%d - Reason:%@ - Desc:%@", failure.code, failure.reason, failure.description];
}

@end
