//
//  SIncidentViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SIncidentViewController.h"
#import "SIncidentDao.h"
#import "SProcessCell.h"
#import "MastEngine.h"

#define kCellHeight 60

@interface SIncidentViewController ()
{
    NSIndexPath  *currentIndexPath;
    SIncidentContentTabBarController *incidentContentVC;
    SIncidentListener *_listener;
    MBProgressHUD *_HUD;
}

@end

@implementation SIncidentViewController
@synthesize incidentListView;
//@synthesize incidentPopVC;
@synthesize delegate;
@synthesize incidents;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self refreshIncidentList];

    incidents = [SIncidentDao getTaskList];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (nil != _listener)
    {
        [[MastEngine sharedSingleton] removeActionListener:kCelletName listener:_listener];
    }
    //实例化并添加监听器
    _listener = [[SIncidentListener alloc] initWith:@"requestIncidentList"];
    _listener.delegate = self;
    [[MastEngine sharedSingleton] addActionListener:kCelletName listener:_listener];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc
{
    //数据处理完成，移除监听器
    [[MastEngine sharedSingleton] removeActionListener:@"SmartITOM" listener:_listener];
}

- (void)updateIncidentList:(NSMutableArray *)incidentArray
{
    incidents = incidentArray;
    
    [incidentListView reloadData];
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}



#pragma makr - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [incidents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SProcessCell";
    
    SProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    SIncident *tempIncident= [incidents objectAtIndex:indexPath.row];
    cell.codeLabel.text = tempIncident.code;
    NSString *stateImage=[SIncidentDao getStateIcon:tempIncident];
    cell.stateImage.image=[UIImage imageNamed:stateImage];
    cell.updateTimeLabel.text=tempIncident.updateTime;
    cell.summaryLabel.text=tempIncident.summary;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"IncidentDetail" sender:cell];
}

#pragma mark - SIncidentListenerDelegate
- (void )didRequestIncidentList:(NSDictionary *)listDic
{
    if ([listDic objectForKey:@"success"]) {
        NSDictionary *incidentInfo=[listDic objectForKey:@"root"];
        //以下为清理缓存数据
        NSMutableArray *newIncidentIdArray=[[NSMutableArray alloc]init];
        for (NSDictionary *attriDic in incidentInfo) {
            [newIncidentIdArray addObject:[attriDic objectForKey:@"id"]];
        }
        
        NSMutableArray *incidentIdArray=[STaskDao getLocalIncidentIdList];
        for (NSString  *oldIncidentId in incidentIdArray) {
            if(![newIncidentIdArray containsObject:oldIncidentId]){
                [STaskDao deleteLocalIncidentById:oldIncidentId];
            }
        }
        
        for (NSDictionary *attriDic in incidentInfo) {
            //如果是存在的数据，就执行更新操作，如果是新数据，则执行插入操作
            if (![STaskDao insert:attriDic])
            {
                [STaskDao update:attriDic];
            }
        }
        incidents = [STaskDao getTaskList];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_HUD removeFromSuperview];
            
            [self.incidentListView reloadData];
        });
    }else{
        [_HUD removeFromSuperview];
    }
}

#pragma mark - Private

- (void)refreshIncidentList
{
    //刷新故障任务列表
    CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton]createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
    dialect.action = @"requestIncidentList";

    NSDictionary *valueDic = [NSDictionary dictionaryWithObjectsAndKeys:[SUser getToken], @"token",@"0", @"currentIndex", @"20", @"pagesize",@"", @"filterId", nil];
    NSString  *value = nil;
    
    if ([NSJSONSerialization isValidJSONObject:valueDic])
    {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:valueDic options:NSJSONWritingPrettyPrinted error:&error];
        value = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    }

    [dialect appendParam:@"data" stringValue:value];
    [[MastEngine sharedSingleton] asynPerformAction:kCelletName action:dialect];
    
    _HUD = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:_HUD];
    _HUD.mode = MBProgressHUDModeIndeterminate;
    _HUD.labelText = @"加载中...";
    _HUD.delegate = self;
    [_HUD show:YES];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"IncidentDetail"])
    {
        SProcessCell *selectCell = (SProcessCell *)sender;
       SIncidentContentTabBarController *contentVC = (SIncidentContentTabBarController *)[segue destinationViewController];
        [contentVC setTitle:[NSString stringWithFormat:@"%@",selectCell.codeLabel.text]];
    }
    
}

@end
