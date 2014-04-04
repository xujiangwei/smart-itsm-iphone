//
//  SProblemProcessViewController.m
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SProblemProcessViewController.h"
#import "RETableViewOptionsController.h"

@interface SProblemProcessViewController ()

@property (strong, readwrite, nonatomic) RETableViewManager *manager;

@property (strong, readwrite, nonatomic) RETableViewSection *basicSection;

@property (strong, readwrite, nonatomic) RETableViewSection *assignSection;   //服务台验证确认并分派--负责人，小组成员，工作日志
@property (strong, readwrite, nonatomic) RETableViewSection *rejectSection;   //服务台拒绝--拒绝理由、关闭代码
@property (strong, readwrite, nonatomic) RETableViewSection *acceptSection;   // 支持人员受理--工作日志
@property (strong, readwrite, nonatomic) RETableViewSection *returnSection;   //支持人员退回--退回理由
@property (strong, readwrite, nonatomic) RETableViewSection *processSection;  //支持人员处理--调查诊断、根本原因、原因分类、解决方案
@property (strong, readwrite, nonatomic) RETableViewSection *solveSection;    //支持人员解决  --工作日志
@property (strong, readwrite, nonatomic) RETableViewSection *closeSection;    //服务台关闭 --关闭代码、是否重大问题、是否解决，备注
@property (strong, readwrite, nonatomic) RETableViewSection *reviewSection;  //重大事故评审

@property (strong, readwrite, nonatomic) RETableViewSection *buttonSection;


@property (strong, readwrite, nonatomic) RELongTextItem *descriptionItem;    //症状及描述
@property (strong, readwrite, nonatomic) RERadioItem  *categoryItem;         //问题类别
@property (strong, readwrite, nonatomic) RERadioItem *urgentItem;            //紧急程度
@property (strong, readwrite, nonatomic) RERadioItem *impactItem;            //影响程度


@property (strong, readwrite, nonatomic) RERadioItem  *directorItem;     //责任人
@property (strong, readwrite, nonatomic) RERadioItem  *memberItem;       //小组成员

//@property (strong, readwrite, nonatomic) RELongTextItem *investDiagnItem;       //调查诊断
@property (strong, readwrite, nonatomic) RELongTextItem *reasonItem;            //原因
@property (strong, readwrite, nonatomic) RERadioItem   *reasonCategoryItem;    //原因类型
@property (strong, readwrite, nonatomic) RELongTextItem *resolutionItem;            //原因

@property (strong, readwrite, nonatomic) RERadioItem   *closeCodeItem;    //关闭代码
@property (strong, readwrite, nonatomic) REBoolItem   *isMajorItem;    //是否重大问题
@property (strong, readwrite, nonatomic) REBoolItem   *isSoluationItem;    //是否有效

@property (strong, readwrite, nonatomic) RELongTextItem *commentItem;       //备注


@end

@implementation SProblemProcessViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"问题解决";
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.basicSection = [self addBasicSection];
    //    self.acceptSection=[self addAcceptSection];
    self.solveSection=[self addSolveSection];
    self.buttonSection = [self addButton];

}

