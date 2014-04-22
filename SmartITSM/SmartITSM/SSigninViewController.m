//
//  SSigninViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-3-18.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SSigninViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CommonCrypto/CommonDigest.h>
#import "TSMessage.h"
#import "MBProgressHUD.h"
#import "SSigninView.h"
#import "SConfigServerView.h"
#import "Reachability.h"
#import "MastEngine.h"
#import "Contact.h"
#import "SUser.h"


#define kDemoCelletName @"SmartITOM"

@interface SSigninViewController ()
{
    BOOL _signed;
    BOOL _connected;

    NSString *_user;
    NSString *_password;

    NSString *_address;
    NSInteger _port;
    
    MBProgressHUD *_signinHUD;
    MBProgressHUD *_connectHUD;

    Reachability* _hostReach;
    
    SUser *_currentUser;
    
    SSigninViewListener *_signinListener;
    
    SSigninViewStatusListener *_statusListener;
}

@end

@implementation SSigninViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // nothing
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        _signed = FALSE;
        _connected = FALSE;
        _hostReach = nil;
        
        _signinListener = [[SSigninViewListener alloc] initWith:@"login"];
        _signinListener.delegate = self;
        
        _statusListener = [[SSigninViewStatusListener alloc] init];
        _statusListener.delegate = self;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.signinView.hidden = NO;
    
    [[MastEngine sharedSingleton] addListener:kDemoCelletName listener:_signinListener];
    [[MastEngine sharedSingleton] addStatusListener:kDemoCelletName statusListener:_statusListener];

    // 加载本地数据
    if (![self loadLocalData])
    {
        // 数据加载失败，提示配置
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"您没有设置过服务器信息，\n请先设置服务器信息"
                                                       delegate:self
                                              cancelButtonTitle:@"我知道了"
                                              otherButtonTitles:@"现在设置", nil];
        [alert show];
    }
    else if([self loadLocalUserData])
    {
        // 加载成功
        // 隐藏登录信息界面
        self.signinView.hidden = YES;
        
        MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        HUD.mode = MBProgressHUDModeIndeterminate;
        HUD.labelText = @"正在登录请稍后";
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            sleep(2);
            
            dispatch_async(dispatch_get_main_queue(),^{
                [HUD hide:YES];
                _signinHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                _signinHUD.mode = MBProgressHUDModeIndeterminate;
                _signinHUD.labelText = @"正在登录请稍后";
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
                    
                    // 初始化引擎
                    if ([self initEngine] && _connected)
                    {
                        // TODO
                        [self sendSigninData:_currentUser];
                
                    }
                    else
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [_signinHUD hide:YES];
                            
                            self.signinView.hidden = NO;
                            
                            [TSMessage showNotificationWithTitle:@"网络连接异常"
                                                        subtitle:@"请检查您的服务器信息并确认服务器是否已启动"
                                                            type:TSMessageNotificationTypeError];
                        });
                    }
                });

                
            });
        });

    }
    else
    {
        //用户数据加载失败
        //显示登录界面
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.configServerView.hidden = YES;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[MastEngine sharedSingleton] removeListener:kDemoCelletName listener:_signinListener];
    [[MastEngine sharedSingleton] removeStatusListener:kDemoCelletName statusListener:_statusListener];
}

#pragma mark - Check network

- (void)checkNetwork
{
    if (nil != _hostReach)
    {
        [_hostReach stopNotifier];
        _hostReach = nil;
    }

    // 监测网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    _hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];

    [_hostReach startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *reach = [notification object];
    NSParameterAssert([reach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [reach currentReachabilityStatus];

    if (status == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil message:@"网络未连接" delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alert show];
        return;
    }
    else if (status == ReachableViaWiFi)
    {
        [TSMessage showNotificationWithTitle:@"您当前已通过 Wifi 连接网络"
                                        type:TSMessageNotificationTypeSuccess];
    }
    else if (status == ReachableViaWWAN)
    {
        [TSMessage showNotificationWithTitle:@"您当前已通过 WWAN 连接网络"
                                        type:TSMessageNotificationTypeMessage];
    }
}

#pragma mark - Action

// 设置
- (IBAction)btnConfigAction:(id)sender
{
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         rotationAndPerspectiveTransform.m34 = 1.0 / -600;
                         self.signinView.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                     } completion:^(BOOL finished) {
                         CATransform3D configseverViewTransform = CATransform3DIdentity;
                         configseverViewTransform.m34 = 1.0 / -600;
                         self.configServerView.layer.transform = CATransform3DRotate(configseverViewTransform, 90 * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                         [self.signinView setHidden:YES];
                         [self.configServerView setHidden:NO];
                         [UIView animateWithDuration:0.3
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                                              rotationAndPerspectiveTransform.m34 = 1.0 / -600;
                                              self.configServerView.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 0 * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                                          }
                                          completion:^(BOOL finished) {
                                              self.signinView.layer.transform = CATransform3DIdentity;
                                              self.configServerView.layer.transform = CATransform3DIdentity;
                                          }];
                     }];
  
}

