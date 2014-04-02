//
//  SUser.m
//  SmartITOM
//


#import "SUser.h"
#import "SDatabase.h"
#import "FMResultSet.h"

@implementation SUser


//查询所有用户
+ (NSMutableArray *)getAllUserNameList
{
    NSMutableArray *nameList = [[NSMutableArray alloc]initWithCapacity:10];
    
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    
    NSString * sql = [NSString stringWithFormat:@"SELECT user_name FROM tb_user"];
    
    rs = [db executeQuery:sql];
    
    while ( [rs next])
    {
        NSString *name = [rs stringForColumnIndex:0];
        
        [nameList addObject:name];
    }
    return nameList;
}

//查询上次登录的用户
+ (SUser *)getLastUser
{
    SUser *user = [[SUser alloc]init];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    NSString *sql = [NSString stringWithFormat:@"SELECT user_id, user_name, user_psw, rmb_psw, auto_signin FROM tb_user WHERE last_signin = 1"];
    rs = [db executeQuery:sql];
    while ([rs next])
    {
        NSInteger userid = [rs intForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        NSString *psw = [rs stringForColumnIndex:2];
        BOOL remenber = [rs boolForColumnIndex:3];
        BOOL autoSignin = [rs boolForColumnIndex:4];
        
        [user setUserId:userid];
        [user setUserName:name];
        [user setUserPsw:psw];
        [user setRememberable:remenber];
        [user setAutoSignin:autoSignin];
    }
    
    return user;
}

//根据用户名得到SUser
+ (SUser *)getUserWithUserName:(NSString *)username
{
    SUser *user = [[SUser alloc]init];
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    NSString *sql = [[NSString alloc]initWithFormat:@"SELECT user_id, user_name, user_psw, rmb_psw, auto_signin FROM tb_user WHERE user_name = '%@'",username];
    rs = [db executeQuery:sql];
    while ([rs next])
    {
        NSInteger userid = [rs intForColumnIndex:0];
        NSString *name = [rs stringForColumnIndex:1];
        NSString *psw = [rs stringForColumnIndex:2];
        BOOL remenber = [rs boolForColumnIndex:3];
        BOOL autoSignin = [rs boolForColumnIndex:4];
        
        [user setUserId:userid];
        [user setUserName:name];
        [user setUserPsw:psw];
        [user setRememberable:remenber];
        [user setAutoSignin:autoSignin];
    }
    return user;

}

//更新最近登录的用户
+ (void)updateLastLogin
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_user SET last_signin = 0 WHERE last_signin = 1"];
    if ([db executeUpdate:sql])
    {
        NSLog(@"update lastLogin successed");
    }else
    {
        NSLog(@"update lastLogin failed");
    }
}


//查询用户count
+ (NSInteger)getUsersCount
{
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    
    NSInteger count;
    
    NSString *sql = @"SELECT COUNT(*) FROM tb_user";
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        count = [rs doubleForColumnIndex:0]; 
    }
    
    return count;
}


//插入新用户
+ (void)insertUser:(SUser*)user
{
    SDatabase *db = [SDatabase sharedSingleton];
    
//    NSString *password = @"";
//    if (user.rememberable)
//    {
//        password  = user.userPsw ;
//    }

    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO tb_user (user_id,user_name, user_psw,last_signin, is_signin) VALUES ("];
    [sql appendFormat:@"%d,",0];
    [sql appendFormat:@"'%@',",user.userName];
    [sql appendFormat:@"'%@',", user.userPsw];
    [sql appendFormat:@"%d,",1];
    [sql appendFormat:@"%d)",0];
//    NSLog(@"sql = %@",sql);
    
    if ([db executeUpdate:sql])
    {
        NSLog(@"insert a user successed");
    }
    else
    {
        NSLog(@"inset a user failed");
    }
}

//是否存在该用户
+(BOOL)existsTheUser:(NSString *)name
{
    BOOL result = TRUE;
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    
    NSString *sql = [NSString stringWithFormat:@"SELECT COUNT(*) FROM tb_user WHERE user_name = '%@'",name ];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
       NSInteger count = [rs doubleForColumnIndex:0];
        
        if (0 == count)
        {
            result = FALSE;
        }
    }
    return result;
}

//查询用户的id
+ (long long)getUserId:(NSString*)name
{
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    
    long long ID;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT user_id FROM tb_user WHERE user_name = '%@'",name ];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        ID = [rs longLongIntForColumnIndex:0];
    }
    return ID;
}

