//
//  SDatabase.m
//  SmartITSM
//


#import "SDatabase.h"

#define DATABASE_FILE @"SmartITSM.db"

@interface SDatabase()
{
    FMDatabase *_db;
}
@end

@implementation SDatabase

/// 实例
static SDatabase *sharedInstance = nil;

//------------------------------------------------------------------------------
+ (SDatabase *)sharedSingleton
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[SDatabase alloc] init];
    });
    return sharedInstance;
}
//------------------------------------------------------------------------------
- (id)init
{
    self = [super init];
    if (self)
    {
        _db = nil;
    }
    return self;
}
//------------------------------------------------------------------------------
- (BOOL)open
{
    if (nil == _db)
    {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        // 获取document目录
        NSString *documentDirectory = [paths objectAtIndex:0];
        // 追加文件系统路径
        NSString *path = [documentDirectory stringByAppendingPathComponent:DATABASE_FILE];
        
        NSLog(@"path = %@",path);
        
        if (![[NSFileManager defaultManager] fileExistsAtPath:path])
        {
            // Copy database file
            NSString *filePath = [[NSBundle mainBundle]pathForResource:@"SmartITSM" ofType:@"db"];
            
            [[NSFileManager defaultManager] copyItemAtPath:filePath toPath:path error:nil];
        }
        
        // 建立数据库连接
        _db = [FMDatabase databaseWithPath:path];
        
        // 打开数据库，资源和权限问题会导致连接失败。当数据库不存在，则重建一个。
        if ([_db open])
        {
            NSLog(@"Open database successed.");
            return TRUE;
        }
        else
        {
            NSLog(@"Open database failed.");
            _db = nil;
            return FALSE;
        }
    }
    
    return TRUE;
}
//------------------------------------------------------------------------------
- (void)close
{
    if (nil != _db)
    {
        [_db close];
        _db = nil;
        NSLog(@"Database closed");
    }
}
//------------------------------------------------------------------------------
- (FMResultSet *)executeQuery:(NSString*)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    id result = [_db executeQuery:sql withArgumentsInArray:nil orDictionary:nil orVAList:args];
    
    va_end(args);
    return result;
}
//------------------------------------------------------------------------------
- (FMResultSet *)executeQueryWithFormat:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSMutableString *sql = [NSMutableString stringWithCapacity:[format length]];
    NSMutableArray *arguments = [NSMutableArray array];
    [_db extractSQL:format argumentsList:args intoString:sql arguments:arguments];
    
    va_end(args);
    
    return [_db executeQuery:sql withArgumentsInArray:arguments];
}
//------------------------------------------------------------------------------
- (FMResultSet *)executeQuery:(NSString *)sql withArgumentsInArray:(NSArray *)arguments
{
    return [_db executeQuery:sql withArgumentsInArray:arguments];
}
//------------------------------------------------------------------------------
- (FMResultSet *)executeQuery:(NSString *)sql withParameterDictionary:(NSDictionary *)arguments
{
    return [_db executeQuery:sql withParameterDictionary:arguments];
}
//------------------------------------------------------------------------------
- (BOOL)executeUpdate:(NSString*)sql, ...
{
    va_list args;
    va_start(args, sql);
    
    BOOL result = [_db executeUpdate:sql error:nil withArgumentsInArray:nil orDictionary:nil orVAList:args];
    
    va_end(args);
    return result;
}
//------------------------------------------------------------------------------
- (BOOL)executeUpdateWithFormat:(NSString *)format, ...
{
    va_list args;
    va_start(args, format);
    
    NSMutableString *sql      = [NSMutableString stringWithCapacity:[format length]];
    NSMutableArray *arguments = [NSMutableArray array];
    
    [_db extractSQL:format argumentsList:args intoString:sql arguments:arguments];
    
    va_end(args);
    
    return [_db executeUpdate:sql withArgumentsInArray:arguments];
}
//------------------------------------------------------------------------------
- (BOOL)executeUpdate:(NSString*)sql withArgumentsInArray:(NSArray *)arguments
{
    return [_db executeUpdate:sql withArgumentsInArray:arguments];
}
//------------------------------------------------------------------------------
- (BOOL)executeUpdate:(NSString*)sql withParameterDictionary:(NSDictionary *)arguments
{
    return [_db executeUpdate:sql withParameterDictionary:arguments];
}
//------------------------------------------------------------------------------
- (NSString *)lastErrorMessage
{
    return [_db lastErrorMessage];
}

@end