// 登录
- (IBAction)btnSigninAction:(id)sender
{
    [SUser updateLastLogin];
    
    SUser *user = [[SUser alloc]init];
    [user setUserName:_user];
    [user setUserPsw:_password];
    _currentUser = user;
    [SUser insertUser:user];
    
    [[MastEngine sharedSingleton] resetContact];
    
    self.signinView.hidden = YES;
    
    _signinHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _signinHUD.mode = MBProgressHUDModeIndeterminate;
    _signinHUD.labelText = @"正在登录请稍后";
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        
        if ([self initEngine] && _connected)
        {
            [self sendSigninData:_currentUser];
        }else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_signinHUD hide:YES];
                
                self.signinView.hidden = NO;
                
                [TSMessage showNotificationWithTitle:@"网络连接异常"
                                            subtitle:@"请检查您的服务器信息并确认服务器是否已启动"
                                                type:TSMessageNotificationTypeError];
            });
        }
        
    });
    
    //TODO
    //发送网络请求， 监听器监听到登录成功执行登录方法
    
//    [self didSignin];
}

// 测试
- (IBAction)btnCheckConfigAction:(id)sender
{
    // TODO
    if (nil != _address && 0 != [_address length])
    {
        if ([SUser updateSeverIp:_address andPort:_port])
        {
            [SUser insertSeverIp:_address andPort:_port];
        }
        
        [[MastEngine sharedSingleton] removeContact:@"SmartITOM"];
        Contact *contact = [[Contact alloc]initWith:@"SmartITOM" address:_address port:_port];
        [[MastEngine sharedSingleton] addContact:contact];
        [[MastEngine sharedSingleton] resetContact];
        
    }
    
    //测试
    _connectHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _connectHUD.mode = MBProgressHUDModeIndeterminate;
    _connectHUD.labelText = @"正在建立连接...";
    
}

// 确认
- (IBAction)btnConfirmAction:(id)sender
{
    [[MastEngine sharedSingleton] removeContact:@"SmartITOM"];
    Contact *contact = [[Contact alloc] initWith:@"SmartITOM" address:_address port:_port];
    [[MastEngine sharedSingleton] addContact:contact];
    [[MastEngine sharedSingleton] resetContact];
    
    
    [UIView animateWithDuration:0.3
                          delay:0
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                         rotationAndPerspectiveTransform.m34 = 1.0 / -600;
                         self.configServerView.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -90.0f * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                         
                     } completion:^(BOOL finished) {
                         CATransform3D configseverViewTransform = CATransform3DIdentity;
                         configseverViewTransform.m34 = 1.0 / -600;
                         self.signinView.layer.transform = CATransform3DRotate(configseverViewTransform, 90 * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                         [self.configServerView setHidden:YES];
                         [self.signinView setHidden:NO];
                         [UIView animateWithDuration:0.3
                                               delay:0
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
                                              rotationAndPerspectiveTransform.m34 = 1.0 / -600;
                                              self.signinView.layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 0 * M_PI / 180.0f, 0.0f, 1.0f, 0.0f);
                                          }
                                          completion:^(BOOL finished) {
                                              self.configServerView.layer.transform = CATransform3DIdentity;
                                              self.signinView.layer.transform = CATransform3DIdentity;
                                          }];
                     }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (100 == textField.tag)
    {
        _user = self.tfUser.text;
    }
    else if (101 == textField.tag)
    {
        _password = [self md5:textField.text];
    }
    else if (102 == textField.tag)
    {
        _address = self.tfAddress.text;
    }
//    else if (103 == textField.tag)
//    {
        _port = [self.tfPort.text integerValue];
//    }
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (1 == buttonIndex)
    {
        [self btnConfigAction:nil];
    }
}

#pragma mark - Touch Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    // Nothing
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    // 关闭软键盘
    if (![self.view isExclusiveTouch])
    {
        if (![self.tfUser resignFirstResponder])
        {
            [self.tfPassword resignFirstResponder];
        }
        if (![self.tfAddress resignFirstResponder])
        {
            [self.tfPort resignFirstResponder];
        }
    }
}

#pragma mark - SSigninVStatusListenerDelegate

- (void)didConnected:(NSString *)identifier
{
    _connected = TRUE;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_connectHUD hide:YES];
        [TSMessage showNotificationWithTitle:@"connected" type:TSMessageNotificationTypeSuccess];
    });
}

- (void)didFailed:(NSString *)identifier
{
    _connected = FALSE;
    dispatch_async(dispatch_get_main_queue(), ^{
        [_connectHUD hide:YES];
        [TSMessage showNotificationWithTitle:@"disConnected" type:TSMessageNotificationTypeError];
    });

}

