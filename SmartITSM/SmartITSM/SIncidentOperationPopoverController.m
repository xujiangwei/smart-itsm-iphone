//
//  WEPopoverContentViewController.m
//  WEPopover
//
//  Created by Werner Altewischer on 06/11/10.
//  Copyright 2010 Werner IT Consultancy. All rights reserved.
//

#import "SIncidentOperationPopoverController.h"
#import "SIncidentProcessViewController.h"


@implementation SIncidentOperationPopoverController
@synthesize operationArray;
@synthesize contentTabBarController;

#pragma mark -
#pragma mark Initialization

- (id)initWithStyle:(UITableViewStyle)style {

    if ((self = [super initWithStyle:style])) {
        self.preferredContentSize = CGSizeMake(100, 3 * 44 - 1);
      }
    return self;
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initData];

	self.tableView.rowHeight = 44.0;
	self.view.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.operationArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier =[NSString stringWithFormat:@"OperationCell"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [self.operationArray objectAtIndex:indexPath.row];
	cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    NSInteger section=indexPath.section;
    //    NSInteger row=indexPath.row;
    //
    //    UITableViewCell *cell=[tableView cellForRowAtIndexPath:indexPath];
    
    SIncidentProcessViewController  *processVC=[[SIncidentProcessViewController alloc]init];
//    ControlsViewController  *processVC=[[ControlsViewController alloc]init];
    [contentTabBarController.navigationController pushViewController:processVC animated:YES];
    
    
    contentTabBarController.popoverController=nil ;
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)initData
{
    self.operationArray =[NSArray arrayWithObjects:@"解决",@"转派一线", @"退出" ,nil];
}

@end

