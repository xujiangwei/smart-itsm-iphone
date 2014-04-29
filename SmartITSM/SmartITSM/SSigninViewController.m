//
//  SSigninViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-3-18.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SSigninViewController.h"
#import "MastPrerequisites.h"
#import "MastEngine.h"
#import "SSigninView.h"
#import "SConfigServerView.h"
#import "Contact.h"
#import "SUser.h"

#define kTableViewCellHieght 50


@interface SSigninViewController ()
{
    BOOL _signed;
    BOOL _connected;
    BOOL _btnUserHistoryPressed;
    BOOL _btnIpHistoryPressed;
    BOOL _btnPortHistoryPressed;
    
    UITableView *_userTableView;
    UITableView *_ipTableView;
    UITableView *_portTableView;
    
    NSMutableArray *_userList;
    NSMutableArray *_ipList;
    NSMutableArray *_portList;

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
        _btnUserHistoryPressed = FALSE;
        _btnIpHistoryPressed = FALSE;
        _btnPortHistoryPressed = FALSE;
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
    
    [[MastEngine sharedSingleton] addActionListener:kDemoCelletName listener:_signinListener];
    [[MastEngine sharedSingleton] addStatusListener:kDemoCelletName statusListener:_statusListener];
    
    // 下拉列表userName
    _userTableView = [[UITableView alloc] initWithFrame:CGRectMake(100, 58, 175, 0)];
    _userTableView.dataSource = self;
    _userTableView.delegate = self;
    _userTableView.tag = 100;
    _userTableView.hidden = TRUE;
    _userTableView.layer.cornerRadius = 6.0f;
    _userTableView.layer.borderWidth = 1.0f;
    _userTableView.layer.borderColor = [UIColor colorWithRed:192.0f / 255.0f green:126.0f / 255.0f blue:39.0f / 255.0f alpha:1.0f].CGColor;
    [self.signinView addSubview:_userTableView];
    
    // 下拉列表ip
    _ipTableView = [[UITableView alloc] initWithFrame:CGRectMake(75, 58, 200, 0)];
    _ipTableView.dataSource = self;
    _ipTableView.delegate = self;
    _ipTableView.tag = 200;
    _ipTableView.hidden = TRUE;
    _ipTableView.layer.cornerRadius = 6.0f;
    _ipTableView.layer.borderWidth = 1.0f;
    _ipTableView.layer.borderColor = [UIColor colorWithRed:192.0f / 255.0f green:126.0f / 255.0f blue:39.0f / 255.0f alpha:1.0f].CGColor;
    [self.configServerView addSubview:_ipTableView];
    
    // 下拉列表port
    _portTableView = [[UITableView alloc] initWithFrame:CGRectMake(75, 108, 200, 0)];
    _portTableView.dataSource = self;
    _portTableView.delegate = self;
    _portTableView.tag = 300;
    _portTableView.hidden = TRUE;
    _portTableView.layer.cornerRadius = 6.0f;
    _portTableView.layer.borderWidth = 1.0f;
    _portTableView.layer.borderColor = [UIColor colorWithRed:192.0f / 255.0f green:126.0f / 255.0f blue:39.0f / 255.0f alpha:1.0f].CGColor;
    [self.configServerView addSubview:_portTableView];

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
        if (0 == _userList.count)
        {
            [self.btnUserHistory setHidden:YES];
        }
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
    
    [[MastEngine sharedSingleton] removeActionListener:kDemoCelletName listener:_signinListener];
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
    if (0 == _ipList.count)
    {
        [self.btnIpHistory setHidden:YES];
    }

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
    if (nil == _address || [_address length] == 0)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"您没有设置过服务器信息，\n请先设置服务器信息"
                                                       delegate:self
                                              cancelButtonTitle:@"我知道了"
                                              otherButtonTitles:@"现在设置", nil];
        [alert show];
    }
    else
    {
        Contact *contact = [[Contact alloc]initWith:@"SmartITOM" address:_address port:_port];
        [[MastEngine sharedSingleton] contactCellet:contact reconnection:NO];

        [SUser updateLastLogin];
        
        SUser *user = [[SUser alloc]init];
        [user setUserName:_user];
        [user setUserPsw:_password];
        _currentUser = user;
        [SUser insertUser:user];
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
    }

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

        Contact *contact = [[Contact alloc]initWith:@"SmartITOM" address:_address port:_port];
        [[MastEngine sharedSingleton] contactCellet:contact reconnection:NO];

        //测试
        _connectHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        _connectHUD.mode = MBProgressHUDModeIndeterminate;
        _connectHUD.labelText = @"正在建立连接...";
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil
                                                        message:@"您没有设置过服务器信息，\n请先设置服务器信息"
                                                       delegate:self
                                              cancelButtonTitle:@"我知道了"
                                              otherButtonTitles:@"现在设置", nil];
        [alert show];
    }
}

