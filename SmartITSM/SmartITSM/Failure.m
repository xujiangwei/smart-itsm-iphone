//
//  Failure.m
//  SmartITSM
//

#import "Failure.h"

@implementation Failure

- (id)initWith:(NSInteger)code description:(NSString *)description reason:(NSString *)reason
{
    if (self = [super init])
    {
        self.code = code;
        self.description = description;
        self.reason = reason;
    }
    
    return self;
}

@end
