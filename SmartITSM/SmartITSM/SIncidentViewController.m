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
//    MBProgressHUD *HUD;
    NSIndexPath  *currentIndexPath;
    SIncidentContentTabBarController *incidentContentVC;
    SIncidentListener *_listener;
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
        // Custom initialization
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        
        _listener = [[SIncidentListener alloc] initWith:@"requestIncidentList"];
        _listener.delegate = self;
   
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    incidentListView.dataSource = self;
    incidentListView.delegate = self;
    incidents = [SIncidentDao getTaskList];
    
    [[MastEngine sharedSingleton] addListener:@"SmartITOM" listener:_listener];
    
    [self refreshIncidentList];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[MastEngine sharedSingleton] removeListener:@"SmartITOM" listener:_listener];
    
}

- (void)updateIncidentList:(NSMutableArray *)incidentArray
{
    incidents = incidentArray;
//    [incidentListView reloadData];
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
    NSLog(@"incident");
}

#pragma mark - Private

- (void)refreshIncidentList
{
    //刷新故障任务列表
    CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton]createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
    dialect.action = @"requestIncidentList";
    NSString *value = [NSString stringWithFormat:@"{\"token\":\"%@\",\"currentIndex\" : \"0\", \"pagesize\" : \"20\",\"filterId\" :\"%@\"}",[SUser getToken],nil];
    [dialect appendParam:@"data" stringValue:value];
    [[MastEngine sharedSingleton] asynPerformAction:@"SmartITOM" action:dialect];
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
