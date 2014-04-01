//
//  SProblemProcessViewController.m
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//
#import "SProblemProcessViewController.h"
#import "MultilineTextItem.h"

@interface SProblemProcessViewController ()

@property (strong, readwrite, nonatomic) RETableViewManager *manager;
@property (strong, readwrite, nonatomic) RETableViewSection *basicSection;

@property (strong, readwrite, nonatomic) RETableViewSection *sourceSection;
@property (strong, readwrite, nonatomic) RETableViewSection *serviceLevelSection;
@property (strong, readwrite, nonatomic) RETableViewSection *relatedSection;

@property (strong, readwrite, nonatomic) RETableViewSection *acceptSection;
@property (strong, readwrite, nonatomic) RETableViewSection *assignSection;
@property (strong, readwrite, nonatomic) RETableViewSection *solveSection;
@property (strong, readwrite, nonatomic) RETableViewSection *returnSection;
@property (strong, readwrite, nonatomic) RETableViewSection *feedBackSection;
@property (strong, readwrite, nonatomic) RETableViewSection *closeSection;
@property (strong, readwrite, nonatomic) RETableViewSection *evaluateSection;

@property (strong, readwrite, nonatomic) RETableViewSection *buttonSection;


@property (strong, readwrite, nonatomic) RETextItem *summaryItem;       //摘要
@property (strong, readwrite, nonatomic) RETextItem *descriptionItem;   //描述
@property (strong, readwrite, nonatomic) RERadioItem  *categoryItem;         //类别
@property (strong, readwrite, nonatomic) REDateTimeItem *occurTimeItem;     //发生时间

@property (strong, readwrite, nonatomic) RERadioItem *applicantItem;        //申报人
@property (strong, readwrite, nonatomic) RERadioItem *influencerItem;       //影响人
@property (strong, readwrite, nonatomic) RERadioItem *reportWaysItem;       //报告方式
@property (strong, readwrite, nonatomic) RERadioItem *sourceItem;           //报告源

@property (strong, readwrite, nonatomic) RERadioItem *contactorItem;        //联系人

@property (strong, readwrite, nonatomic) REPickerItem *urgentItem;           //紧急程度
@property (strong, readwrite, nonatomic) REPickerItem *impactItem;           //影响程度
@property (strong, readwrite, nonatomic) REPickerItem *serviceLevelItem;     //优先级
@property (strong, readwrite, nonatomic) REBoolItem  *isMajorItem;          //是否重大事故

@property (strong, readwrite, nonatomic) REMultipleChoiceItem *cisItem;     //影响配置项
@property (strong, readwrite, nonatomic) REMultipleChoiceItem *assocatedBpsItem; //关联工单

@property (strong, readwrite, nonatomic) RELongTextItem *markItem;       //备注n

@property (strong, readwrite, nonatomic) RERadioItem *assignerItem;
//@property (strong, readwrite, nonatomic) RELongTextItem *assignDescriptionItem;

@property (strong, readwrite, nonatomic) RELongTextItem *investDiagnItem;
@property (strong, readwrite, nonatomic) RELongTextItem *reasonItem;
@property (strong, readwrite, nonatomic) RELongTextItem *resolutionItem;

@property (strong, readwrite, nonatomic) REBoolItem *isSolveItem;             //是否解决

@property (strong, readwrite, nonatomic) RERadioItem *closeCodeItem;          //关闭代码

@property (strong, readwrite, nonatomic)REBoolItem *satisfactionItem;       //用户满意度

@end

@implementation SProblemProcessViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"故障处理";
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    self.basicSection = [self addBasicSection];
    //    self.acceptSection=[self addAcceptSection];
    self.solveSection=[self addSolveSection];
    self.buttonSection = [self addButton];
}

