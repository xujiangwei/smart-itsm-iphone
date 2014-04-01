//
//  SProblemViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//



#import "SProblemViewController.h"
#import "SProblemDao.h"
#import "SProcessCell.h"

#define kCellHeight 60

@interface SProblemViewController ()
{
    //    MBProgressHUD *HUD;
    NSIndexPath  *currentIndexPath;
    SProblemContentTabBarController *problemContentVC;
}

@end

@implementation SProblemViewController
@synthesize problemListView;
@synthesize delegate;
@synthesize problems;

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
    
    problemListView.dataSource = self;
    problemListView.delegate=self;
    problems = [SProblemDao getProblemList];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}




#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}



#pragma makr - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [problems count];
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
    SProblem *tmpProblem= [problems objectAtIndex:indexPath.row];
    cell.codeLabel.text = tmpProblem.code;
//    NSString *stateImage=[SProblemDao getStateIcon:tempIncident];
//    cell.stateImage.image=[UIImage imageNamed:stateImage];
    cell.updateTimeLabel.text=tmpProblem.updateTime;
    cell.summaryLabel.text=tmpProblem.summary;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"ProblemDetail" sender:cell];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ProblemDetail"])
    {
        SProcessCell *selectCell = (SProcessCell *)sender;
        SProblemContentTabBarController *contentVC = (SProblemContentTabBarController *)[segue destinationViewController];
        [contentVC setTitle:[NSString stringWithFormat:@"%@",selectCell.codeLabel.text]];
    }
    
}

@end
