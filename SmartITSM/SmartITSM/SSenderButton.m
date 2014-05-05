//
//  SSenderButton.m
//  SmartITSM
//
//  Created by Apple Developer on 14-4-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SSenderButton.h"

#define unselectedColor [UIColor colorWithRed:87.0/255.0f green:87.0/255.0f blue:87.0/255.0f alpha:1.0f]
#define unselectedShadowColor [UIColor colorWithWhite:1.0f alpha:0.7f]
#define selectedColor [UIColor colorWithRed:1.0f green:1.0f blue:1.0f alpha:1.0f]

@implementation SSenderButton
@synthesize leftImageV;
@synthesize centerImageV;
@synthesize rightImageV;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        /*
        Theme *theme = [ThemeManager sharedSingleton].theme;
        
        leftImageV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 5,frame.size.height)];
        [leftImageV setImage:[UIImage imageNamed:theme.tabLeftNormal]];
        [self addSubview:leftImageV];
        
        
        centerImageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, 0,leftImageV.frame.size.width, frame.size.height)];
        centerImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:theme.tabCenterNormal]];
        [self addSubview:centerImageV];
        
        rightImageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:theme.tabRightNormal]];
        [rightImageV setFrame:CGRectMake(frame.size.width - 5, 0, 5, frame.size.height)];
        [self addSubview:rightImageV];
        
		label = [[UILabel alloc] initWithFrame:CGRectMake(-2.0f, -2.0f, frame.size.width, frame.size.height)];
		[label setTextAlignment:NSTextAlignmentCenter];
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		label.backgroundColor = [UIColor clearColor];
        //		label.font = [UIFont boldSystemFontOfSize:18.0f];
		label.textColor = unselectedColor;
        [label setTextColor:[UIColor colorWithRed:0.0f green:0.0f blue:0.0f alpha:1.0f]];
        
		[self addSubview:label];
		
		self.backgroundColor = [UIColor clearColor];
         */
    }
    return self;
}

- (void)setText:(NSString*)text
{
	label.text = text;
}

- (void)markSelected
{
    /*
	label.textColor = selectedColor;
	imageView.hidden = NO;
	self.selected = YES;
    
    Theme * theme = [ThemeManager sharedSingleton].theme;
    [leftImageV setImage:[UIImage imageNamed: theme.tabLeftActive]];
    [centerImageV setImage:[UIImage imageNamed:theme.tabCenterActive]];
    [rightImageV setImage:[UIImage imageNamed:theme.tabRightActive]];
    */
}

- (void)markUnselected
{
    /*
	label.textColor = unselectedColor;
	imageView.hidden = YES;
	self.selected = NO;
    Theme * theme = [ThemeManager sharedSingleton].theme;
    [leftImageV setImage:[UIImage imageNamed: theme.tabLeftNormal]];
    [centerImageV setImage:[UIImage imageNamed:theme.tabCenterNormal]];
    [rightImageV setImage:[UIImage imageNamed:theme.tabRightNormal]];
   */
}

- (NSString*)text
{
	return label.text;
}

- (UIFont*)font
{
	return label.font;
}

@end