- (RETableViewSection *)addBasicSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *section = [RETableViewSection sectionWithHeaderTitle:@"基本信息"];
    
    [self.manager addSection:section];
    
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.summaryItem=[RETextItem itemWithTitle:@"摘要:" value:nil placeholder:@"服务器出现错误"];
    self.descriptionItem=[RETextItem itemWithTitle:@"描述:" value:nil placeholder:@"服务器出现错误,请尽快协助解决！"];
    self.descriptionItem.cellHeight=44;
    
    self.occurTimeItem = [REDateTimeItem itemWithTitle:@"发生时间:" value:[NSDate date] placeholder:nil format:@"MM/dd/yyyy hh:mm a" datePickerMode:UIDatePickerModeDateAndTime];
    self.occurTimeItem.onChange = ^(REDateTimeItem *item){
    };
    if (REUIKitIsFlatMode()) {
        self.occurTimeItem.inlineDatePicker = YES;
    }
    
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
    
    
    self.isMajorItem =[REBoolItem itemWithTitle:@"是否重大事故:" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    
    
    self.cisItem = [REMultipleChoiceItem itemWithTitle:@"影响配置项:" value:@[@"Option 2", @"Option 4"] selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        NSMutableArray *options = [[NSMutableArray alloc] init];
        for (NSInteger i = 1; i < 40; i++)
            [options addObject:[NSString stringWithFormat:@"Option %li", (long) i]];
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:options multipleChoice:YES completionHandler:^{
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"%@", item.value);
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = section.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    
    [section addItem:self.summaryItem];
    [section addItem:self.descriptionItem];
    [section addItem:self.occurTimeItem];
    [section addItem:self.impactItem];
    [section addItem:self.urgentItem];
    [section addItem:self.isMajorItem];
    [section addItem:self.cisItem];
    
    return section;
}


//***********故障工单处理***************
// 受理
- (RETableViewSection *)addAcceptSection
{
    RETableViewSection *acceptSection = [RETableViewSection sectionWithHeaderTitle:@"受理"];
    [self.manager addSection:acceptSection];
    //    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.markItem = [RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写备注信息"];
    //    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=88;
    
    [acceptSection addItem:self.markItem];
    
    return acceptSection;
}


//解决（一线解决与二线解决的界面不一致）
- (RETableViewSection *)addSolveSection
{
    RETableViewSection *solveSection = [RETableViewSection sectionWithHeaderTitle:@"故障解决"];
    [self.manager addSection:solveSection];
    //    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.investDiagnItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写调查诊断信息"];
    self.investDiagnItem.cellHeight=88;
    self.reasonItem=[RELongTextItem itemWithTitle:nil value:nil placeholder:@"请填写故障产生原因"];
    self.reasonItem.cellHeight=88;
    self.resolutionItem = [RELongTextItem itemWithTitle:nil value:nil placeholder:@"你的解决方案"];
    //    [self.investDiagnItem setUserInteractionEnabled:YES];
    //    [self.reasonItem setUserInteractionEnabled:YES];
    //    [self.resolutionItem setUserInteractionEnabled:YES];
    
    self.resolutionItem.cellHeight=132;
    
    [solveSection addItem:self.investDiagnItem];
    [solveSection addItem:self.reasonItem];
    [solveSection addItem:self.resolutionItem];
    
    return solveSection;
}


//退回
- (RETableViewSection *)addReturnSection
{
    RETableViewSection *returnSection = [RETableViewSection sectionWithHeaderTitle:@"退回"];
    [self.manager addSection:returnSection];
    //    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.markItem=[RELongTextItem itemWithTitle:@"退回原因" value:nil placeholder:nil];
    //    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [returnSection addItem:self.markItem];
    
    return returnSection;
}

//回访，界面和二线解决界面类似
- (RETableViewSection *)addFeedBackSection
{
    RETableViewSection *feedBackSection = [RETableViewSection sectionWithHeaderTitle:@"回访"];
    
    [self.manager addSection:feedBackSection];
    //    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.isSolveItem = [REBoolItem itemWithTitle:@"是否解决" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        
    }];
    self.markItem = [RELongTextItem itemWithTitle:@"备注" value:nil placeholder:nil];
    //    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [feedBackSection addItem:self.isSolveItem];
    [feedBackSection addItem:self.markItem];
    
    return feedBackSection;
}



//评价，适用于发起故障请求者
- (RETableViewSection *)addEvaluateSection
{
    RETableViewSection *evaluateSection = [RETableViewSection sectionWithHeaderTitle:@"用户评价"];
    [self.manager addSection:evaluateSection];
    //    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.satisfactionItem = [REBoolItem itemWithTitle:@"用户满意度" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        
    }];
    self.markItem = [RELongTextItem itemWithTitle:@"评价" value:nil placeholder:nil];
    //    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [evaluateSection addItem:self.satisfactionItem];
    [evaluateSection addItem:self.markItem];
    
    return evaluateSection;
}


- (RETableViewSection *)addButton
{
    RETableViewSection *section = [RETableViewSection section];
    [self.manager addSection:section];
    
    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"保存" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
        item.title = @"Pressed!";
        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
    }];
    buttonItem.textAlignment = NSTextAlignmentCenter;
    [section addItem:buttonItem];
    
    return section;
}

@end
