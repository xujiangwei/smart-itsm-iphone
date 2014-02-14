//
//  Failure.h
//  SmartITSM
//

#import <Foundation/Foundation.h>

@interface Failure : NSObject

// 故障码
@property (assign, nonatomic) NSInteger code;

// 故障描述
@property (strong, nonatomic) NSString *description;

// 故障原因
@property (strong, nonatomic) NSString *reason;


- (id)initWith:(NSInteger)code description:(NSString *)description reason:(NSString *)reason;

@end