//更新用户信息
+ (void)updateUser:(SUser*)user
{
    SDatabase *db = [SDatabase sharedSingleton];
    
    int autoL = user.autoSignin ? 1 : 0;
 
    NSString *password = @"";
    
    if (user.rememberable)
    {
        password = user.userPsw;
    }
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_user SET user_psw = '%@',rmb_psw = %d,auto_signin = %d,last_signin = 1 WHERE user_id = %lld",password, user.rememberable ? 1 : 0, autoL, user.userId];
    NSLog(@"sql = %@",sql);
    
    if ([db executeUpdate:sql])
    {
        NSLog(@"update successed");
    }else
    {
        NSLog(@"update failed");
    }
}

+ (void)updateToken:(NSString *)token
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_user SET token = '%@' WHERE last_signin = 1",token];
    
    if ([db executeUpdate:sql])
    {
        NSLog(@"update token successed");
    }else
    {
        NSLog(@"update token failed");
    }
}



+ (NSString *)getToken
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *token;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT token FROM tb_user WHERE last_signin = 1"];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        token = [rs stringForColumnIndex:0];
    }
    return token;
}

+ (void)updateUserId:(long long)userId
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_user SET user_id = '%lld' WHERE last_signin = 1",userId];
    if ([db executeUpdate:sql])
    {
        NSLog(@"update userId successed");
    }else
    {
        NSLog(@"update userId failed");
    }
}

+ (long long)getUserId
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    long long userId = NSNotFound;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT user_id FROM tb_user WHERE last_signin = 1"];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        userId = [rs longLongIntForColumnIndex:0];
    }
    return userId;
}


+ (BOOL)isSignin
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    BOOL result;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT is_signin FROM tb_user WHERE last_signin = 1"];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        result = [rs boolForColumnIndex:0];
    }
    return result;

}

+ (void)updateIsSignin:(long long)userId
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_user SET is_signin = %d WHERE user_id = '%lld'",1,userId];
    if ([db executeUpdate:sql])
    {
        NSLog(@"update isSignin successed");
    }else
    {
        NSLog(@"update isSignin failed");
    }

}

+ (void)SignOut
{
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_user SET is_signin = %d WHERE last_signin = 1",0];
    if ([db executeUpdate:sql])
    {
        NSLog(@"update SignOut successed");
    }else
    {
        NSLog(@"update SignOut failed");
    }
    
}

+ (NSString *)getUserName:(long long)userId
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *name = nil;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT user_name FROM tb_user WHERE user_id = %lld",userId];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        name = [rs stringForColumnIndex:0];
    }
    return name;

}

//查询当前用户的ip
+ (NSString *)getLastSigninIp
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSString *ip = nil;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT ip FROM tb_ip_port WHERE last_signin = 1"];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        ip = [rs stringForColumnIndex:0];
    }
    return ip;
}

//查询当前用户的port
+ (NSInteger )getLastSigninPort
{
    SDatabase *db = [SDatabase sharedSingleton];
    FMResultSet *rs;
    
    NSInteger port = 0;
    
    NSString *sql =[NSString stringWithFormat:@"SELECT port FROM tb_ip_port WHERE last_signin = 1"];
    
    rs = [db executeQuery:sql];
    
    while ([rs next])
    {
        port = [rs intForColumnIndex:0];
    }
    return port;
}

//更新服务器ip, port
+ (BOOL)updateSeverIp:(NSString *)ip andPort:(NSUInteger)port
{
    BOOL result;
    
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"UPDATE tb_ip_port SET last_signin = 0 WHERE last_signin = 1"];
    if([db executeUpdate:sql])
    {
        result = YES;
    }
    else
    {
        result = NO;
    }
    return result;

}

//插入服务器ip,port
+ (BOOL)insertSeverIp:(NSString *)ip andPort:(NSUInteger)port
{
    BOOL result;
    
    SDatabase *db = [SDatabase sharedSingleton];
    NSMutableString *sql = [NSMutableString stringWithFormat:@"INSERT INTO tb_ip_port (ip, port, last_signin) VALUES (\"%@\",%d,%d)",ip, port, 1];
   
    if ([db executeUpdate:sql])
    {
        result = YES;
        NSLog(@"insert ip port successed");
    }
    else
    {
        result = NO;
        NSLog(@"insert ip port failed");
    }
    return result;
}




@end
