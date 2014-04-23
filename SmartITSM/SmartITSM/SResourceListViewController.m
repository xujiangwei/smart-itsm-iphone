//
//  SResourceListViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-3-25.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SResourceListViewController.h"
#import "SResourceListViewCell.h"
#import "SResourceDao.h"
#import "MastPrerequisites.h"
#import "MastEngine.h"

@interface SResourceListViewController ()
{
    ResourceCategory _currentCategory;
    
    SResourceListListener *_listener;
    
    SResourceListStatusListener *_statutsListener;
}

@property (nonatomic) NSMutableArray *searchResults;

@property (strong) SResourceListViewCell *cellPrototype;

@end

@implementation SResourceListViewController

@synthesize fromDiscovery, fromTool;

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
        _currentCategory = All;
        
        _listener = [[SResourceListListener alloc] initWith:@"requestDevice"];
        _listener.delegate = self;
        
        _statutsListener = [[SResourceListStatusListener alloc] init];
        
    }
    return self;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[MastEngine sharedSingleton] addListener:kDemoCelletName listener:_listener];
    [[MastEngine sharedSingleton] addStatusListener:kDemoCelletName statusListener:_statutsListener];
    
    static NSString *CellIdentifier = @"SResourceListViewCell";
    [self.tableView registerNib:[UINib nibWithNibName:@"SResourceListViewCell" bundle:nil] forCellReuseIdentifier:CellIdentifier];
    
    self.cellPrototype = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    //加载本地数据
    [self loadLoclData];

    self.searchResults = [NSMutableArray arrayWithCapacity:[self.resourceList.resourceArray count]];
    
//    self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉可以刷新"];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    [[MastEngine sharedSingleton] removeListener:kDemoCelletName listener:_listener];
    [[MastEngine sharedSingleton] removeStatusListener:kDemoCelletName statusListener:_statutsListener];
    
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cellPrototype.frame.size.height;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.searchResults count];
    }
	else
	{
        return [self.resourceList.resourceArray count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SResourceListViewCell *cell;
    SResource *resource;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        static NSString *searchCellIdentifier = @"SResourceListSearchViewCell";
        
        cell = (SResourceListViewCell *)[tableView dequeueReusableCellWithIdentifier:searchCellIdentifier forIndexPath:indexPath];
       
        resource = [self.searchResults objectAtIndex:indexPath.row];
    }
	else
	{
        static NSString *CellIdentifier = @"SResourceListViewCell";
        
        cell = (SResourceListViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        resource = [self.resourceList.resourceArray objectAtIndex:indexPath.row];
    }
    
    [cell.resourceName setText:resource.resourceName];
    [cell.resourceIp setText:resource.resourceIp];
    
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */
#pragma mark SResourceListListenerDelegate

- (void)updateResourceList:(NSDictionary *)dic
{
    NSInteger statusCode = [[dic objectForKey:@"status"] integerValue];
    if (300 == statusCode)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableArray *resourceArray = [dic objectForKey:@"moList"];
            
            [SResourceDao deleteAllResource];
            
            for (int i = 0; i < [resourceArray count]; i++)
            {
                NSDictionary *dic = [resourceArray objectAtIndex:i];
                
                [SResourceDao insertResource:dic];
                
                [SResourceDao updateResource:dic];
                
            }
            
            if (All == _currentCategory)
            {
                self.resourceList = [SResourceDao getAllResource];
            }else
            {
//                self.resourceList = [SResourceDao getResourceListArrayWithCategory:_currentCategory];
                
            }
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"MMM d, h:mm a"];
            NSString *lastUpdate = [NSString stringWithFormat:@"上次更新日期 %@",[dateFormatter stringFromDate:[NSDate date]]];
            self.refreshControl.attributedTitle = [[NSAttributedString alloc]initWithString:lastUpdate];
            [self.refreshControl endRefreshing];
            [self.tableView reloadData];
        });
        
    }
    else if(900 == statusCode)
    {

    }
}

#pragma mark refreshControl 

- (IBAction)refreshControlAction:(id)sender
{
    UIRefreshControl *refreshC = (UIRefreshControl *)sender;
    refreshC.attributedTitle = [[NSAttributedString alloc] initWithString:@"更新数据中..."];

    
    //发送网络数据
    [self requestData];

}

#pragma mark - UISearchDisplayDelegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self updateFilteredContentForSearchString:searchString];
    
    return YES;
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView
{
    static NSString *searchCellIdentifier = @"SResourceListSearchViewCell";
    [tableView registerNib:[UINib nibWithNibName:@"SResourceListViewCell" bundle:nil] forCellReuseIdentifier:searchCellIdentifier];
}

#pragma mark - Private
- (void)loadLoclData
{
    self.resourceList = [SResourceDao getAllResource];
}

- (void)requestData
{
    CCActionDialect *dialect = (CCActionDialect *)[[CCDialectEnumerator sharedSingleton] createDialect:ACTION_DIALECT_NAME tracker:@"dhcc"];
    dialect.action = @"requestDevice";
    NSDictionary *valueDic = [NSDictionary dictionaryWithObjectsAndKeys:@"1",@"currentIndex",@"vendor",@"orderBy",@"",@"condition", nil];
    NSString *value = @"";
    if ([NSJSONSerialization isValidJSONObject:valueDic])
    {
        NSError *error;
        NSData *data = [NSJSONSerialization dataWithJSONObject:valueDic options:NSJSONWritingPrettyPrinted error:&error];
        value = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    }
    [dialect appendParam:@"data" stringValue:value];
    [[MastEngine sharedSingleton] asynPerformAction:@"SmartITOM" action:dialect];
}

#pragma mark - Content Filtering
- (void)updateFilteredContentForSearchString:(NSString *)searchString
{
    self.searchResults = [self.resourceList.resourceArray mutableCopy];
    
    NSString *strippedStr = [searchString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSArray *searchItems = nil;
    if (strippedStr.length > 0)
    {
        searchItems = [strippedStr componentsSeparatedByString:@" "];
    }
    
    NSMutableArray *andMatchPredicates = [NSMutableArray array];
    
    for (NSString *searchString in searchItems)
    {
        NSMutableArray *searchItemsPredicate = [NSMutableArray array];
        
        NSExpression *lhs = [NSExpression expressionForKeyPath:@"resourceIp"];
        NSExpression *rhs = [NSExpression expressionForConstantValue:searchString];
        NSPredicate *finalPredicate = [NSComparisonPredicate
                                       predicateWithLeftExpression:lhs
                                       rightExpression:rhs
                                       modifier:NSDirectPredicateModifier
                                       type:NSContainsPredicateOperatorType
                                       options:NSCaseInsensitivePredicateOption];
        [searchItemsPredicate addObject:finalPredicate];
        
        NSCompoundPredicate *orMatchPredicates = (NSCompoundPredicate *)[NSCompoundPredicate orPredicateWithSubpredicates:searchItemsPredicate];
        [andMatchPredicates addObject:orMatchPredicates];
    }
    
    NSCompoundPredicate *finalCompoundPredicate = nil;
  
    finalCompoundPredicate =
    (NSCompoundPredicate *)[NSCompoundPredicate andPredicateWithSubpredicates:andMatchPredicates];
    
    self.searchResults = [[self.searchResults filteredArrayUsingPredicate:finalCompoundPredicate] mutableCopy];

}

@end
