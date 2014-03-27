//
//  SIncidentProcessViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-27.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SIncidentProcessViewController.h"
#import "RETableViewOptionsController.h"

@interface SIncidentProcessViewController ()
{
    NSMutableDictionary *categoryDic;
    
    NSMutableDictionary *allUserDic;
    
    NSMutableDictionary *bpiDic;
    
    NSMutableDictionary *ciDic;
    
    NSMutableDictionary *impactDic;
    
    NSMutableDictionary *urgentDic;
    
    NSMutableDictionary *serviceLevelDic;
    
    NSMutableDictionary *closeCodeDic;
    
    NSMutableDictionary *taskActorDic;
    
    NSMutableDictionary *reportWayDic;
    
    NSMutableDictionary *sourceDic;

}

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

@property (strong, readwrite, nonatomic) RELongTextItem *summaryItem;       //摘要
@property (strong, readwrite, nonatomic) RELongTextItem *descriptionItem;   //描述
@property (strong, readwrite, nonatomic) RERadioItem  *categoryItem;         //类别
@property (strong, readwrite, nonatomic) REDateTimeItem *occurTimeItem;     //发生时间

@property (strong, readwrite, nonatomic) RERadioItem *applicantItem;        //申报人
@property (strong, readwrite, nonatomic) RERadioItem *influencerItem;       //影响人
@property (strong, readwrite, nonatomic) RERadioItem *reportWaysItem;       //报告方式
@property (strong, readwrite, nonatomic) RERadioItem *sourceItem;           //报告源

@property (strong, readwrite, nonatomic) RERadioItem *contactorItem;        //联系人

@property (strong, readwrite, nonatomic) RERadioItem *urgentItem;           //紧急程度
@property (strong, readwrite, nonatomic) RERadioItem *impactItem;           //影响程度
@property (strong, readwrite, nonatomic) RERadioItem *serviceLevelItem;     //优先级
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

@implementation SIncidentProcessViewController

@synthesize categoryItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        
    }
    return self;
}


- (void)viewDidLoad
{
//    [[MastEngine sharedSingleton] addListener:@"requestBpCategory" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestUserList" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestCiList" listener:_listener];
//    //    [[MastEngine sharedSingleton] addListener:@"requestBpiList" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestImpactList" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestUrgentList" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestServiceLevelList" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestCloseCodeList" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"sendIncidentProcessResult" listener:_listener];
//    [[MastEngine sharedSingleton] addListener:@"requestNextTaskActorList" listener:_listener];
    
    reportWayDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"电话",@"2",@"短信",@"3",@"邮件",@"4",@"自服务台",@"5",@"其他",@"6",@"监控工具", Nil];
    sourceDic=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"1",@"个人",@"2",@"部门",@"3", @"单位",@"4",@"地点", Nil];
    
    
