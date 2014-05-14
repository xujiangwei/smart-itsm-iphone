//
//  SDiscoveryViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-2-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SDiscoveryViewController.h"
#import "SDiscoveryDetailViewController.h"
#import "SDiscoveryDao.h"

@interface SDiscoveryViewController ()

@end

@implementation SDiscoveryViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
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
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self loadLocalData];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sectionArray count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sectionArray objectAtIndex:section];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSMutableArray *discoverArray = [self.discoveryDic objectForKey:[self.sectionArray objectAtIndex:section]];
    return [discoverArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"DiscoveryCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    NSString *section =[self.sectionArray objectAtIndex:indexPath.section];
    // Configure the cell...
    if ([section isEqualToString:@"设备"])
    {
        NSMutableArray *resources = [self.discoveryDic objectForKey:section];
        SResource *resource = [resources objectAtIndex:indexPath.row];
        [cell.textLabel setText:resource.resourceName];
    }
    else if ([section isEqualToString:@"指标"])
    {
        NSMutableArray *discoverArray = [self.discoveryDic objectForKey:section];
        NSString *discovery = [discoverArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:discovery];
    }
    else if ([section isEqualToString:@"通讯录"])
    {
        NSMutableArray *discoverArray = [self.discoveryDic objectForKey:section];
        NSString *discovery = [discoverArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:discovery];
    }
    else if ([section isEqualToString:@"拨测"])
    {
        NSMutableArray *discoverArray = [self.discoveryDic objectForKey:section];
        NSString *discovery = [discoverArray objectAtIndex:indexPath.row];
        [cell.textLabel setText:discovery];
    }
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
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
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

#pragma mark Private

- (void)loadLocalData
{
    //查询数据库，查看当前Discovery的种类
    NSMutableArray *discoveryTypes = [SDiscoveryDao selectAllDiscoveryType];
    self.sectionArray = [NSMutableArray arrayWithArray:discoveryTypes];
    
    
    self.discoveryDic = [[NSMutableDictionary alloc]initWithCapacity:2];
    for (NSString *discovery in self.sectionArray)
    {
        NSMutableArray *discoveryArray = nil;
        //查询各种类的具体Discovery
        discoveryArray = [SDiscoveryDao selectDiscoveryWithType:discovery];
        [self.discoveryDic setObject:discoveryArray forKey:discovery];
        
    }
    
}

- (void)reloadDiscoveryData
{
    [self loadLocalData];
    
    [self.tableView reloadData];
}


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"DiscoveryDetail"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        
        SDiscoveryDetailViewController *detailVC = (SDiscoveryDetailViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@",selectCell.textLabel.text]];
    }  
    else if ([segue.identifier isEqualToString:@"resourceList"])
    {
        SResourceListViewController *resourceListViewController = (SResourceListViewController *)[segue destinationViewController];
        resourceListViewController.fromDiscovery = TRUE;
        [resourceListViewController setTitle:@"设备列表"];
    }

}

#pragma mark - IBAction

- (IBAction)unwindSegueAtDiscoveryAction:(UIStoryboardSegue *)sender
{
    //Done操作
    SResourceListViewController *sourceVC = sender.sourceViewController;
    NSMutableArray *discoveryArray = sourceVC.discoveryArray;
    for (SResource *resource in discoveryArray) {
        [SDiscoveryDao insertDiscovery:[NSString stringWithFormat:@"%ld", resource.resourceId] withType:Resource];
    }
    
    NSMutableArray *cancelDiscoveryArray = sourceVC.cancelDiscoveryArray;
    for (SResource *resource in cancelDiscoveryArray) {
        [SDiscoveryDao deleteDiscovery:[NSString stringWithFormat:@"%ld",resource.resourceId] withType:Resource];
    }
  
    [self reloadDiscoveryData];
}


- (IBAction)addDiscovery:(id)sender
{
    UIActionSheet *sheet  = [[UIActionSheet alloc]initWithTitle:Nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"确定" otherButtonTitles:@"设备",@"性能", @"通讯录", nil];

    [sheet showFromBarButtonItem:(UIBarButtonItem *)sender animated:YES];
    
}

#pragma mark - UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex)
    {
        case 0:
        {
            NSLog(@"0");
        }
            break;
        case 1:
        {
            //设备
            [self performSegueWithIdentifier:@"resourceList" sender:self];
            
        }
            break;
        case 2:
        {
            NSLog(@"2");
        }
            break;
        case 3:
        {
            NSLog(@"3");
        }
            break;
        case 4:
        {
            NSLog(@"4");
        }
            
        default:
            break;
    }
}

@end
