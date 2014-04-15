//
//  Contact.h
//  SmartITSM
//

#import <Foundation/Foundation.h>

@interface Contact : NSObject

- (id)initWith:(NSString *)identifier address:(NSString *)address port:(NSUInteger)port;

@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *address;
@property (assign, nonatomic) NSUInteger port;

@end
