//
//  PlanLine.h
//  SmartITSM
//
//  Created by dweng on 14-03-26.
//  Copyright (c) 2013年 Ambrose. All rights reserved.

#import <Foundation/Foundation.h>

@protocol MakeLine <NSObject>
@optional

-(void)setImageView:(UIImageView *)imageview setlineWidth:(float)lineWidth setColorRed:(float)colorR ColorBlue:(float)colorB ColorGreen:(float)colorG Alp:(float)alp setBeginPointX:(int)x BeginPointY:(int)y setOverPointX:(int)ox OverPointY:(int)oy;
@end


@interface PlanLine : NSObject<MakeLine>

@property (assign, nonatomic)id<MakeLine> delegate;

-(void)setImageView:(UIImageView *)imageview setlineWidth:(float)lineWidth setColorRed:(float)colorR ColorBlue:(float)colorB ColorGreen:(float)colorG Alp:(float)alp setBeginPointX:(int)x BeginPointY:(int)y setOverPointX:(int)ox OverPointY:(int)oy;
@end
