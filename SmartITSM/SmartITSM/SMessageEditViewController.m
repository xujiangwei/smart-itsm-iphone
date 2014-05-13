//
//  SMessageEditViewController.m
//  SmartITSM
//
//  Created by Apple Developer on 14-5-8.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SMessageEditViewController.h"

@interface SMessageEditViewController ()

@end

@implementation SMessageEditViewController

@synthesize editArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    //设置编辑的cell
    if ((self = [super initWithStyle:style])) {
        self.preferredContentSize = CGSizeMake(100, 2 * 44 - 1);
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    self.title = @"编辑";
	self.tableView.rowHeight = 44.0;
	self.view.backgroundColor = [UIColor clearColor];
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
}

-(void)initData
{
    self.editArray = [NSArray arrayWithObjects:@"删除", @"转移到", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.editArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier =[NSString stringWithFormat:@"EditCell"];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	cell.textLabel.text = [self.editArray objectAtIndex:indexPath.row];
	cell.textLabel.textColor = [UIColor blackColor];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
