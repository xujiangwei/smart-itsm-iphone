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
#import "SSigninView.h"
#import "SConfigServerView.h"
#import "Reachability.h"
#import "TSMessage/TSMessage.h"

@interface SSigninViewController ()
{
    BOOL _signed;
    
    NSString *_user;
    NSString *_password;
    
    NSString *_address;
    NSString *_port;

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

    [self.signinView setAlpha:1.0f];

    
    [self checkNetwork:@"www.baidu.com"];

	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Check network

- (void)checkNetwork:(NSString *)host
{
    if (nil != _hostReach)
    {
        [_hostReach stopNotifier];
        _hostReach = nil;
    }

    // 监测网络
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];

    _hostReach = [Reachability reachabilityWithHostName:host];

    [_hostReach startNotifier];
}

- (void)reachabilityChanged:(NSNotification *)notification
{
    Reachability *reach = [notification object];
    NSParameterAssert([reach isKindOfClass:[Reachability class]]);
    NetworkStatus status = [reach currentReachabilityStatus];

    if (status == NotReachable)
    {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"网络未连接" delegate:nil cancelButtonTitle:@"是" otherButtonTitles:nil, nil];
        [alert show];
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

/*

Contacts *contacts = [[Contacts alloc]init];
[contacts addAddress:@"SmartITOM" host:@"192.168.0.109" port:7000];

//启动引擎
if (![[MastEngine sharedSingleton] start:contacts])
{
    NSLog(@"Failed start the host");
}
 
 
 */

#pragma mark - Action

// 设置
- (IBAction)settingBtnAction:(id)sender
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
                         [self.signinView setAlpha:0.0f];
//                         [self.signinView removeFromSuperview];
                         
                         [self.configServerView setAlpha:1.0f];
//                         [self.subView addSubview:self.configServerView];
                         
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
- (IBAction)signinBtnAction:(id)sender
{
    // TODO
    [self didSignin];
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

// 测试
- (IBAction)connectCheckBtnAction:(id)sender
{
    // TODO
}

// 确认
- (IBAction)confirmBtnAction:(id)sender
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
                         [self.configServerView setAlpha:0.0f];
//                         [self.configServerView removeFromSuperview];
                         [self.signinView setAlpha:1.0f];
//                         [self.subView addSubview:self.signinView];
                         
                         
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
        _port = self.tfPort.text;
    }
}

#pragma  mark - Touch Method

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
