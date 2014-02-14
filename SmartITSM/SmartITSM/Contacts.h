//
//  Contacts.h
//  SmartITSM
//

#import <Foundation/Foundation.h>


@interface ContactAddress : NSObject

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *host;
@property (assign, nonatomic) NSUInteger port;

@end


@interface Contacts : NSObject

- (void)addAddress:(NSString *)identifier host:(NSString *)host port:(NSUInteger)port;

- (NSArray *)getAddresses;

@end
