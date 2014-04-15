//
//  ActionListener.m
//  SmartITSM
//

#import "ActionListener.h"

@interface ActionListener()

@property (strong, nonatomic) NSString* action;

@end

@implementation ActionListener

@synthesize action;

- (id)initWith:(NSString *)pAction
{
    self = [super init];
    if (self)
    {
        self.action = pAction;
    }
    return self;
}

- (void)setAction:(NSString *)pAction
{
    action = pAction;
}

- (NSString *)getAction
{
    return action;
}

- (void)didAction:(CCActionDialect *)dialect
{
    // Nothing
}

@end
