//
//  SLogViewController.h
//  SmartITSM
//
//  Created by dweng on 14-3-26.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//




#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "PlanLine.h"
@interface SLogViewController : UIViewController<MakeLine,UIScrollViewDelegate>

@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIButton *monthButton;
@property (strong, nonatomic) UIView *massageView;

@property (strong, nonatomic) UILabel *label;
@property (strong, nonatomic) UILabel *monthlabel;

//动态array
@property (strong, nonatomic) NSMutableArray *massageViewArray;
@property (strong, nonatomic) NSMutableArray *buttonArray;
@property (strong, nonatomic) NSMutableArray *monthLabelArray;

@property int tag;

@property (strong, nonatomic) UIImageView *AddimageView;
@property (strong, nonatomic) NSMutableArray *arrayMonths;
@property int token;

@end
