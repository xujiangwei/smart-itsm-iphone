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

@interface SSigninViewController : UIViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *subView;

@property (strong, nonatomic) IBOutlet SSigninView *signinView;

@property (strong, nonatomic) IBOutlet SConfigServerView *configServerView;

@property (strong, nonatomic) IBOutlet UIImageView *logoImageV;

@property (strong, nonatomic) IBOutlet UITextField *tfUserName;

@property (strong, nonatomic) IBOutlet UITextField *tfPassWord;

@property (strong, nonatomic) IBOutlet UIButton *settingBtn;

@property (strong, nonatomic) IBOutlet UIButton *signinBtn;

@property (strong, nonatomic) IBOutlet UITextField *textFieldIP;

@property (strong, nonatomic) IBOutlet UITextField *tfPort;

@property (strong, nonatomic) IBOutlet UIButton *connectCheckBtn;

@property (strong, nonatomic) IBOutlet UIButton *confirmBtn;


@end