- (RETableViewSection *)addBasicSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *basicSection = [RETableViewSection sectionWithHeaderTitle:@"基本信息"];
    
    [self.manager addSection:basicSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.descriptionItem = [RELongTextItem itemWithTitle:@"症状及描述" value:self.problem.description  placeholder:nil];
    self.descriptionItem.cellHeight=88;
    
    
    self.categoryItem = [RERadioItem itemWithTitle:@"类型" value:self.problem.category selectionHandler:^(RERadioItem *item) {
        }];
    
    self.urgentItem = [RERadioItem itemWithTitle:@"紧急程度" value:self.problem.urgent selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:nil multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = basicSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    self.impactItem = [RERadioItem itemWithTitle:@"影响程度" value:self.problem.impact  selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:nil multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            //            [StackControllerHelper leaveSwap];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = basicSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    
    [basicSection addItem:self.descriptionItem];
    [basicSection addItem:self.categoryItem];
    [basicSection addItem:self.urgentItem];
    [basicSection addItem:self.impactItem];
    
    [basicSection.tableViewManager.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return basicSection;
}


//***********故障工单处理***************

//服务台分派
- (RETableViewSection *)addAssignSection
{
    __typeof (&*self) __weak weakSelf = self;
    RETableViewSection *assignSection = [RETableViewSection sectionWithHeaderTitle:@"问题分派"];
    [self.manager addSection:assignSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.directorItem = [RERadioItem itemWithTitle:@"负责人" value:nil selectionHandler:^(RERadioItem *item) {
        
        [item deselectRowAnimated:YES];
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:nil multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = assignSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.memberItem = [RERadioItem itemWithTitle:@"小组成员" value:nil selectionHandler:^(RERadioItem *item) {
        
        [item deselectRowAnimated:YES];
               RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:nil multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = assignSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    
    self.commentItem = [RELongTextItem itemWithTitle:@"备注" value:nil placeholder:@"请填写备注信息"];
    self.commentItem.cellHeight=132;
    
    [assignSection addItem:self.directorItem];
    [assignSection addItem:self.memberItem];
    [assignSection addItem:self.commentItem];
    
    return assignSection;
}


//服务台拒绝
- (RETableViewSection *)addRejectSection
{
    __typeof (&*self) __weak weakSelf = self;
    RETableViewSection *rejectSection = [RETableViewSection sectionWithHeaderTitle:@"拒绝"];
    [self.manager addSection:rejectSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.closeCodeItem = [RERadioItem itemWithTitle:@"关闭代码" value:nil selectionHandler:^(RERadioItem *item) {
        
        [item deselectRowAnimated:YES];
//       NSArray *users =closeCodeDic.allKeys;
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:nil multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        optionsController.delegate = weakSelf;
        optionsController.style = rejectSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    
    self.commentItem=[RELongTextItem itemWithTitle:@"拒绝理由" value:nil placeholder:nil];

    self.commentItem.cellHeight=132;
    
    
    [rejectSection addItem:self.commentItem];
    [rejectSection addItem:self.closeCodeItem];
    
    return rejectSection;
}

// 支持人员验证并受理
- (RETableViewSection *)addAcceptSection
{
    RETableViewSection *acceptSection = [RETableViewSection sectionWithHeaderTitle:@"受理"];
    [self.manager addSection:acceptSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem = [RELongTextItem itemWithTitle:@"工作日志" value:nil placeholder:nil];

    self.commentItem.cellHeight=132;
    
    [acceptSection addItem:self.commentItem];
    
    return acceptSection;
}



//支持人员处理
- (RETableViewSection *)addProcessSection
{
    RETableViewSection *processSection = [RETableViewSection sectionWithHeaderTitle:@"支持人员处理"];
    [self.manager addSection:processSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem = [RELongTextItem itemWithTitle:@"调查诊断" value:nil placeholder:nil];
    self.reasonItem=[RELongTextItem itemWithTitle:@"根本原因" value:nil placeholder:nil];
    self.reasonCategoryItem = [RERadioItem itemWithTitle:@"原因类型" value:self.problem.category selectionHandler:^(RERadioItem *item) {
       
    }];
    
    
    self.resolutionItem = [RELongTextItem itemWithTitle:@"解决方案" value:nil placeholder:nil];
  
    
    self.resolutionItem.cellHeight=132;
    
    [processSection addItem:self.commentItem];
    [processSection addItem:self.reasonItem];
    [processSection addItem:self.reasonCategoryItem];
    [processSection addItem:self.resolutionItem];
    
    return processSection;
}




//支持人员解决
- (RETableViewSection *)addSolveSection
{
    RETableViewSection *solveSection = [RETableViewSection sectionWithHeaderTitle:@"解决"];
    [self.manager addSection:solveSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem = [RELongTextItem itemWithTitle:@"工作日志" value:nil placeholder:nil];
    self.commentItem.cellHeight=132;
    [solveSection addItem:self.commentItem];
    return solveSection;
}

//支持人员退回
- (RETableViewSection *)addReturnSection
{
    RETableViewSection *returnSection = [RETableViewSection sectionWithHeaderTitle:@"支持人员退回"];
    [self.manager addSection:returnSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem=[RELongTextItem itemWithTitle:@"退回原因" value:nil placeholder:nil];
    self.commentItem.cellHeight=132;
    
    [returnSection addItem:self.commentItem];
    
    return returnSection;
}

//关闭
- (RETableViewSection *)addCloseSection
{
    __typeof (&*self) __weak weakSelf = self;
    RETableViewSection *closeSection = [RETableViewSection sectionWithHeaderTitle:@"关闭"];
    
    [self.manager addSection:closeSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.closeCodeItem = [RERadioItem itemWithTitle:@"关闭代码" value:nil selectionHandler:^(RERadioItem *item) {
        
        [item deselectRowAnimated:YES];
//        NSArray *users =closeCodeDic.allKeys;
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:nil multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        optionsController.delegate = weakSelf;
        optionsController.style = closeSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.isMajorItem = [REBoolItem itemWithTitle:@"重大问题" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    self.isSoluationItem = [REBoolItem itemWithTitle:@"解决方案是否有效" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    
    
    self.commentItem=[RELongTextItem itemWithTitle:@"备注" value:nil placeholder:nil];
    self.commentItem.cellHeight=132;
    
    [closeSection addItem:self.closeCodeItem];
    [closeSection addItem:self.isMajorItem];
    [closeSection addItem:self.isSoluationItem];
    [closeSection addItem:self.commentItem];
    
    return closeSection;
}


//评审
- (RETableViewSection *)addReviewSection
{
    RETableViewSection *reviewSection = [RETableViewSection sectionWithHeaderTitle:@"评审"];
    [self.manager addSection:reviewSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem=[RELongTextItem itemWithTitle:@"工作日志" value:nil placeholder:nil];
    self.commentItem.cellHeight=132;
    
    [reviewSection addItem:self.commentItem];
    return reviewSection;
}



#pragma mark -
#pragma mark Button Example

- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"保存" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        
    }];
    
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