#pragma mark - SSigninVListenerDelegate

- (void)didSignin:(NSDictionary *)dic
{
    NSInteger statusCode = [[dic objectForKey:@"status"] integerValue];
    
    NSDictionary *userInfo = [dic objectForKey:@"userInfo"];
    
    NSString *token = [userInfo objectForKey:@"token"];
    
    [SUser updateToken:token];
    
    long long userId = [[userInfo objectForKey:@"userID"] longLongValue];
    
    [SUser updateUserId:userId];
    
    switch (statusCode)
    {
        case 300:
        {
            [SUser updateIsSignin:userId];
            dispatch_async(dispatch_get_main_queue(), ^{
                [_signinHUD hide:YES];
                self.signinView.hidden = NO;
                // 执行登录流程
                [self didSignin];
            });
            
        }
            break;
        case 101:           //  用户不存在
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"身份验证失败" message:@"用户名不存在，请重新设置" delegate:self
                                                 cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            alert.tag = 101;
            [alert show];
        }
            break;
        case 102:            //密码错误！！
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"身份验证失败" message:@"密码错误，请重新设置" delegate:self
                                                 cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            alert.tag = 102;
            [alert show];
        }
            break;
        case 103:            //服务器出现错误，请联系管理员
        {
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"身份验证失败" message:@"服务器出现错误，请联系管理员" delegate:self
                                                 cancelButtonTitle:@"否" otherButtonTitles:@"是", nil];
            alert.tag = 103;
            [alert show];
        }
            break;
            
        default:
            break;
    }
}


#pragma mark - Private

//发送登录网络请求
- (void)sendSigninData:(SUser *)user
{
    //发送网络请求,监听器监听到登录成功执行登录方法
    CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton] createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
    dialect.action = @"login";
    NSDictionary *valueDic = [NSDictionary dictionaryWithObjectsAndKeys:user.userName,@"username",user.userPsw,@"password", nil];
    NSString *value = @"";
    if ([NSJSONSerialization isValidJSONObject:valueDic])
    {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:valueDic options:NSJSONWritingPrettyPrinted error:&error];
        value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    [dialect appendParam:@"data" stringValue:value];
    [[MastEngine sharedSingleton] asynPerformAction:@"SmartITOM" action:dialect];
    

}


// 加载本地用户数据
- (BOOL)loadLocalUserData
{
    //查询数据库
    NSMutableArray *userList = [[NSMutableArray alloc]initWithCapacity:2];
    
    userList = [SUser getAllUserNameList];
    
    SUser *user = nil;
    if (0 != [userList count])
    {
        //有用户,得到最近一次登录且未注销的用户
        //未注销的密码不为空
        user = [SUser getLastUser];
        _currentUser = user;
        
        if (nil == user.userPsw || 0 == user.userPsw.length)
        {
            //注销的用户 密码为空，
            return FALSE;
        }
    }
    else
    {
        //没有用户
        return FALSE;
    }
    
    [self updateCurrentUser:user];
    
    return TRUE;

}

- (void)updateCurrentUser:(SUser *)user
{
    self.tfUser.text = user.userName;
    _user = user.userName;
    self.tfPassword.text = user.userPsw;
    _password = user.userPsw;

}

// 加载本地数据
- (BOOL)loadLocalData
{
    // TODO 将数据库内数据读取到界面
    _address = [SUser getLastSigninIp];
    _port = [SUser getLastSigninPort];

    if (nil == _address || [_address length] == 0)
    {
        return FALSE;
    }
    
    [[MastEngine sharedSingleton] removeContact:@"SmartITOM"];
    Contact *contact = [[Contact alloc]initWith:@"SmartITOM" address:_address port:_port];
    [[MastEngine sharedSingleton] addContact:contact];
    [[MastEngine sharedSingleton] resetContact];

    self.tfAddress.text = _address;
    self.tfPort.text = [NSString stringWithFormat:@"%d", _port];
    return TRUE;
    
}

// 初始化网络引擎
- (BOOL)initEngine
{
    if ([[MastEngine sharedSingleton] hasStarted])
    {
        return TRUE;
    }

    //启动引擎
    if (![[MastEngine sharedSingleton] start])
    {
        return FALSE;
    }
    
    return TRUE;
}

- (void)didSignin
{
    [self performSegueWithIdentifier:@"Signin" sender:self];
}


#pragma mark - Encrypt MD5

- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    
    unsigned char result[16];
    
    CC_MD5(cStr, strlen(cStr), result);
    
    return [NSString stringWithFormat:
            
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            
            result[0], result[1], result[2], result[3],
            
            result[4], result[5], result[6], result[7],
            
            result[8], result[9], result[10], result[11],
            
            result[12], result[13], result[14], result[15]
            
        ];
}

@end
