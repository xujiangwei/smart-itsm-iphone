//
//  SProblemProcessViewController.m
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SProblemProcessViewController.h"
#import "RETableViewOptionsController.h"
#import "MultilineTextItem.h"

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


@property (strong, readwrite, nonatomic) RETextItem *descriptionItem;    //症状及描述
@property (strong, readwrite, nonatomic) RERadioItem  *categoryItem;         //问题类别
@property (strong, readwrite, nonatomic) REPickerItem *urgentItem;            //紧急程度
@property (strong, readwrite, nonatomic) REPickerItem *impactItem;            //影响程度


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
    self.title = @"问题处理（demo）";
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.basicSection = [self addBasicSection];
    self.acceptSection=[self addAcceptSection];
    self.rejectSection=[self addRejectSection];
    self.acceptSection=[self addAcceptSection];
    self.processSection=[self addProcessSection];
    self.closeSection=[self addCloseSection];
    self.reviewSection=[self addReviewSection];
    
    
    self.solveSection=[self addSolveSection];
    self.buttonSection = [self addButton];
    
}

- (RETableViewSection *)addBasicSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *basicSection = [RETableViewSection sectionWithHeaderTitle:@"基本信息"];
    
    [self.manager addSection:basicSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    
    self.descriptionItem=[RETextItem itemWithTitle:@"症状描述:" value:nil placeholder:@"服务器出现错误,请尽快协助解决！"];
    self.descriptionItem.cellHeight=44;

    self.categoryItem = [RERadioItem itemWithTitle:@"类型" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
      
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
    
        optionsController.delegate = weakSelf;
//        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
  
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    
    self.impactItem = [REPickerItem itemWithTitle:@"影响度:" value:@[@"一般"] placeholder:nil options:@[@[@"重大",@"大", @"中",@"一般", @"小",@"很小"]]];
    
    self.impactItem.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    if (REUIKitIsFlatMode()) {
        self.impactItem.inlinePicker = YES;
    }
    
    
    self.urgentItem = [REPickerItem itemWithTitle:@"紧急度:" value:@[@"大"] placeholder:nil options:@[@[@"大", @"中", @"小"]]];
    self.urgentItem.onChange = ^(REPickerItem *item){
        NSLog(@"Value: %@", item.value);
    };
    if (REUIKitIsFlatMode()) {
        self.urgentItem.inlinePicker = YES;
    }
    
    [basicSection addItem:self.descriptionItem];
    [basicSection addItem:self.categoryItem];
    [basicSection addItem:self.urgentItem];
    [basicSection addItem:self.impactItem];
    
//    [basicSection.tableViewManager.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
    
    self.directorItem = [RERadioItem itemWithTitle:@"负责人:" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        
        
        optionsController.delegate = weakSelf;
        //        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.memberItem = [RERadioItem itemWithTitle:@"小组成员:" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
         optionsController.delegate = weakSelf;
        //        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    
    self.commentItem = [RELongTextItem itemWithTitle:@"备注:" value:nil placeholder:@"请填写备注信息"];
    self.commentItem.cellHeight=88;
    
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
    
    self.closeCodeItem = [RERadioItem itemWithTitle:@"关闭代码:" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        optionsController.delegate = weakSelf;
        //        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.commentItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写拒绝理由"];

    self.commentItem.cellHeight=88;
    
    
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
    
    self.commentItem = [RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写备注信息"];

    self.commentItem.cellHeight=88;
    
    [acceptSection addItem:self.commentItem];
    
    return acceptSection;
}


//支持人员处理
- (RETableViewSection *)addProcessSection
{
    __typeof (&*self) __weak weakSelf = self;
    RETableViewSection *processSection = [RETableViewSection sectionWithHeaderTitle:@"支持人员处理"];
    [self.manager addSection:processSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem = [RELongTextItem itemWithTitle:nil value:nil placeholder:@"调查诊断"];
    self.commentItem.cellHeight=88;
    self.reasonItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"根本原因"];
    self.reasonItem.cellHeight=88;
   
    self.reasonCategoryItem = [RERadioItem itemWithTitle:@"类型" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 10; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
 
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        optionsController.delegate = weakSelf;
        //        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    self.resolutionItem = [RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写解决方案"];
    self.resolutionItem.cellHeight=88;
    
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
    
    self.commentItem = [RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写工作日志"];
    self.commentItem.cellHeight=88;
    [solveSection addItem:self.commentItem];
    return solveSection;
}


//支持人员退回
- (RETableViewSection *)addReturnSection
{
    RETableViewSection *returnSection = [RETableViewSection sectionWithHeaderTitle:@"支持人员退回"];
    [self.manager addSection:returnSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.commentItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写退回原因"];
    self.commentItem.cellHeight=88;
    
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
    
    self.closeCodeItem = [RERadioItem itemWithTitle:@"关闭代码:" value:@"Option 4" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES]; // same as [weakSelf.tableView deselectRowAtIndexPath:item.indexPath animated:YES];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            
            [item reloadRowWithAnimation:UITableViewRowAnimationNone]; // same as [weakSelf.tableView reloadRowsAtIndexPaths:@[item.indexPath] withRowAnimation:UITableViewRowAnimationNone];
        }];
        optionsController.delegate = weakSelf;
        //        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.isMajorItem = [REBoolItem itemWithTitle:@"重大问题:" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    self.isSoluationItem = [REBoolItem itemWithTitle:@"方案是否有效:" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    
    
    self.commentItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写备注信息"];
    self.commentItem.cellHeight=88;
    
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
    
    self.commentItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写评审日志信息"];
    self.commentItem.cellHeight=88;
    
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

}


@end
