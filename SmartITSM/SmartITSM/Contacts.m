//
//  Contacts.m
//  SmartITSM
//

#import "Contacts.h"

@implementation ContactAddress

@end



@interface Contacts ()

@property (strong, nonatomic) NSMutableArray *addresses;

@end

@implementation Contacts

- (id)init
{
    if (self = [super init])
    {
        self.addresses = [[NSMutableArray alloc] initWithCapacity:2];
    }

    return self;
}

- (void)addAddress:(NSString *)identifier host:(NSString *)host port:(NSUInteger)port
{
    ContactAddress *addr = [[ContactAddress alloc] init];
    addr.identifier = identifier;
    addr.host = host;
    addr.port = port;
    [self.addresses addObject:addr];
}

- (NSArray *)getAddresses
{
    return self.addresses;
}

@end
