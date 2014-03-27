//
//  SLogViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-26.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SLogViewController.h"
#import "PlanLine.h"
#import <QuartzCore/QuartzCore.h>

@interface SLogViewController ()

@end

@implementation SLogViewController
@synthesize imageView;
@synthesize scrollView;
@synthesize monthButton;
@synthesize massageView;
@synthesize massageViewArray;
@synthesize label;
@synthesize buttonArray;
@synthesize monthlabel;
@synthesize monthLabelArray;
@synthesize tag;

@synthesize AddimageView;

@synthesize arrayMonths;
@synthesize token;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.title = @"历史日志";
        
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //    [self.navigationController setToolbarHidden:NO];
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    self.navigationController.toolbar.tintColor = [UIColor blackColor];
    
    tag = 0;
    
    NSArray *timeArray = [NSArray arrayWithObjects:@"3.26",@"3.24",@"3.21",@"3.14",@"3.10",@"3.9",@"3.8",@"3.7",@"3.6",@"2.26",@"2.19",@"2.14", nil];
    
    
    int number = [timeArray count];
    
    [self makeScrollView:number];
    
    
    self.imageView = [[UIImageView alloc]init];
    imageView.frame = CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.contentSize.height);
    [scrollView addSubview:imageView];
    self.view.backgroundColor = [UIColor whiteColor];
    
    PlanLine *plan = [[PlanLine alloc]init];
    
    plan.delegate = self;
    
    [plan setImageView:imageView setlineWidth:5.0 setColorRed:0 ColorBlue:1 ColorGreen:0 Alp:1 setBeginPointX:60 BeginPointY:0 setOverPointX:60 OverPointY:scrollView.contentSize.height];
    
    [self makeMonthButton:number];
    [self makeView:number];
}

-(void)makeScrollView:(int)number
{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
    scrollView.delegate = self;
    scrollView.backgroundColor = [UIColor clearColor];
    scrollView.contentSize = CGSizeMake(self.view.bounds.size.width, number*50+50);
    [self.view addSubview:scrollView];
}

-(void)makeMonthButton:(int)number
{
    self.monthLabelArray = [[NSMutableArray alloc]initWithCapacity:10];
    self.buttonArray = [[NSMutableArray alloc]initWithCapacity:10];
    for (int i = 0; i < number; i++)
    {
        self.monthButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"button.png"];
        [monthButton setImage:image forState:UIControlStateNormal];
        monthButton.frame = CGRectMake(46, i*50, 30, 30);
        monthButton.tag = i;
        //        [monthButton addTarget:self action:@selector(openMassage:) forControlEvents:UIControlEventTouchUpInside];
        [scrollView addSubview:monthButton];
        [buttonArray addObject:monthButton];
        
        self.monthlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, i*50, 40, 30)];
        monthlabel.text = [arrayMonths objectAtIndex:i];
        monthlabel.font = [UIFont systemFontOfSize:10];
        monthlabel.textAlignment = 1;
        monthlabel.backgroundColor = [UIColor clearColor];
        [scrollView addSubview:monthlabel];
        [monthLabelArray addObject:monthlabel];
        
    }
    
}

-(void)makeView:(int)number
{
    self.massageViewArray = [[NSMutableArray alloc]initWithCapacity:10];
    
    for (int i = 0; i < number; i++)
    {
        self.massageView = [[UIView alloc]initWithFrame:CGRectMake(80, i*50, 230, 30)];
        
        massageView.backgroundColor = [UIColor clearColor];
        self.label = [[UILabel alloc]initWithFrame:CGRectMake(140, 0, 60, 30)];
        label.textAlignment= 1;
        NSString *str = @"admin";
        [label setText:str];
        label.font = [UIFont systemFontOfSize:14];
        label.textColor=[UIColor blueColor];
        label.backgroundColor = [UIColor clearColor];
        [massageView addSubview:label];
        [scrollView addSubview:massageView];
        
        UILabel *commentsLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 30, 320, 30)];
        commentsLabel.textAlignment= NSTextAlignmentRight;
        
        [commentsLabel setText:@"审批日志测试审批日志测试"];
        commentsLabel.font = [UIFont systemFontOfSize:12];
        commentsLabel.textColor=[UIColor grayColor];
        commentsLabel.textAlignment=NSTextAlignmentLeft;
        commentsLabel.backgroundColor = [UIColor clearColor];
        [massageView addSubview:commentsLabel];
        [scrollView addSubview:massageView];
        
        
        [massageViewArray addObject:massageView];
        [massageView setUserInteractionEnabled:NO];
    }
}


