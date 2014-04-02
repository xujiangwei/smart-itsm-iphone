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

#define kCellHeight 60

@interface SIncidentViewController ()
{
//    MBProgressHUD *HUD;
    NSIndexPath  *currentIndexPath;
    SIncidentContentTabBarController *incidentContentVC;
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    incidentListView.dataSource = self;
    incidentListView.delegate = self;
    incidents = [SIncidentDao getTaskList];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
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
