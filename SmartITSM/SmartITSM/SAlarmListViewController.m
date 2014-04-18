//
//  SAlarmListViewController.m
//  SmartITSM
//
//  Created by 朱国强 on 14-4-3.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SAlarmListViewController.h"
#import "SAlarmContentViewController.h"
#import "SAlarmListViewCell.h"

@interface SAlarmListViewController ()
{
    NSArray *imageName;
}
@end

@implementation SAlarmListViewController

- (id)initWithStyle:(UITableViewStyle)style {
    
    if ((self = [super initWithStyle:style])) {
        
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
//        imageName = [NSArray arrayWithObjects:@"alarm_serious_lamp@2x.png",@"alarm_main_lamp@2x.png",@"alarm_minor_lamp@2x.png",@"alarm_lamp@2x.png",@"alarm_unkown_lamp@2x.png" ,nil];
        imageName = [NSArray arrayWithObjects:@"alarm_serious_lamp.png",@"alarm_main_lamp.png",@"alarm_minor_lamp.png",@"alarm_lamp.png",@"alarm_unkown_lamp.png" ,nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SAlarmListViewCell" bundle:nil] forCellReuseIdentifier:@"SAlarmListViewCell"];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    // Return the number of rows in the section.
    return [self.alarmList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"SAlarmListViewCell";
    SAlarmListViewCell *cell =(SAlarmListViewCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    if (!cell)
    {
        [tableView registerNib:[UINib nibWithNibName:@"SAlarmListViewCell" bundle:nil] forCellReuseIdentifier:@"SAlarmListViewCell"];
    }
    
    SAlarm *alarm = [self.alarmList objectAtIndex:indexPath.row];
    cell.nameLabel.text = alarm.objectOfManagement;
    cell.IPLabel.text = alarm.deviceIp;
    cell.IPLabel.font = [UIFont systemFontOfSize:14.0];
    cell.imageV.image = [UIImage imageNamed:[imageName objectAtIndex:self.index]];
    cell.imageView.contentMode = UIViewContentModeCenter;
    
    return cell;
}

#pragma mark -TableView Delegate

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SAlarmContentViewController *contentViewController = [storyboard instantiateViewControllerWithIdentifier:@"SAlarmContentVC"];
    SAlarm *alarm = [self.alarmList objectAtIndex:indexPath.row];
    SAlarm *myAlarm = [SAlarmDao getAlarmDetailWithAlarmId:alarm.ID];
    contentViewController.alarm = myAlarm;
    contentViewController.index = self.index;
    [self.navigationController pushViewController:contentViewController animated:YES];
}

//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60 ;
//}

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

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UITableViewCell *cell = (UITableViewCell *)sender;
    
    SAlarmContentViewController *viewController = (SAlarmContentViewController *)[segue destinationViewController];
    viewController.title = [cell.textLabel text];
    
    
    
}



@end
