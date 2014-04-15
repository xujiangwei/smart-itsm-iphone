//
//  ActionListener.m
//  SmartITSM
//

#import "ActionListener.h"

@interface ActionListener()

@property (strong, nonatomic) NSString* action;

@end

@implementation ActionListener

- (id)initWith:(NSString *)action
{
    self = [super init];
    if (self)
    {
        self.action = action;
    }
    return self;
}

- (void)setAction:(NSString *)action
{
    self.action = action;
}

- (NSString *)getAction
{
    return self.action;
}

- (void)didAction:(CCActionDialect *)dialect
{
    // Nothing
}

@end
