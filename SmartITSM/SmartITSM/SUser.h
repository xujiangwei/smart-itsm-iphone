//
//  :;
//  SmartITOM
//


#import <Foundation/Foundation.h>

@interface SUser : NSObject
//用户ID
@property (nonatomic, assign) long long userId;

//用户名
@property (nonatomic, strong) NSString *userName;

//密码
@property (nonatomic, strong) NSString *userPsw;

//记住密码
@property (nonatomic, assign) BOOL rememberable;

//自动登录
@property (nonatomic, assign) BOOL autoSignin;

//查询所有用户
+ (NSMutableArray *)getAllUserNameList;

//查询上次登录的用户
+ (SUser *)getLastUser;

//根据用户名得到SUser
+ (SUser *)getUserWithUserName:(NSString *)username;

//更新最近登录的用户
+ (void)updateLastLogin;

//查询用户count
+ (NSInteger)getUsersCount;

//插入新用户
+ (void)insertUser:(SUser*)user;

//是否存在该用户
+(BOOL)existsTheUser:(NSString *)name;

//查询用户的id
+ (long long)getUserId:(NSString*)name;

//更新用户信息
+ (void)updateUser:(SUser*)user;

//更新用户token
+ (void)updateToken:(NSString *)token;

//查询用户token
+ (NSString *)getToken;

+ (void)updateUserId:(long long)userId;

+ (long long)getUserId;

+ (NSString *)getLastSigninIp;

+ (NSInteger )getLastSigninPort;

+ (BOOL)isSignin;

+ (void)updateIsSignin:(long long)userId;

+ (void)SignOut;

+ (NSString *)getUserName:(long long)userId;
@end