// 确认
- (IBAction)btnConfirmAction:(id)sender
{

    Contact *contact = [[Contact alloc]initWith:@"SmartITOM" address:_address port:_port];
    [[MastEngine sharedSingleton] contactCellet:contact reconnection:NO];

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

- (IBAction)btnUserHistoryAction:(id)sender
{
    _btnUserHistoryPressed = !_btnUserHistoryPressed;
   
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
    
    if (nil != _userTableView)
    {
        [UIView animateWithDuration:0.4
                         animations:^{
                            [self refreshButton:self.btnUserHistory withPressed:_btnUserHistoryPressed];
                             if (_userTableView.hidden)
                             {
                                 _userTableView.frame = CGRectMake(100, 58, 175, 50);
                             }
                             else
                             {
                                 _userTableView.frame = CGRectMake(100, 58, 175, 0);
                             }
                         } completion:^(BOOL finished) {
                             _userTableView.hidden = !_userTableView.hidden;
                         }];
    }

}

- (IBAction)btnIpHistoryAction:(id)sender
{
    _btnIpHistoryPressed = !_btnIpHistoryPressed;
    
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
    
    if (nil != _ipTableView)
    {
        [UIView animateWithDuration:0.4
                         animations:^{
                            [self refreshButton:self.btnIpHistory withPressed:_btnIpHistoryPressed];
                             if (_ipTableView.hidden)
                             {
                                 _ipTableView.frame = CGRectMake(75, 58, 200, 50);
                             }
                             else
                             {
                                 _ipTableView.frame = CGRectMake(75, 58, 200, 0);
                             }
                         }
                         completion:^(BOOL finished) {
                             _ipTableView.hidden = !_ipTableView.hidden;
                         }];
    }

}

- (IBAction)btnPortHistoryAction:(id)sender
{
    _btnPortHistoryPressed = !_btnPortHistoryPressed;
    
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
    
    if (nil != _portTableView)
    {
        [UIView animateWithDuration:0.4
                         animations:^{
                             [self refreshButton:self.btnPortHistory withPressed:_btnPortHistoryPressed];
                             if (_portTableView.hidden)
                             {
                                 _portTableView.frame = CGRectMake(75, 108, 200, 150);
                             }
                             else
                             {
                                 _portTableView.frame = CGRectMake(75, 108, 200, 0);
                             }
                         }
                         completion:^(BOOL finished) {
                             _portTableView.hidden = !_portTableView.hidden;
                         }];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger count;
    
    if (100 == tableView.tag)
    {
        count = [_userList count];
    }
    else if(200 == tableView.tag)
    {
        count = [_ipList count];
    }
    else {
        count = [_portList count];
    }
    
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        UITableViewCell *myCell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        myCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        if (100 == tableView.tag)
        {
            myCell.textLabel.text = [_userList objectAtIndex:indexPath.row];
        }
        else if(200 == tableView.tag)
        {
            myCell.textLabel.text = [_ipList objectAtIndex:indexPath.row];
        }
        else if (300 == tableView.tag)
        {
            myCell.textLabel.text = [NSString stringWithFormat:@"%d",[[_portList objectAtIndex:indexPath.row] intValue] ];
        }
        cell = myCell;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	return 42;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (100 == tableView.tag)
    {
        //userTableView
        NSString *str = [_userList objectAtIndex:indexPath.row];
        
        SUser *user = [SUser getUserWithUserName:str];
        
        [self updateCurrentUser:user];
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             _userTableView.frame = CGRectMake(100, 58, 175, 0);
                         } completion:^(BOOL finished) {
                             _userTableView.hidden = TRUE;
                             
                             _btnUserHistoryPressed = !_btnUserHistoryPressed;
                             
                             [self refreshButton:self.btnUserHistory withPressed:_btnUserHistoryPressed];
                         }];
        
    }
    else if(200 == tableView.tag)
    {
        //ipTableView
        NSString *str = [_ipList objectAtIndex:indexPath.row];
        
        [self.tfAddress setText:str];
        
        _address = str;
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             _ipTableView.frame = CGRectMake(75, 58, 200, 0);
                         } completion:^(BOOL finished) {
                             
                             _ipTableView.hidden = TRUE;
                             
                             _btnIpHistoryPressed = !_btnIpHistoryPressed;
                             
                             [self refreshButton:self.btnIpHistory withPressed:_btnIpHistoryPressed];
                         }];
    }
    else if (300 == tableView.tag)
    {
        //portTableView
        NSInteger tmpPort = [[_portList objectAtIndex:indexPath.row] intValue];
        
        [self.tfPort setText:[NSString stringWithFormat:@"%d",tmpPort]];
        
        _port = tmpPort;
        
        [UIView animateWithDuration:0.4
                         animations:^{
                             _portTableView.frame = CGRectMake(75, 108, 200, 0);
                         }
                         completion:^(BOOL finished){
                             
                             _portTableView.hidden = TRUE;
                             
                             _btnPortHistoryPressed = !_btnPortHistoryPressed;
                             
                             [self refreshButton:self.btnPortHistory withPressed:_btnPortHistoryPressed];
                         }];
    }
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

        _port = [self.tfPort.text integerValue];

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
        
        if (!_userTableView.hidden)
        {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _userTableView.frame = CGRectMake(100, 58, 175, 0);
                             } completion:^(BOOL finished) {
                                 
                                 _userTableView.hidden = TRUE;
                                 
                                 _btnUserHistoryPressed = !_btnUserHistoryPressed;
                                 
                                 [self refreshButton:self.btnUserHistory withPressed:_btnUserHistoryPressed];
                             }];
        }
        
        if (!_ipTableView.hidden)
        {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _ipTableView.frame = CGRectMake(75, 58, 200, 0);
                             } completion:^(BOOL finished) {
                                 
                                 _ipTableView.hidden = TRUE;
                                 
                                 _btnIpHistoryPressed = !_btnIpHistoryPressed;
                                 
                                 [self refreshButton:self.btnIpHistory withPressed:_btnIpHistoryPressed];
                             }];
        }
        
        if (!_portTableView.hidden)
        {
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _portTableView.frame = CGRectMake(75, 108, 200, 0);
                             }
                             completion:^(BOOL finished){
                                 
                                 _portTableView.hidden = TRUE;
                                 
                                 _btnPortHistoryPressed = !_btnPortHistoryPressed;
                                 
                                 [self refreshButton:self.btnPortHistory withPressed:_btnPortHistoryPressed];
                             }];
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
            case 0:
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [_signinHUD hide:YES];
                self.signinView.hidden = NO;
               
                [TSMessage showNotificationWithTitle:@"登录错误" subtitle:@"无效的用户名或密码，请重试" type:TSMessageNotificationTypeError];
            });
        }
            break;
        default:
            break;
    }
}


