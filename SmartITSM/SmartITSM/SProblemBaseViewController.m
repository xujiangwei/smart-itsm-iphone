//
//  SProblemBaseViewController.m
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SProblemBaseViewController.h"

@interface SProblemBaseViewController ()
{
 
    NSArray  *fieldSetArray;
    
    NSDictionary *attributeDic;
}
@end

@implementation SProblemBaseViewController

@synthesize  problem;


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
     [self initData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [attributeDic count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSString * index=[fieldSetArray objectAtIndex:section];
    return  [[attributeDic objectForKey:index] count];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger section=indexPath.section;
    NSInteger index = indexPath.row;
    
    
     NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d%d", section, index];
    
    NSString *headTitle=[fieldSetArray objectAtIndex:section];
    NSArray *attributes=[attributeDic objectForKey:headTitle];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(nil==cell){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1  reuseIdentifier:CellIdentifier];
    }
    [cell setBackgroundColor:[UIColor colorWithRed:255.0/255.0 green:255.0/255.0 blue:255.0/255.0 alpha:1.0]];
    cell.textLabel.font=[UIFont systemFontOfSize:14];
    [cell.textLabel setTextColor:[UIColor colorWithRed:45.0/255.0 green:45.0/255.0 blue:45.0/255.0 alpha:1.0]];
    [cell.detailTextLabel setTextColor:[UIColor colorWithRed:48.0/255.0 green:128.0/255.0 blue:192.0/255.0 alpha:1.0]];
    
    NSString * attribute=[attributes objectAtIndex:index];
    if([attribute isEqualToString:@"code"]){
        cell.textLabel.text=@"工单号";
        [cell.detailTextLabel setText:problem.code];
    }else if([attribute isEqualToString:@"state"]){
        cell.textLabel.text=@"状态";
        [cell.detailTextLabel setText:problem.state];
    }else if([attribute isEqualToString:@"problemSource"]){
        cell.textLabel.text=@"问题来源";
        [cell.detailTextLabel setText: problem.problemSource];
    }else if([attribute isEqualToString:@"summary"]){
        cell.textLabel.text=@"摘要";
        [cell.detailTextLabel setText: problem.summary];
    }
    else if([attribute isEqualToString:@"description"]){
        cell.textLabel.text=@"描述";
        cell.detailTextLabel.numberOfLines=0;
        cell.detailTextLabel.textAlignment=NSTextAlignmentLeft;
        [cell.detailTextLabel setText: problem.description];
    }
    else if([attribute isEqualToString:@"occurTime"]){
        cell.textLabel.text=@"发现时间";
        [cell.detailTextLabel setText: problem.occurTime];
    }else if([attribute isEqualToString:@"findWay"]){
        cell.textLabel.text=@"发现方式";
        [cell.detailTextLabel setText: problem.findType];
    }else if([attribute isEqualToString:@"category"]){
        cell.textLabel.text=@"问题类型";
        [cell.detailTextLabel setText:problem.category];
    }else if([attribute isEqualToString:@"impact"]){
        cell.textLabel.text=@"影响程度";
        [cell.detailTextLabel setText: problem.impact];
    }else if([attribute isEqualToString:@"urgent"]){
        cell.textLabel.text=@"紧急程度";
        [cell.detailTextLabel setText:problem.urgent];
    }else if([attribute isEqualToString:@"propoity"]){
        cell.textLabel.text=@"优先级";
        [cell.detailTextLabel setText:problem.serviceLevel];
    }else if([attribute isEqualToString:@"applicant"]){
        cell.textLabel.text=@"申请人";
        [cell.detailTextLabel setText: problem.applicant];
    }else if([attribute isEqualToString:@"influencer"]){
        cell.textLabel.text=@"影响人";
        [cell.detailTextLabel setText: problem.influencer];
    }else if([attribute isEqualToString:@"cis"]){
        cell.textLabel.text=@"影响配置项";
        if([problem.ciSet count]>0){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell.detailTextLabel setText: [NSString stringWithFormat:@"%d项",[problem.ciSet count]]];
    }
    
    return cell;

}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *key = [fieldSetArray objectAtIndex:section];
    return key;
}


-(void)initData
{
    fieldSetArray =[NSArray arrayWithObjects:@"基本信息",@"用户信息",@"配置项信息", nil];
    NSArray  *basicInfo=[[NSArray alloc]initWithObjects:@"code",@"state",@"problemSource",@"summary",@"description",@"category",@"occurTime",@"findWay",@"impact",@"urgent",@"propoity", nil];
    NSArray  *userInfo   =[[NSArray alloc] initWithObjects:@"applicant",@"influencer", nil];
    NSArray  *ciInfo =[[NSArray alloc] initWithObjects:@"cis",nil];
  
    
    attributeDic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:basicInfo,[fieldSetArray objectAtIndex:0],
                  userInfo   ,[fieldSetArray objectAtIndex:1],
                  ciInfo ,[fieldSetArray objectAtIndex:2],
                 Nil];
}


@end