//    [[MastEngine sharedSingleton] addFailureListener:_failureListener];
    
    [super viewDidLoad];
    [self.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                                     [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
                                                                     NSForegroundColorAttributeName,
                                                                     [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
                                                                     NSForegroundColorAttributeName,
                                                                     [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
                                                                     NSShadowAttributeName,
                                                                     [UIFont fontWithName:@"Arial-Bold"size:0.0],
                                                                     NSFontAttributeName,nil]];
//    Theme *theme = [ThemeManager sharedSingleton].theme;
    [self.navigationController.navigationBar setFrame:CGRectMake(0, 0, 698, 44)];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:theme.contentToolbarBackground]  forBarMetrics:UIBarMetricsDefault];
    self.view.autoresizingMask = UIViewAutoresizingNone;
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 54, 31)];
    [backBtn setBackgroundImage:[UIImage imageNamed:@"Images/return_blue_normal.png"] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    backBtnItem.tintColor=[UIColor colorWithRed:98.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0];
    self.navigationItem.leftBarButtonItem = backBtnItem;
    
    
    self.manager = [[RETableViewManager alloc] initWithTableView:self.tableView delegate:self];
    
    
    if ([self.processTag isEqualToString:@"ACCEPT"]) {
        self.basicSection =  [self addBasicSection];
        self.sourceSection = [self addSourceSection];
        self.serviceLevelSection=[self addServiceLevelSection];
        self.relatedSection=[self addRelatedSection];
        self.acceptSection=[self addAcceptSection];
    }else if([self.processTag isEqualToString:@"ASSIGN"]){
        self.basicSection =  [self addBasicSection];
        self.sourceSection = [self addSourceSection];
        self.serviceLevelSection=[self addServiceLevelSection];
        self.relatedSection=[self addRelatedSection];
        self.assignSection=[self addAssignSection];
    }else if([self.processTag isEqualToString:@"SOLVE"]){
        self.basicSection =  [self addBasicSection];
        self.sourceSection = [self addSourceSection];
        self.serviceLevelSection=[self addServiceLevelSection];
        self.relatedSection=[self addRelatedSection];
        self.solveSection=[self addSolveSection];
    }else if([self.processTag isEqualToString:@"RETURN"]){
        self.basicSection =  [self addBasicSection];
        self.sourceSection = [self addSourceSection];
        self.serviceLevelSection=[self addServiceLevelSection];
        self.relatedSection=[self addRelatedSection];
        self.returnSection=[self addReturnSection];
    }else if([self.processTag isEqualToString:@"FEEDBACK"]){
        self.basicSection =  [self addBasicSection];
        self.sourceSection = [self addSourceSection];
        self.serviceLevelSection=[self addServiceLevelSection];
        self.relatedSection=[self addRelatedSection];
        self.feedBackSection=[self addFeedBackSection];
    }else if([self.processTag isEqualToString:@"CLOSE"]){
        self.closeSection=[self addCloseSection];
    }else if([self.processTag isEqualToString:@"EVALUATE"]){
        self.evaluateSection=[self addEvaluateSection];
        
    }
    
//    self.buttonSection = [self addButton];
    

    
}

- (void)viewDidUnload
{
       [super viewDidUnload];
}


- (void)doBack:(id)sender
{
//    if (self.delegate!=nil && [self.delegate respondsToSelector:@selector(didBack)]) {
//        [self.delegate didBack];
//    }
}


#pragma mark -
#pragma mark Basic Controls Example

- (RETableViewSection *)addBasicSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *basicSection = [RETableViewSection sectionWithHeaderTitle:@"基本信息"];
    
    [self.manager addSection:basicSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.summaryItem = [RELongTextItem itemWithTitle:@"摘要" value:self.incident.summary  placeholder:nil];
//    [self.summaryItem setUserInteractionEnabled:YES];
    
    self.descriptionItem = [RELongTextItem itemWithTitle:@"描述" value:self.incident.description  placeholder:nil];
//    [self.descriptionItem setUserInteractionEnabled:YES];
    
    self.occurTimeItem = [REDateTimeItem itemWithTitle:@"发生时间" value:[NSDate date] placeholder:nil format:@"yyyy mm dd hh:mm a" datePickerMode:UIDatePickerModeDateAndTime];
    self.occurTimeItem.onChange = ^(REDateTimeItem *item){
    };
    self.categoryItem = [RERadioItem itemWithTitle:@"故障类型" value:self.incident.category selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        NSArray *label =[[NSArray alloc]initWithObjects:@"故障类型",nil];
        NSArray *data =categoryDic.allKeys;
        
        NSDictionary *relatedCisDic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:data,[label objectAtIndex:0], nil];
//        
//        SIncidentOptionViewController *optionVC=[[SIncidentOptionViewController alloc]init];
//        optionVC.title=@"故障类型";
//        optionVC.fieldSetArray=label;
//        optionVC.attributeDic=relatedCisDic;
//        optionVC.selectedValue=self.categoryItem.value;
//        optionVC.incidentProcessVC=self;
        
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 54, 31)];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"Images/return_blue_normal.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        backBtnItem.tintColor=[UIColor colorWithRed:98.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0];
        self.navigationItem.leftBarButtonItem = backBtnItem;
        
        
