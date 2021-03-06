//
//  MastEngine.m
//  SmartITSM
//

#import "MastEngine.h"
#import "SDatabase.h"
#import "ActionListener.h"
#import "StatusListener.h"
#import "Contact.h"
#import "ListenerSet.h"

@interface MastEngine ()
{
    BOOL _started;
}

// 动作监听器，key: cellet identifier
@property (strong, nonatomic) NSMutableDictionary *actionListeners;
// 状态监听器：key: cellet identifier
@property (strong, nonatomic) NSMutableDictionary *statusListeners;

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
        _started = NO;

        self.actionListeners = [[NSMutableDictionary alloc] initWithCapacity:2];
        self.statusListeners = [[NSMutableDictionary alloc] initWithCapacity:2];
    }

    return self;
}

- (void)applicationDidFinishLaunchingWithOptions:(UIApplication *)application
{
    [[SDatabase sharedSingleton] open];
    [self start];
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    [[SDatabase sharedSingleton] open];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[SDatabase sharedSingleton] close];
    [self stop];
}

- (BOOL)start
{
    if (_started)
    {
        return YES;
    }

    CCNucleusConfig *config = [[CCNucleusConfig alloc] init:CONSUMER device:PHONE];
    CCNucleus *nucleus = [CCNucleus createSingletonWith:config];

    if (![nucleus startup])
    {
        return NO;
    }

    // 设置监听器
    [CCTalkService sharedSingleton].listener = self;

    _started = YES;

    return YES;
}

- (void)stop
{
    if (!_started)
    {
        return;
    }

    _started = NO;

    [CCTalkService sharedSingleton].listener = nil;
    [[CCNucleus sharedSingleton] shutdown];
}

- (BOOL)hasStarted
{
    return _started;
}

- (BOOL)contactCellet:(Contact *)contact reconnection:(BOOL)reconnection
{
    if (reconnection)
    {
        // 强制重连，先断开
        [[CCTalkService sharedSingleton] hangUp:contact.identifier];
    }

    if (!reconnection && [[CCTalkService sharedSingleton] isCalled:contact.identifier])
    {
        // 不是强制重连，并且已经 call 了 Cellet，则返回
        return YES;
    }

    CCInetAddress *address = [[CCInetAddress alloc] initWithAddress:contact.address port:contact.port];
    return [[CCTalkService sharedSingleton] call:contact.identifier hostAddress:address];
}

#pragma mark - Listener methods

- (void)addActionListener:(NSString *)identifier listener:(ActionListener *)listener
{
    ListenerSet *set = [self.actionListeners objectForKey:identifier];
    if (nil != set)
    {
        [set add:listener];
    }
    else
    {
        set = [[ListenerSet alloc] init];
        [set add:listener];
        [self.actionListeners setObject:set forKey:identifier];
    }
}

- (void)removeActionListener:(NSString *)identifier listener:(ActionListener *)listener
{
    ListenerSet *set = [self.actionListeners objectForKey:identifier];
    if (nil != set)
    {
        [set remove:listener];
        if ([set isEmpty])
        {
            [self.actionListeners removeObjectForKey:identifier];
        }
    }
}

- (void)addStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener
{
    NSMutableArray *array = [self.statusListeners objectForKey:identifier];
    if (nil != array)
    {
        [array addObject:statusListener];
    }
    else
    {
        array = [[NSMutableArray alloc] initWithCapacity:2];
        [array addObject:statusListener];
        [self.statusListeners setObject:array forKey:identifier];
    }
}

- (void)removeStatusListener:(NSString *)identifier statusListener:(StatusListener *)statusListener
{
    NSMutableArray *array = [self.statusListeners objectForKey:identifier];
    if (nil != array)
    {
        [array removeObject:statusListener];
        if (array.count == 0)
        {
            [self.statusListeners removeObjectForKey:identifier];
        }
    }
}

#pragma mark - Action Methods

- (BOOL)performAction:(NSString *)celletIdentifier action:(CCActionDialect *)action
{
    return [[CCTalkService sharedSingleton] talk:celletIdentifier dialect:action];
}

- (BOOL)asynPerformAction:(NSString *)celletIdentifier action:(CCActionDialect *)action
{
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        [[CCTalkService sharedSingleton] talk:celletIdentifier dialect:action];
    });
    return TRUE;
}

#pragma mark - Action dialect

- (void)doAction:(CCActionDialect *)dialect
{
    ListenerSet *set = [self.actionListeners objectForKey:dialect.celletIdentifier];
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

    ListenerSet *set = [self.actionListeners objectForKey:identifier];
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
    
    NSMutableArray *list = [self.statusListeners objectForKey:identifier];
    if (nil != list)
    {
        for (StatusListener *statusListener in list)
        {
            [statusListener didConnected:identifier];
        }
    }
}

- (void)quitted:(NSString *)identifier tag:(NSString *)tag
{
    [CCLogger d:@"quitted : identifier=%@ tag=%@", identifier, tag];
    
    NSMutableArray *list = [self.statusListeners objectForKey:identifier];
    if (nil != list)
    {
        for (StatusListener *statusListener in list)
        {
            [statusListener didDisconnected:identifier];
        }
    }
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
    
    NSMutableArray *list = [self.statusListeners objectForKey:failure.sourceCelletIdentifier];
    if (nil != list)
    {
        for (StatusListener *statusListener in list)
        {
            Failure *fail = [[Failure alloc] initWith:failure.code description:failure.description reason:failure.reason];
            [statusListener didFailed:failure.sourceCelletIdentifier failure:fail];
        }
    }
}

@end