-(void)openMassage:(id)sender
{
    
    UIButton *button = (UIButton *)sender;
    //移除功能
    if (token!=0)
    {
        
        [AddimageView removeFromSuperview];
    }
    token++;
    
    //时间段线段
    tag = button.tag;
    
    PlanLine *plan = [[PlanLine alloc]init];
    self.AddimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, scrollView.bounds.size.width, scrollView.contentSize.height)];
    
    [plan setImageView:AddimageView setlineWidth:5.0 setColorRed:255 ColorBlue:0 ColorGreen:0 Alp:1 setBeginPointX:60 BeginPointY:button.tag*50+30 setOverPointX:60 OverPointY:(button.tag + 1 )*50+200];
    
    [AddimageView setUserInteractionEnabled:NO];
    
    
    [scrollView addSubview:AddimageView];
    
    //实例化弹出界面
    
    [[massageViewArray objectAtIndex:button.tag] setFrame:CGRectMake(80, button.tag*50, 200, 200)];
    [[massageViewArray objectAtIndex:button.tag] setUserInteractionEnabled:YES];
    UIView *view = [massageViewArray objectAtIndex:button.tag];
    view.backgroundColor = [UIColor lightGrayColor];
    
    [[buttonArray objectAtIndex:button.tag] setFrame:CGRectMake(46, button.tag*50, 30, 30)];
    
    [[monthLabelArray objectAtIndex:button.tag] setFrame:CGRectMake(5, button.tag*50, 40, 30)];
    
    
    
    //位置调整 分上下 注意！！！！
    //点击处上面的
    if (button.tag == 0)
    {
        NSLog(@"asdasd");
    }
    else
    {
        for (int i = 0; i < button.tag; i++)
        {
            [[massageViewArray objectAtIndex:i] setFrame:CGRectMake(80, 0+i*50, 200, 30)];
            [[massageViewArray objectAtIndex:i] setBackgroundColor:[UIColor clearColor]];
            [[massageViewArray objectAtIndex:i] setUserInteractionEnabled:NO];
            
            
            [[buttonArray objectAtIndex:i] setFrame:CGRectMake(46, 0+i*50, 30, 30)];
            
            [[monthLabelArray objectAtIndex:i] setFrame:CGRectMake(5, 0+i*50, 40, 30)];
            
        }
        
        [[massageViewArray objectAtIndex:button.tag-1] setFrame:CGRectMake(80, (button.tag-1)*50, 200, 30)];
        [[buttonArray objectAtIndex:button.tag-1] setFrame:CGRectMake(46, (button.tag-1)*50, 30, 30)];
        [[monthLabelArray objectAtIndex:button.tag-1] setFrame:CGRectMake(5, (button.tag-1)*50, 40, 30)];
        
    }
    //点击处下面的
    for (int i = button.tag + 1; i < [massageViewArray count]; i++)
    {
        [[massageViewArray objectAtIndex:i] setFrame:CGRectMake(80, 200+i*50, 200, 30)];
        [[massageViewArray objectAtIndex:i] setBackgroundColor:[UIColor clearColor]];
        [[massageViewArray objectAtIndex:i] setUserInteractionEnabled:NO];
        UIView *view = [massageViewArray objectAtIndex:i];
        CABasicAnimation *positionAnim=[CABasicAnimation animationWithKeyPath:@"position"];
        [positionAnim setFromValue:[NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y-200)]];
        [positionAnim setToValue:[NSValue valueWithCGPoint:CGPointMake(view.center.x, view.center.y)]];
        [positionAnim setDelegate:self];
        [positionAnim setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [positionAnim setDuration:0.5f];
        [view.layer addAnimation:positionAnim forKey:@"positon"];
        [view setCenter:CGPointMake(view.center.x, view.center.y)];
        [[buttonArray objectAtIndex:i] setFrame:CGRectMake(46, 200+i*50, 30, 30)];
        
        UIButton *button = [buttonArray objectAtIndex:i];
        CABasicAnimation *positionAnim1=[CABasicAnimation animationWithKeyPath:@"position"];
        [positionAnim1 setFromValue:[NSValue valueWithCGPoint:CGPointMake(button.center.x, button.center.y-200)]];
        [positionAnim1 setToValue:[NSValue valueWithCGPoint:CGPointMake(button.center.x, button.center.y)]];
        [positionAnim1 setDelegate:self];
        [positionAnim1 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [positionAnim1 setDuration:0.5f];
        [button.layer addAnimation:positionAnim1 forKey:nil];
        [button setCenter:CGPointMake(button.center.x, button.center.y)];
        
        [[monthLabelArray objectAtIndex:i] setFrame:CGRectMake(5, 200+i*50, 40, 30)];
        
        UILabel *label1 = [monthLabelArray objectAtIndex:i];
        CABasicAnimation *positionAnim2=[CABasicAnimation animationWithKeyPath:@"position"];
        [positionAnim2 setFromValue:[NSValue valueWithCGPoint:CGPointMake(label1.center.x, label1.center.y-200)]];
        [positionAnim2 setToValue:[NSValue valueWithCGPoint:CGPointMake(label1.center.x, label1.center.y)]];
        [positionAnim2 setDelegate:self];
        [positionAnim2 setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [positionAnim2 setDuration:0.5f];
        [label1.layer addAnimation:positionAnim2 forKey:@"positon"];
        [label1 setCenter:CGPointMake(label1.center.x, label1.center.y)];
        
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end