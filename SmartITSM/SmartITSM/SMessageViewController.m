//
//  SMessageViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageViewController.h"
#import "SMessageContentViewController.h"
#import "SMessageViewCell.h"

@interface SMessageViewController ()

@end

@implementation SMessageViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    
    if ((self = [super initWithStyle:style]))
    {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.messageList = [[NSArray alloc] initWithObjects:@"消息1",@"工单消息2", nil];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SMessageViewCell" bundle:nil] forCellReuseIdentifier:@"SMessageViewCell"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    SMessageContentViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"SMessageContentVC"];
    
    SMessageViewCell *cell = (SMessageViewCell *)[tableView cellForRowAtIndexPath:indexPath];
    
    [viewController setTitle:[cell.lbMessageName text]];
    
    [self.navigationController pushViewController:viewController animated:YES];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.messageList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SMessageViewCell";
    SMessageViewCell *cell = (SMessageViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (nil == cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SMessageViewCell" bundle:nil] forCellReuseIdentifier:@"SMessageViewCell"];
    }
    
    [cell.lbMessageName setText:[self.messageList objectAtIndex:indexPath.row]];
    
    return cell;
}


/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    SMessageContentViewController *viewController = (SMessageContentViewController *)[segue destinationViewController];
    viewController.title = [cell.textLabel text];
 
}
 */



@end
