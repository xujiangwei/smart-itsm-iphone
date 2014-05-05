//
//  SMessageContentView.h
//  SmartITSM
//
//  Created by Apple Developer on 14-4-29.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SMessage.h"

//@protocol SMsgContentControlDelegate <NSObject>
//
//- (void)contentViewDidClosed;
//
////置顶
//- (void)btnMarkTop:(BOOL)top withId:(NSString *)index;
//
//@end

@interface SMessageContentView : UIView

//摘要视图
@property (strong, nonatomic) IBOutlet UIView *summaryView;

//发件人
@property (strong, nonatomic) IBOutlet UILabel *senderLabel;

//接收时间
@property (strong, nonatomic) IBOutlet UILabel *receiveTimeLabel;

//置顶按钮
@property (strong, nonatomic) IBOutlet UIButton *hasTopButton;

//摘要标签
@property (strong, nonatomic) IBOutlet UILabel *summaryLabel;

//整体图表视图
@property (strong, nonatomic) IBOutlet UIView *scrollView;

//消息内容
@property (strong, nonatomic) IBOutlet UITextView *content;

//图表视图
@property (strong, nonatomic) IBOutlet UIImageView *originalPicView;

@property (strong, nonatomic) NSMutableArray *messageArray;
@property (nonatomic, assign) NSIndexPath *currentIndexPath;
//@property (assign, nonatomic) id <SMsgContentControlDelegate> delegate;
@property (nonatomic,assign)  BOOL hasTop;

//更新内容
- (void)updateMessage:(SMessage *)message;

@end
