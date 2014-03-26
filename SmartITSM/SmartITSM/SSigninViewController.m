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
#import "TSMessage/TSMessage.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "SSigninView.h"
#import "SConfigServerView.h"
#import "Reachability.h"
#import "MastEngine.h"
#import "Contacts.h"


#define kDemoCelletName @"SmartITOM"

@interface SSigninViewController ()
{
    BOOL _signed;

    NSString *_user;
    NSString *_password;

    NSString *_address;
    NSInteger _port;

    Reachability* _hostReach;
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
        _hostReach = nil;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.signinView.hidden = NO;

    // 加载本地数据
    if (![self loadLocalData])
    {
        // 数据加载失败，提示配置
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"您没有设置过服务器信息，\n请先设置服务器信息"
                                                       delegate:self
                                              cancelButtonTitle:@"我知道了"
                                              otherButtonTitles:@"现在配置", nil];
        [alert show];
    }
    else
    {
        // 加载成功
        // 隐藏登录信息界面
        self.signinView.hidden = YES;

        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeIndeterminate;
        hud.labelText = @"正在登录请稍后";

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{

            // 初始化引擎
            if ([self initEngine])
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES];

                    // TODO 执行登录流程
                    [self didSignin];
                });
            }
            else
            {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [hud hide:YES];

                    self.signinView.hidden = NO;

                    [TSMessage showNotificationWithTitle:@"网络连接异常"
                                                subtitle:@"请检查您的服务器信息并确认服务器是否已启动"
                                                    type:TSMessageNotificationTypeError];
                });
            }
        });
    }
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    [self.signinView setAlpha:1.0f];
    [self.configServerView setAlpha:1.0f];

    self.configServerView.hidden = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    // TODO
    [self didSignin];
}

// 测试
- (IBAction)btnCheckConfigAction:(id)sender
{
    // TODO
}

// 确认
- (IBAction)btnConfirmAction:(id)sender
{
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
    else if (103 == textField.tag)
    {
        _port = [self.tfPort.text integerValue];
    }
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

#pragma mark - Private

// 加载本地数据
- (BOOL)loadLocalData
{
    // TODO 将数据库内数据读取到界面
    _address = @"192.168.2.3";
    _port = 7000;

    if (nil == _address || [_address length] == 0)
    {
        return FALSE;
    }

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

    // 服务器
    Contacts *contacts = [[Contacts alloc] init];
    [contacts addAddress:kDemoCelletName host:_address port:_port];

    //启动引擎
    if (![[MastEngine sharedSingleton] start:contacts])
    {
        return FALSE;
    }
    
    return TRUE;
}

- (void)didSignin
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UITabBarController *tabbarViewController = [storyboard instantiateViewControllerWithIdentifier:@"tab"];
//
//    [self presentViewController:tabbarViewController animated:YES completion:^{
//
//    }];
    
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
