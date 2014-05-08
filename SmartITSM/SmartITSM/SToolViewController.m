//
//  SToolViewController.m
//  SmartITSM
//

#import "SToolViewController.h"
#import "SToolDetailViewController.h"
#import "SResourceListViewController.h"
#import "STool.h"


@interface SToolViewController ()

@property (nonatomic, strong) NSArray *sections;

@end

@implementation SToolViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self buildSections];
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        [self buildSections];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self)
    {
        [self buildSections];
    }
    return self;
}

- (void)buildSections
{
    // 巡检
    STool *manualPolling = [[STool alloc] init];
    manualPolling.name = @"巡检";
    manualPolling.desc = @"电子报单巡检";
    
    STool *resourceList = [[STool alloc] init];
    resourceList.name = @"资源";
    resourceList.desc = @"资源列表";
    
    // 常用工具
    NSArray *commonTools = [NSArray arrayWithObjects:manualPolling,nil];
    NSArray *commonTools1 = [NSArray arrayWithObjects:resourceList, nil];

    // 段落
    self.sections = [NSArray arrayWithObjects:commonTools, commonTools1, nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    [self.tableView registerClass:[SToolResourceListCell class] forCellReuseIdentifier:@"resourceList"];

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
    // Return the number of sections.
    return self.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    NSArray *tools = [self.sections objectAtIndex:section];
    return [tools count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    if (0 == indexPath.section)
    {
        static NSString *CellIdentifier = @"ToolCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSArray *tools = [self.sections objectAtIndex:indexPath.section];
        STool *tool = [tools objectAtIndex:indexPath.row];
        // Configure the cell...
        [cell.textLabel setText:tool.desc];
    }
    else if (1 == indexPath.section)
    {
        static NSString *CellIdentifier = @"resourceListCell";
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        NSArray *tools = [self.sections objectAtIndex:indexPath.section];
        STool *tool = [tools objectAtIndex:indexPath.row];
        // Configure the cell...
        [cell.textLabel setText:tool.desc];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSArray *tools = [self.sections objectAtIndex:section];
    STool *tool = [tools objectAtIndex:0];
    NSString *result = tool.name;
    return result;
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


#pragma mark - Navigation

- (IBAction)unwindSegueAtToolVCAction:(UIStoryboardSegue *)sender
{
    
}
// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    
    if ([segue.identifier isEqualToString:@"ToolDetail"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        
        SToolDetailViewController *detailVC = (SToolDetailViewController *)[segue destinationViewController];
        [detailVC setTitle:[NSString stringWithFormat:@"%@", selectCell.textLabel.text]];

    }else if ([segue.identifier isEqualToString:@"resourceList"])
    {
        UITableViewCell *selectCell = (UITableViewCell *)sender;
        
        SResourceListViewController *resourceListVC = (SResourceListViewController *)[segue destinationViewController];
        resourceListVC.fromTool = TRUE;
        [resourceListVC setTitle:[NSString stringWithFormat:@"%@", selectCell.textLabel.text]];
    }
    
   
}

@end
