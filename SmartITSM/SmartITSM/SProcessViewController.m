//
//  SProcessViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-26.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#define kCellHeight 60

#import "SProcessViewController.h"
#import "SRelatedProcessCell.h"
#import "SProcessTemplate.h"

@interface SProcessViewController ()

@end

@implementation SProcessViewController

@synthesize relatedProcesses;
@synthesize relatedProcessListView;

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
	relatedProcessListView.dataSource = self;
    relatedProcessListView.delegate = self;
  
//    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:15];
    NSString *code =@"Change0003";
    NSString *summary = @"邮件服务器更新";
    SProcessTemplate *pt = [[SProcessTemplate alloc]init];
    [pt setCode:code];
    [pt setSummary:summary];
    [relatedProcesses addObject:pt];
 


}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kCellHeight;
}



#pragma makr - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [relatedProcesses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"SRelatedProcessCell";
    
    SRelatedProcessCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if(nil == cell)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
        
        cell = [nib objectAtIndex:0];
    }
    cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
    SProcessTemplate *pt= [relatedProcesses objectAtIndex:indexPath.row];
    cell.codeLabel.text = pt.code;
    cell.summaryLabel.text=pt.summary;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

//
//- (NSMutableArray * )initData
//{
//    NSMutableArray *array=[[NSMutableArray alloc]initWithCapacity:15];
//    NSString *code =@"Change0003";
//    NSString *summary = @"邮件服务器更新";
//    SProcessTemplate *pt = [[SProcessTemplate alloc]init];
//    [pt setCode:code];
//    [pt setSummary:summary];
//    [array addObject:pt];
//    
//    return array;
//    
//}

@end
