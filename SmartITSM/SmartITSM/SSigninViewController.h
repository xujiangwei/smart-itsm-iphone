//
//  SSigninViewController.h
//  SmartITSM
//
//  Created by 朱国强 on 14-3-18.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SSigninView;

@class SConfigServerView;

@interface SSigninViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *subView;

@property (strong, nonatomic) IBOutlet SSigninView *signinView;

@property (strong, nonatomic) IBOutlet SConfigServerView *configServerView;

@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;

@property (strong, nonatomic) IBOutlet UITextField *tfUser;

@property (strong, nonatomic) IBOutlet UITextField *tfPassword;

@property (strong, nonatomic) IBOutlet UIButton *btnConfig;

@property (strong, nonatomic) IBOutlet UIButton *btnSignin;

@property (strong, nonatomic) IBOutlet UITextField *tfAddress;

@property (strong, nonatomic) IBOutlet UITextField *tfPort;

@property (strong, nonatomic) IBOutlet UIButton *btnCheckConfig;

@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;


@end