#pragma mark - Private

- (NSMutableArray *)getAllIpList
{
    NSMutableArray *list = [[NSMutableArray alloc]initWithCapacity:10];
    
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    
    NSString * sql = [NSString stringWithFormat:@"SELECT DISTINCT ip FROM tb_ip_port ORDER BY ip_priority"];
    
    rs = [db executeQuery:sql];
    
    while ( [rs next])
    {
        NSString *tmp = [rs stringForColumnIndex:0];
        
        [list addObject:tmp];
    }
    return list;
}

- (NSMutableArray *)getAllPortList
{
    NSMutableArray *list = [[NSMutableArray alloc]initWithCapacity:10];
    
    SDatabase *db = [SDatabase sharedSingleton];
    
    FMResultSet *rs;
    
    NSString * sql = [NSString stringWithFormat:@"SELECT DISTINCT port FROM tb_ip_port ORDER BY port_priority"];
    
    rs = [db executeQuery:sql];
    
    while ( [rs next])
    {
        NSInteger tmp = [rs intForColumnIndex:0];
        
        [list addObject:[NSNumber numberWithInteger:tmp]];
    }
    return list;
}

- (void)refreshButton:(UIButton *)button withPressed:(BOOL)pressed
{
    UIImageView *buttonImageView = [button valueForKey:@"imageView"];
    buttonImageView.userInteractionEnabled = NO;
    
    CGAffineTransform transform = pressed ? CGAffineTransformMakeRotation(M_PI) : CGAffineTransformMakeRotation(0);
    
    buttonImageView.transform = transform;
}

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
    _userList = [SUser getAllUserNameList];
    
    SUser *user = nil;
    if (0 != [_userList count])
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
    _currentUser = user;
    self.tfUser.text = user.userName;
    _user = user.userName;
    self.tfPassword.text = @"*******";
    _password = user.userPsw;

}

// 加载本地数据
- (BOOL)loadLocalData
{
    // TODO 将数据库内数据读取到界面
    //查询tb_ip_port
    _ipList = [self getAllIpList];
    _portList = [self getAllPortList];
    _address = [SUser getLastSigninIp];
    _port = [SUser getLastSigninPort];
    
    if (nil == _address || [_address length] == 0)
    {
        return FALSE;
    }

    Contact *contact = [[Contact alloc]initWith:@"SmartITOM" address:_address port:_port];
    [[MastEngine sharedSingleton] contactCellet:contact reconnection:NO];

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
