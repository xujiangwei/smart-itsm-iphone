//
//  SSenderButton.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SSenderButton : UIControl

{
@private;
    UILabel* label;
    UIImageView *imageView;
}
@property(nonatomic,copy) NSString* text;
@property(readonly) UIFont* font;

@property (nonatomic, strong) UIImageView *leftImageV;
@property (nonatomic, strong) UIImageView *centerImageV;
@property (nonatomic, strong) UIImageView *rightImageV;

- (void)markSelected;
- (void)markUnselected;

@end
