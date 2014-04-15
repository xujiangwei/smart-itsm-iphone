//
//  Contact.m
//  SmartITSM
//

#import "Contact.h"

@implementation Contact

- (id)initWith:(NSString *)identifier address:(NSString *)address port:(NSUInteger)port
{
    self = [super init];
    if (self)
    {
        self.identifier = identifier;
        self.address = address;
        self.port = port;
    }

    return self;
}

@end
