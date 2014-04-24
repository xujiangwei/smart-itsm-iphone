//
//  SDiscoveryViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-2-13.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SDiscoveryViewController.h"
#import "SDiscoveryDetailViewController.h"

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
    self.sectionArray = [[NSMutableArray alloc] initWithObjects:@"设备", @"指标", @"通讯录", @"拨测", nil];
    SResource *resource = [[SResource alloc]init];
    [resource setResourceName:@"dhcc_test"];
    [resource setResourceIp:@"192.168.0.1"];
    
    NSMutableArray *resources = [[NSMutableArray alloc]initWithObjects:resource, nil];
    NSMutableArray *indicators = [[NSMutableArray alloc] initWithObjects:@"flower_cpu", nil];
    NSMutableArray *contacts = [[NSMutableArray alloc] initWithObjects:@"张三", @"李四", nil];
    NSMutableArray *dials = [[NSMutableArray alloc]initWithObjects:@"ping 10.10.152.18", nil];
    self.discoveryDic = [NSMutableDictionary dictionaryWithObjectsAndKeys:resources,[self.sectionArray objectAtIndex:0],
                         indicators,[self.sectionArray objectAtIndex:1],
                         contacts, [self.sectionArray objectAtIndex:2],
                         dials, [self.sectionArray objectAtIndex:3], nil];
    
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
