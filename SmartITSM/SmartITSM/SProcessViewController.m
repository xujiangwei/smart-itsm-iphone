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
  
    relatedProcesses=[self generateDemoData];
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

- (NSMutableArray *)generateDemoData
{
    NSMutableArray *ma=[[NSMutableArray alloc]initWithCapacity:15];
    SProcessTemplate *pt=[[SProcessTemplate alloc]init];
    [pt setCode:@"Change00037"];
    [pt setSummary:@"邮件服务器定于2014年3月12日进行扩容升级"];
    
    [ma addObject:pt];
    return  ma;

}

@end
