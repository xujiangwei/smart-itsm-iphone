//
//  MastEngine.m
//  SmartITSM
//

#import "MastEngine.h"

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
    }

    return self;
}

- (void)applicationDidFinishLaunchingWithOptions:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    
}

@end
