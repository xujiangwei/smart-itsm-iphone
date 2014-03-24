//
//  SDatabase.h
//  SmartITOM
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"

@interface SDatabase : NSObject


/** 返回单例。
 */
+ (SDatabase *)sharedSingleton;

/** 打开数据库。
 */
- (BOOL)open;

/** 关闭数据库。
 */
- (void)close;

/** 执行查询。
 */
- (FMResultSet *)executeQuery:(NSString*)sql, ...;
- (FMResultSet *)executeQueryWithFormat:(NSString*)format, ...;
- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments;
- (FMResultSet *)executeQuery:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments;

/** 执行更新
 */
- (BOOL)executeUpdate:(NSString*)sql, ...;
- (BOOL)executeUpdateWithFormat:(NSString *)format, ...;
- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments;
- (BOOL)executeUpdate:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments;


- (NSString*)lastErrorMessage;


@end