//        [self.navigationController pushViewController:optionVC animated:YES];
        
    }];
    
    self.contactorItem = [RERadioItem itemWithTitle:@"联系人" value:self.incident.contact  selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        NSArray *users =allUserDic.allKeys;
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:users multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = basicSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        //
        //        [weakSelf.navigationController.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
        //                                                                         [UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0],
        //                                                                         UITextAttributeTextColor,
        //                                                                         [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.8],
        //                                                                         UITextAttributeTextShadowColor,
        //                                                                         [NSValue valueWithUIOffset:UIOffsetMake(0, -1)],
        //                                                                         UITextAttributeTextShadowOffset,
        //                                                                         [UIFont fontWithName:@"Arial-Bold"size:0.0],
        //                                                                         UITextAttributeFont,nil]];
        //        Theme *theme = [ThemeManager sharedSingleton].theme;
        //        [weakSelf.navigationController.navigationBar setFrame:CGRectMake(0, 0, 698, 44)];
        //        [weakSelf.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:theme.contentToolbarBackground]  forBarMetrics:UIBarMetricsDefault];
        //        weakSelf.view.autoresizingMask = UIViewAutoresizingNone;
        //
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [backBtn setFrame:CGRectMake(0, 0, 54, 31)];
        [backBtn setBackgroundImage:[UIImage imageNamed:@"Images/return_blue_normal.png"] forState:UIControlStateNormal];
        [backBtn addTarget:self action:@selector(doBack:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *backBtnItem = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
        backBtnItem.tintColor=[UIColor colorWithRed:98.0/255.0 green:98.0/255.0 blue:98.0/255.0 alpha:1.0];
        weakSelf.navigationItem.leftBarButtonItem = backBtnItem;
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    self.summaryItem.cellHeight=44;  //设置每个cell 的高度
    [basicSection addItem:self.summaryItem];
    self.descriptionItem.cellHeight=88;
    [basicSection addItem:self.descriptionItem];
    [basicSection addItem:self.categoryItem];
    [basicSection addItem:self.occurTimeItem];
    [basicSection addItem:self.contactorItem];
    [basicSection.tableViewManager.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    return basicSection;
}

- (RETableViewSection *)addSourceSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *sourceSection = [RETableViewSection sectionWithHeaderTitle:@"报告源"];
    [self.manager addSection:sourceSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.reportWaysItem = [RERadioItem itemWithTitle:@"报告方式" value:self.incident.reportWays  selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:reportWayDic.allKeys multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = sourceSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
        
        
    }];
    self.sourceItem = [RERadioItem itemWithTitle:@"报告来源" value:@"个人" selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:sourceDic.allKeys multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            //            [StackControllerHelper leaveSwap];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = sourceSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    
    self.applicantItem = [RERadioItem itemWithTitle:@"申请人" value:self.incident.applicant selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        NSArray *users =allUserDic.allKeys;
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:users multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = sourceSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        
        
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.influencerItem = [RERadioItem itemWithTitle:@"影响人" value:self.incident.influencer selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        NSArray *users =allUserDic.allKeys;
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:users multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = sourceSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    
    [sourceSection addItem:self.reportWaysItem];
    [sourceSection addItem:self.sourceItem];
    [sourceSection addItem:self.applicantItem];
    [sourceSection addItem:self.influencerItem];
    
    return sourceSection;
}

- (RETableViewSection *)addServiceLevelSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *serviceLevelSection = [RETableViewSection sectionWithHeaderTitle:@"优先级"];
    [self.manager addSection:serviceLevelSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.urgentItem = [RERadioItem itemWithTitle:@"紧急程度" value:self.incident.urgent selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:urgentDic.allKeys multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            //            [StackControllerHelper leaveSwap];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = serviceLevelSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    self.impactItem = [RERadioItem itemWithTitle:@"影响程度" value:self.incident.impact  selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:impactDic.allKeys multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            //            [StackControllerHelper leaveSwap];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = serviceLevelSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
        
    }];
    
    self.serviceLevelItem = [RERadioItem itemWithTitle:@"优先级" value:self.incident.serviceLevel  selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:serviceLevelDic.allKeys multipleChoice:NO completionHandler:^{
            [weakSelf.navigationController popViewControllerAnimated:YES];
            //            [StackControllerHelper leaveSwap];
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = serviceLevelSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    self.isMajorItem = [REBoolItem itemWithTitle:@"是否重大事故" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        NSLog(@"Value: %@", item.value ? @"YES" : @"NO");
    }];
    [serviceLevelSection addItem:self.urgentItem];
    [serviceLevelSection addItem:self.impactItem];
    [serviceLevelSection addItem:self.serviceLevelItem];
    [serviceLevelSection addItem:self.isMajorItem];
    
    return serviceLevelSection;
}


- (RETableViewSection *)addRelatedSection
{
    __typeof (&*self) __weak weakSelf = self;
    
    RETableViewSection *relatedSection = [RETableViewSection sectionWithHeaderTitle:@"关联信息"];
    [self.manager addSection:relatedSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    
    NSMutableArray *selectedCiInfo=[[NSMutableArray alloc]init];
    for(NSDictionary *ciDictionary in self.incident.ciSet){
        [selectedCiInfo addObject:[ciDictionary objectForKey:@"name"]];
    }
    self.cisItem = [REMultipleChoiceItem itemWithTitle:@"影响配置项" value:selectedCiInfo selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        NSArray *cis =ciDic.allKeys;
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:cis multipleChoice:YES completionHandler:^{
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"%@", item.value);
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = relatedSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    
    NSMutableArray *selectedBpiInfo=[[NSMutableArray alloc]init];
    for(NSDictionary *bpiDictionary in self.incident.assocatesBpSet){
        [selectedBpiInfo addObject:[bpiDictionary objectForKey:@"code"]];
    }
    self.assocatedBpsItem = [REMultipleChoiceItem itemWithTitle:@"关联工单" value:selectedBpiInfo  selectionHandler:^(REMultipleChoiceItem *item) {
        [item deselectRowAnimated:YES];
        
        NSArray *bpis =bpiDic.allKeys;
        
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:bpis multipleChoice:YES completionHandler:^{
            [item reloadRowWithAnimation:UITableViewRowAnimationNone];
            NSLog(@"%@", item.value);
        }];
        
        optionsController.delegate = weakSelf;
        optionsController.style = relatedSection.style;
        if (weakSelf.tableView.backgroundView == nil) {
            optionsController.tableView.backgroundColor = weakSelf.tableView.backgroundColor;
            optionsController.tableView.backgroundView = nil;
        }
        
        [weakSelf.navigationController pushViewController:optionsController animated:YES];
    }];
    
    [relatedSection addItem:self.cisItem];
    [relatedSection addItem:self.assocatedBpsItem];
    return relatedSection;
}


//***********故障工单处理***************
// 受理
- (RETableViewSection *)addAcceptSection
{
    RETableViewSection *acceptSection = [RETableViewSection sectionWithHeaderTitle:@"受理"];
    [self.manager addSection:acceptSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.markItem = [RELongTextItem itemWithTitle:@"备注" value:nil placeholder:@"请填写备注信息"];
//    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [acceptSection addItem:self.markItem];
    
    return acceptSection;
}

//分派一线或分派二线
- (RETableViewSection *)addAssignSection
{
    __typeof (&*self) __weak weakSelf = self;
    RETableViewSection *assignSection = [RETableViewSection sectionWithHeaderTitle:@"分派"];
    [self.manager addSection:assignSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.assignerItem = [RERadioItem itemWithTitle:@"分派给" value:nil selectionHandler:^(RERadioItem *item) {
        [item deselectRowAnimated:YES];
        NSArray *actors =taskActorDic.allKeys;
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:actors multipleChoice:NO completionHandler:^{
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
    
    self.markItem = [RELongTextItem itemWithTitle:@"备注" value:nil placeholder:@"请填写备注信息"];
//    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [assignSection addItem:self.assignerItem];
    [assignSection addItem:self.markItem];
    
    return assignSection;
}

//解决（一线解决与二线解决的界面不一致）
- (RETableViewSection *)addSolveSection
{
    RETableViewSection *solveSection = [RETableViewSection sectionWithHeaderTitle:@"解决"];
    [self.manager addSection:solveSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.investDiagnItem=[RELongTextItem itemWithTitle:@"调查诊断" value:nil placeholder:nil];
    self.reasonItem=[RELongTextItem itemWithTitle:@"产生原因" value:nil placeholder:nil];
    self.resolutionItem = [RELongTextItem itemWithTitle:@"解决方案" value:nil placeholder:nil];
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
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
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
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.isSolveItem = [REBoolItem itemWithTitle:@"是否解决" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        
    }];
    self.markItem = [RELongTextItem itemWithTitle:@"备注" value:nil placeholder:nil];
//    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [feedBackSection addItem:self.isSolveItem];
    [feedBackSection addItem:self.markItem];
    
    return feedBackSection;
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
        NSArray *closeCodeArray =closeCodeDic.allKeys;
        RETableViewOptionsController *optionsController = [[RETableViewOptionsController alloc] initWithItem:item options:closeCodeArray multipleChoice:NO completionHandler:^{
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
    
    self.markItem=[RELongTextItem itemWithTitle:@"备注" value:nil placeholder:nil];
//    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [closeSection addItem:self.closeCodeItem];
    [closeSection addItem:self.markItem];
    
    return closeSection;
}


//评价，适用于发起故障请求者
- (RETableViewSection *)addEvaluateSection
{
    RETableViewSection *evaluateSection = [RETableViewSection sectionWithHeaderTitle:@"用户评价"];
    [self.manager addSection:evaluateSection];
    self.manager[@"MultilineTextItem"] = @"MultilineTextCell";
    
    self.satisfactionItem = [REBoolItem itemWithTitle:@"用户满意度" value:YES switchValueChangeHandler:^(REBoolItem *item) {
        
    }];
    self.markItem = [RELongTextItem itemWithTitle:@"评价" value:nil placeholder:nil];
//    [self.markItem setUserInteractionEnabled:YES];
    self.markItem.cellHeight=132;
    
    [evaluateSection addItem:self.satisfactionItem];
    [evaluateSection addItem:self.markItem];
    
    return evaluateSection;
}


#pragma mark -
#pragma mark Button Example
//
//- (RETableViewSection *)addButton
//{
//    
//    RETableViewSection *section = [RETableViewSection section];
//    [self.manager addSection:section];
//    
//    RETableViewItem *buttonItem = [RETableViewItem itemWithTitle:@"保存" accessoryType:UITableViewCellAccessoryNone selectionHandler:^(RETableViewItem *item) {
//        
//        //        NSString *summary=self.summaryItem.value;
//        NSString *summary = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self.summaryItem.value, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
//        NSString *description = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self.descriptionItem.value, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
//        
//        NSString *category=[categoryDic objectForKey:self.categoryItem.value];
//        
//        NSDate   *occurTime=self.occurTimeItem.value;
//        NSString *contactId=[allUserDic objectForKey:self.contactorItem.value];
//        NSString *reportWays=[reportWayDic objectForKey:self.reportWaysItem.value];
//        NSString *source=[sourceDic objectForKey:self.sourceItem.value];
//        NSString *applicant=[allUserDic objectForKey:self.applicantItem.value];
//        NSString *influencer=[allUserDic objectForKey:self.influencerItem.value];
//        NSString *urgent=[urgentDic objectForKey:self.urgentItem.value];
//        NSString *impact=[impactDic objectForKey:self.impactItem.value];
//        NSString *serviceLevel=[serviceLevelDic objectForKey:self.serviceLevelItem.value];
//        NSString *isMajor=self.isMajorItem.value?@"1":@"2";
//        
//        //        NSString *comment=self.markItem.value;
//        NSString *comment = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self.markItem.value, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
//        
//        NSString *assigner=self.assignerItem.value;
//        
//        //        NSString *investDiagn=self.investDiagnItem.value;    //调查诊断
//        NSString *investDiagn = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self.investDiagnItem.value, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
//        
//        NSString *isSolved=self.isSolveItem.value? @"1": @"2";          //是否解决
//        //        NSString *reason=self.reasonItem.value;              //原因
//        NSString *reason = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self.reasonItem.value, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
//        
//        //        NSString *resolution=self.resolutionItem.value;     //解决方案
//        NSString *resolution = CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (__bridge CFStringRef)self.resolutionItem.value, NULL, CFSTR("!*'\"();:@&=+$,/?%#[]% "), kCFStringEncodingUTF8));
//        
//        NSString *closeCode=[closeCodeDic objectForKey:self.closeCodeItem.value];       //关闭代码
//        
//        //向服务器发送请求数据
//        CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton]createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
//        dialect.action = @"sendIncidentProcessResult";
//        NSString *value = [NSString stringWithFormat:@"{\"incidentId\":\"%@\",\"code\":\"%@\", \"summary\":\"%@\",\"description\":\"%@\",\"category\":\"%@\",\"occurTime\":\"%@\", \"contactId\":\"%@\",\"reportWays\":\"%@\",\"source\":\"%@\",\"applicant\":\"%@\",\"influencer\":\"%@\",\"urgent\":\"%@\",\"impact\":\"%@\",\"serviceLevel\":\"%@\",\"isMajor\":\"%@\",\"comment\":\"%@\",\"assigner\":\"%@\",\"investDiagn\":\"%@\",\"isSolved\":\"%@\",\"reason\":\"%@\",\"resolution\":\"%@\",\"closeCode\":\"%@\",\"jbpmTransition\":\"%@\",\"token\":\"%@\"}"
//                           ,self.incident.incidentId,self.incident.code,summary,description,category,occurTime,contactId,reportWays,source,applicant,influencer,urgent,impact
//                           ,serviceLevel,isMajor,comment,assigner,investDiagn,isSolved,reason,resolution,closeCode,self.incident.jbpmTransition,[SUser getToken]];
//        NSLog(@"任务处理工单的值集：%@",value);
//        [dialect appendParam:@"data" stringValue:value];
//        [[MastEngine sharedSingleton] asynSendAction:@"SmartITOM" action:dialect];
//        [item reloadRowWithAnimation:UITableViewRowAnimationAutomatic];
//        
//        self.HUD = [[MBProgressHUD alloc]initWithView:self.view];
//        [self.view addSubview:self.HUD];
//        self.HUD.mode = MBProgressHUDModeIndeterminate;
//        self.HUD.labelText = @"正在保存数据，请稍候...";
//        self.HUD.delegate = self;
//        [self.HUD show:YES];
//        
//    }];
//    
//    buttonItem.textAlignment = NSTextAlignmentCenter;
//    [section addItem:buttonItem];
//    
//    return section;
//}

#pragma mark ------接口------
-(void) didRequestBpCategory:(NSMutableArray *)bpCategory
{
    NSMutableDictionary *tmpCategoryDic= [[NSMutableDictionary alloc]init];
    for(NSDictionary *bpCategoryDir in bpCategory){
        [tmpCategoryDic setObject:[bpCategoryDir objectForKey:@"id"] forKey:[bpCategoryDir objectForKey:@"text"]];
    }
    categoryDic=tmpCategoryDic;
}


- (void) didRequestAllUser:(NSMutableArray *)userArray
{
    NSMutableDictionary *tmpUserDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *userDic in userArray){
        [tmpUserDic setObject:[userDic objectForKey:@"id"] forKey:[userDic objectForKey:@"username"]];
        
    }
    allUserDic=tmpUserDic;
}


- (void) didRequestAllCi:(NSMutableArray *) ciArrayInfo
{
    NSMutableDictionary *tmpCiDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *ciDictionary in ciArrayInfo){
        [tmpCiDic setObject:[ciDictionary objectForKey:@"id"] forKey:[ciDictionary objectForKey:@"name"]];
    }
    ciDic=tmpCiDic;
    
}

- (void) didRequestAllBpi:(NSMutableArray *)bpiArrayInfo
{
    NSMutableDictionary *tmpBpiDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *bpiDictionary in bpiArrayInfo){
        [tmpBpiDic setObject:[bpiDictionary objectForKey:@"id"] forKey:[bpiDictionary objectForKey:@"code"]];
    }
    bpiDic=tmpBpiDic;
}

- (void) didRequestImpact:(NSMutableArray *)impactArray
{
    NSMutableDictionary *tmpImpactDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *impactDictionary in impactArray){
        [tmpImpactDic setObject:[impactDictionary objectForKey:@"id"] forKey:[impactDictionary objectForKey:@"symbol"]];
    }
    impactDic=tmpImpactDic;
}

- (void) didRequestUrgent:(NSMutableArray *)urgentArray
{
    NSMutableDictionary *tmpUrgentDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *urgentDictionary in urgentArray){
        [tmpUrgentDic setObject:[urgentDictionary objectForKey:@"id"] forKey:[urgentDictionary objectForKey:@"symbol"]];
    }
    urgentDic=tmpUrgentDic;
}


- (void) didRequestServiceLevel:(NSMutableArray *)serviceLevelArray
{
    NSMutableDictionary *tmpServiceLevelDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *slDic in serviceLevelArray){
        [tmpServiceLevelDic setObject:[slDic objectForKey:@"id"] forKey:[slDic objectForKey:@"symbol"]];
    }
    serviceLevelDic=tmpServiceLevelDic;
    
}

- (void) didRequestCloseCode:(NSMutableArray *)closeCodeArray
{
    NSMutableDictionary *tmpCloseCodeDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *ccDic in closeCodeArray){
        [tmpCloseCodeDic setObject:[ccDic objectForKey:@"id"] forKey:[ccDic objectForKey:@"name"]];
    }
    closeCodeDic=tmpCloseCodeDic;
}


-(void) didRequestNextTaskActor:(NSMutableArray *)usersArray
{
    NSMutableDictionary *tmpTaskActorDic=[[NSMutableDictionary alloc]init];
    for(NSDictionary *taDic in usersArray){
        [tmpTaskActorDic setObject:[taDic objectForKey:@"id"] forKey:[taDic objectForKey:@"username"]];
    }
    taskActorDic=tmpTaskActorDic;
    
    
    
}

#pragma mark -  SIncidentListenerDelegate
- (void )didSendIncidentProcessResult:(NSString *)token
{
    if(token){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.HUD removeFromSuperview];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"  message:@"操作已成功，请返回任务列表" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
            alert.tag=1;
            alert.delegate=self;
            [alert show];
            
//            //刷新故障任务列表
//            CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton]createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
//            dialect.action = @"requestIncidentList";
//            NSString *value = [NSString stringWithFormat:@"{\"token\":\"%@\",\"currentIndex\" : \"0\", \"pagesize\" : \"20\",\"filterId\" :\"%@\"}",[SUser getToken],nil];
//            [dialect appendParam:@"data" stringValue:value];
//            [[MastEngine sharedSingleton] asynSendAction:@"SmartITOM" action:dialect];
        });
    }else{
        [self.HUD removeFromSuperview];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示"  message:@"服务器出现错误，请联系管理员！" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
        alert.tag=2;
        alert.delegate=self;
        [alert show];
    }
}

#pragma mark -

#pragma mark -delegate

-(void)setFormValue:(id)value key:(NSString *)key
{
    [self.categoryItem setValue:value];
    [self.categoryItem reloadRowWithAnimation:UITableViewRowAnimationNone];
    
}

@end
