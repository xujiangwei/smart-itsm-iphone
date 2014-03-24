//
//  SIncidentViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SIncidentViewController.h"
#import "SIncidentDao.h"
#import "SIncidentContentViewController.h"
#import "SIncidentBaseInfoCell.h"

#define kCellHeight 50

@interface SIncidentViewController ()
{
//    MBProgressHUD *HUD;
    NSIndexPath  *currentIndexPath;
    SIncidentContentViewController *incidentContentVC;
}

@end

@implementation SIncidentViewController
@synthesize incidentListView;
//@synthesize incidentPopVC;
//@synthesize delegate;
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
    
    self.incidentListView.dataSource = self;
    self.incidentListView.delegate = self;
    incidents = [SIncidentDao getTaskList];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

- (void)viewDidUnload
{
    [self setIncidentListView:nil];
//    [self setIncidentPopVC:nil];
    
    
    [super viewDidUnload];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    
}

#pragma makr - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [incidents count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SIncidentBaseInfoCell";
    
    SIncidentBaseInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    
    SIncident *tempIncident= [incidents objectAtIndex:indexPath.row];
    cell.codeLabel.text = tempIncident.code;
    NSString *stateImage=[SIncidentDao getStateIcon:tempIncident];
    cell.stateImage.image=[UIImage imageNamed:stateImage];
    //    cell.stateLabel.text =tempIncident.state;
    cell.updateTimeLabel.text=tempIncident.updateTime;
    cell.summaryLabel.text=tempIncident.summary;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


#pragma  mark rotate

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}







@end
