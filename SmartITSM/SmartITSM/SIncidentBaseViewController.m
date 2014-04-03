//
//  SIncidentContentViewController.m
//  SmartITSM
//
//  Created by dweng on 14-3-21.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//


#import "SIncidentBaseViewController.h"
#import "SIncidentDao.h"

@interface SIncidentBaseViewController ()

{
    NSArray  *fieldSetArray;
    
    NSDictionary *attributeDic;
    
    UITapGestureRecognizer *_tapGesture;
    
    NSString *content;
    
//    SIncidentContentListener *_listener;
//    
//    SIncidentContentFailureListener *_failureListener;
    
}
@end

@implementation SIncidentBaseViewController

@synthesize  incident;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
//        _listener = [[SIncidentContentListener alloc] init];
//        _listener.delegate = self;
//        
//        _failureListener = [[SIncidentContentFailureListener alloc] init];
//        _failureListener.failureDelegate = self;
        
        [self initData];
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self initData];
    
    content=@"（测试文本自适应高度）我的电脑是联想天逸F40M，最近出现个问题电脑在用的过程中自动关机就（像断电那种）有两次了，而且一关了机，在开机还开不了，得等一会才能开，我觉的是天气热散热不好的原因。请问这是怎么了，该怎么解决？这是属于正常现象，还是出现故障了呢？（测试文本自适应高度）我的电脑是联想天逸F40M，最近出现个问题电脑在用的过程中自动关机就（像断电那种）有两次了，而且一关了机，在开机还开不了，得等一会才能开，我觉的是天气热散热不好的原因。请问这是怎么了，该怎么解决？这是属于正常现象，还是出现故障了呢？";

    

//    [[MastEngine sharedSingleton] addListener:@"requestIncidentDetail" listener:_listener];
//    [[MastEngine sharedSingleton] addFailureListener:_failureListener];
   
//    [[MastEngine sharedSingleton] addListener:@"requestIncidentRelatedCis" listener:_listener];
//    [[MastEngine sharedSingleton] addFailureListener:_failureListener];
    
  
    if (nil == self._tableView)
    {
      
        self._tableView.delegate = self;
        self._tableView.dataSource = self;
        [self._tableView setBackgroundColor:[UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0]];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}


- (void)viewDidUnload
{
//    [[MastEngine sharedSingleton] removeListener:@"requestIncidentDetail" listener:_listener];
//    [[MastEngine sharedSingleton] removeFailureListener:_failureListener];
//    
//    [[MastEngine sharedSingleton] removeListener:@"requestIncidentRelatedCis" listener:_listener];
//    [[MastEngine sharedSingleton] removeFailureListener:_failureListener];
//    
//    [formVC viewDidUnload];
    [super viewDidUnload];
}


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
    cell.selectionStyle=UITableViewCellSelectionStyleNone;
    
    NSString * attribute=[attributes objectAtIndex:index];
    if([attribute isEqualToString:@"code"]){
        cell.textLabel.text=@"工单号";
        [cell.detailTextLabel setText:incident.code];
    }else if([attribute isEqualToString:@"state"]){
        cell.textLabel.text=@"状态";
        [cell.detailTextLabel setText:incident.state];
    }else if([attribute isEqualToString:@"summary"]){
        cell.textLabel.text=@"摘要";
        [cell.detailTextLabel setText: incident.summary];
    }else if([attribute isEqualToString:@"description"]){
        cell.textLabel.text=@"描述";
        cell.detailTextLabel.text=content;
        cell.detailTextLabel.lineBreakMode = NSLineBreakByWordWrapping;
        cell.detailTextLabel.numberOfLines = 0;
        cell.detailTextLabel.textAlignment=NSTextAlignmentLeft;
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        
    }else if([attribute isEqualToString:@"occurTime"]){
        cell.textLabel.text=@"发生时间";
        [cell.detailTextLabel setText: incident.occurTime];
    }else if([attribute isEqualToString:@"impact"]){
        cell.textLabel.text=@"影响程度";
        [cell.detailTextLabel setText: incident.impact];
    }else if([attribute isEqualToString:@"urgent"]){
        cell.textLabel.text=@"紧急程度";
        [cell.detailTextLabel setText:incident.urgent];
    }else if([attribute isEqualToString:@"propoity"]){
        cell.textLabel.text=@"优先级";
        [cell.detailTextLabel setText:incident.serviceLevel];
    }else if([attribute isEqualToString:@"applicant"]){
        cell.textLabel.text=@"申请人";
        [cell.detailTextLabel setText: incident.applicant];
    }else if([attribute isEqualToString:@"creator"]){
        cell.textLabel.text=@"创建人";
        [cell.detailTextLabel setText:incident.creator];
    }else if([attribute isEqualToString:@"contactName"]){
        cell.textLabel.text=@"联系人";
        [cell.detailTextLabel setText: incident.contact];
    }else if([attribute isEqualToString:@"mobile"]){
        cell.textLabel.text=@"手机";
         UILabel *mobile = [[UILabel alloc]initWithFrame:CGRectMake(110.0, 0.0, 200.0, 44.0)];
        [mobile setText:@"13811133726"];
        [mobile setTextColor:[UIColor colorWithRed:48.0/255.0 green:128.0/255.0 blue:192.0/255.0 alpha:1.0]];
        UIImage *phoneImg = [UIImage imageNamed:@"phone.png"];
        UIImageView *phoneView = [[UIImageView alloc] initWithFrame:CGRectMake(240,7, 30, 30)];
        [phoneView setImage:phoneImg];
        UIImage *smsImg = [UIImage imageNamed:@"sms.png"];
        UIImageView *smsView = [[UIImageView alloc] initWithFrame:CGRectMake(280,7, 30, 30)];
        [smsView setImage:smsImg];

        [cell.contentView addSubview:mobile];
        [cell.contentView addSubview:phoneView];
        [cell.contentView addSubview:smsView];
    }else if([attribute isEqualToString:@"phone"]){
        cell.textLabel.text=@"座机";
        UILabel *phone = [[UILabel alloc]initWithFrame:CGRectMake(110.0, 0.0, 200.0, 44.0)];
        [phone setText:@"010-62662110"];
        [phone setTextColor:[UIColor colorWithRed:48.0/255.0 green:128.0/255.0 blue:192.0/255.0 alpha:1.0]];
        UIImage *phoneImg = [UIImage imageNamed:@"phone.png"];
        UIImageView *phoneView = [[UIImageView alloc] initWithFrame:CGRectMake(270,7, 30, 30)];
        [phoneView setImage:phoneImg];
        [cell.contentView addSubview:phone];
        [cell.contentView addSubview:phoneView];
    }else if([attribute isEqualToString:@"email"]){
        cell.textLabel.text=@"邮箱";
        UILabel *email = [[UILabel alloc]initWithFrame:CGRectMake(70.0, 0.0, 200.0, 44.0)];
        [email setText:@"duanwenguo@dhcc.com.cn"];
        [email setTextColor:[UIColor colorWithRed:48.0/255.0 green:128.0/255.0 blue:192.0/255.0 alpha:1.0]];
        UIImage *emailImg = [UIImage imageNamed:@"email.png"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(270,7, 30, 30)];
        [imageView setImage:emailImg];
        [cell.contentView addSubview:email];
        [cell.contentView addSubview:imageView];
    }
    else if([attribute isEqualToString:@"category"]){
        cell.textLabel.text=@"事故类型";
        [cell.detailTextLabel setText:incident.category];
    }else if([attribute isEqualToString:@"reportWays"]){
        cell.textLabel.text=@"报告方式";
        [cell.detailTextLabel setText: incident.reportWays];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }else if([attribute isEqualToString:@"influencer"]){
        cell.textLabel.text=@"影响人";
        [cell.detailTextLabel setText: incident.influencer];
    }else if([attribute isEqualToString:@"isMajor"]){
        cell.textLabel.text=@"是否重大故障";
        UISwitch *switchview = [[UISwitch alloc] initWithFrame:CGRectZero];
        [switchview setOn:NO];
        cell.accessoryView = switchview;
    }else if([attribute isEqualToString:@"cis"]){
        cell.textLabel.text=@"影响配置项";
        if([incident.ciSet count]>0){
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d项",[incident.ciSet count]]];
    }
//    else if([attribute isEqualToString:@"tickets"]){
//        cell.textLabel.text=@"关联工单";
//        if([incident.assocatesBpSet count]>0){
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d项",[incident.assocatesBpSet count]]];
//    }else if([attribute isEqualToString:@"attachments"]){
//        cell.textLabel.text=@"附件";
//    }else if([attribute isEqualToString:@"logs"]){
//        cell.textLabel.text=@"处理日志";
//        if([incident.logSet count]>0){
//            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//        }
//        [cell.detailTextLabel setText:[NSString stringWithFormat:@"%d项",[incident.logSet count]]];
//    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //这个方法用来告诉表格第section分组的名称
    
    NSString *key = [fieldSetArray objectAtIndex:section];
    return key;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//    Theme *theme = [ThemeManager sharedSingleton].theme;
    UILabel *label=[[UILabel alloc] init];
    label.frame=CGRectMake(10, 0, 300, 30);
    label.backgroundColor=[UIColor clearColor];
    [label setTextColor:[UIColor colorWithRed:48.0/255.0 green:128.0/255.0 blue:192.0/255.0 alpha:1.0]];
    label.font=[UIFont systemFontOfSize:16];
    if(section==3 ){
        label.text=nil;
        
    }else{
        label.text=[fieldSetArray objectAtIndex:section];
    }
    UIView *sectionView=[[UIView alloc] initWithFrame:CGRectMake(10, 0, tableView.bounds.size.width, 30)];
    
    [sectionView addSubview:label];
    return sectionView;
    
}


// 设置cell的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 3) {
        
        UIFont *cellFont = [UIFont systemFontOfSize:14];
        CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
        CGSize labelSize = [content sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:NSLineBreakByWordWrapping];
        
        return labelSize.height + 20;
    } else {
        return 44;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark -delegate
-(void)updateSelectCell:(UITableViewCell *)cell selectedValue:(NSString *)value
{
    [cell.detailTextLabel setText:value];
}




//设置当前任务的可操作列表
-(void) setTaskOperation:(NSArray *)operation{
    
}


#pragma mark -SIncidentContentDelegate
-(void) didTaskProcess:(NSString *)operationCode
{
    
//    formVC=[[SIncidentFormViewController alloc]init];
//    formVC.delegate=self;
//    
//    if([operationCode isEqualToString:@"受理"]){
//        formVC.processVC.title=@"故障受理";
//        formVC.processVC.processTag=@"ACCEPT";
//        [incident setJbpmTransition:@"受理"];
//    }else if([operationCode isEqualToString:@"转派一线"]){
//        formVC.processVC.title=@"转派一线";
//        formVC.processVC.processTag =@"ASSIGN";
//        [incident setJbpmTransition:@"转派一线"];
//    }else if([operationCode isEqualToString:@"转派二线"]){
//        formVC.processVC.title=@"转派二线";
//        formVC.processVC.processTag =@"ASSIGN";
//        [incident setJbpmTransition:@"转派二线"];
//    }else if([operationCode isEqualToString:@"退回"]){
//        formVC.processVC.title=@"故障退回";
//        formVC.processVC.processTag =@"RETURN";
//        [incident setJbpmTransition:@"退回"];
//    }else if([operationCode isEqualToString:@"解决"]){
//        formVC.processVC.title=@"故障解决";
//        formVC.processVC.processTag =@"SOLVE";
//        [incident setJbpmTransition:@"解决"];
//    }else if([operationCode isEqualToString:@"回访"]){
//        formVC.processVC.title=@"故障回访";
//        formVC.processVC.processTag =@"FEEDBACK";
//        [incident setJbpmTransition:@"回访"];
//    }else if([operationCode isEqualToString:@"关闭"]){
//        formVC.processVC.title=@"故障关闭";
//        formVC.processVC.processTag =@"CLOSE";
//        [incident setJbpmTransition:@"关闭"];
//    }else if([operationCode isEqualToString:@"评价"]){
//        formVC.processVC.title=@"故障评价";
//        formVC.processVC.processTag =@"EVALUATE";
//        [incident setJbpmTransition:@"评价"];
//    }
//    formVC.processVC.incident=incident;
//    
//    [StackControllerHelper swapViewController:formVC];
}



-(void)initData
{
    fieldSetArray =[NSArray arrayWithObjects:@"基本信息",@"联系人",@"优先级",@"报告源",@"影响配置项", nil];
    NSArray  *basicInfo=[[NSArray alloc]initWithObjects:@"code",@"state",@"summary",@"description",@"creator",@"category",@"occurTime", nil];
    NSArray  *source   =[[NSArray alloc] initWithObjects:@"applicant",@"reportWays",@"influencer", nil];
    NSArray  *priority =[[NSArray alloc] initWithObjects:@"impact",@"urgent",@"propoity", @"isMajor",nil];
    NSArray  *cis  =[[NSArray alloc] initWithObjects:@"cis",nil];
    NSArray  *contact= [[NSArray alloc]initWithObjects:@"contactName",@"mobile" ,@"phone",@"email",nil];
//    NSArray  *relatedTickets  =[[NSArray alloc] initWithObjects:@"tickets",nil];
//    NSArray  *attachments  =[[NSArray alloc] initWithObjects:@"attachments",nil];
//    NSArray  *logs  =[[NSArray alloc] initWithObjects:@"logs",nil];
    
    attributeDic=[[NSMutableDictionary alloc] initWithObjectsAndKeys:basicInfo,[fieldSetArray objectAtIndex:0],
                  contact   ,[fieldSetArray objectAtIndex:1],
                  priority ,[fieldSetArray objectAtIndex:2],
                  source,[fieldSetArray objectAtIndex:3],
                  cis    ,[fieldSetArray objectAtIndex:4],
//                  relatedTickets ,[fieldSetArray objectAtIndex:4],
//                  attachments,[fieldSetArray objectAtIndex:5],
//                  logs ,[fieldSetArray objectAtIndex:6],
                  Nil];
}


#pragma mark -  SSigninVListenerDelegate
-(void) didRequestIncidentDetail:detailDic
{
    if ([detailDic objectForKey:@"success"]) {
        NSMutableArray  *detailInfo= [detailDic objectForKey:@"root"];
        NSMutableArray  *ciSetInfo;
        NSMutableArray  *bizSystemSetInfo;
        NSMutableArray  *associatesBpInfo;
        NSMutableArray  *logSetInfo;
        NSMutableArray  *transitionInfo;
        for (NSDictionary *attriDic in detailInfo) {
            ciSetInfo=  [attriDic objectForKey:@"ciSetInfo"];
            bizSystemSetInfo=[attriDic objectForKey:@"bizSystemSetInfo"];
            associatesBpInfo=[attriDic objectForKey:@"associatesBpInfo"];
            logSetInfo=[attriDic objectForKey:@"logSetInfo"];
            transitionInfo=[attriDic objectForKey:@"transitions"];
        }
        SIncident *tmpIncident = [[SIncident alloc]init];
        
        if([detailInfo objectAtIndex:0]==[NSNull null]){
            tmpIncident=[SIncidentDao getIncidentDetailWithId:incident.incidentId];
        }else{
            for (NSDictionary *attriDic in detailInfo) {
                [tmpIncident setIncidentId:[attriDic objectForKey:@"id"]];
                [tmpIncident setCode:[attriDic objectForKey:@"code"]];
                [tmpIncident setState:[[attriDic objectForKey:@"state"]  objectForKey:@"name"]];
                [tmpIncident setOccurTime:[attriDic objectForKey:@"createdOn"]];
                [tmpIncident setDescription:[attriDic objectForKey:@"description"]];
                
                NSString *reportWay =[attriDic objectForKey:@"reportWays"];
                [tmpIncident setReportWays:[SIncidentDao getIncidentReportWay:[reportWay integerValue]]];
                
                [tmpIncident setSummary:[attriDic objectForKey:@"summary"]];
                [tmpIncident setApplicant:[[attriDic objectForKey:@"applicant"]objectForKey:@"xingMing"]];
                [tmpIncident setCategory:[[attriDic objectForKey:@"category"]objectForKey:@"name"]];
                [tmpIncident setContact:[[attriDic objectForKey:@"contactId"]objectForKey:@"xingMing" ]];
                
                [tmpIncident setCreator:[[attriDic objectForKey:@"creator"]objectForKey:@"xingMing" ]];
                [tmpIncident setInfluencer:[[attriDic objectForKey:@"influencer"]objectForKey:@"xingMing" ]];
                [tmpIncident setImpact:[[attriDic objectForKey:@"impact"]objectForKey:@"symbol" ]];
                [tmpIncident setServiceLevel:[[attriDic objectForKey:@"serviceLevel"]objectForKey:@"symbol" ]];
                [tmpIncident setUrgent:[[attriDic objectForKey:@"urgent"]objectForKey:@"symbol" ]];
                
                tmpIncident.ciSet=ciSetInfo;
                tmpIncident.bizSystemSet=bizSystemSetInfo;
                tmpIncident.logSet=logSetInfo;
                tmpIncident.assocatesBpSet=associatesBpInfo;
            }
        }
        incident=tmpIncident;
        dispatch_async(dispatch_get_main_queue(), ^{
            NSArray *operationArray=[self getOperationArray:transitionInfo];
            [self setTaskOperation:operationArray];
            
//            [HUD removeFromSuperview];
            [self._tableView reloadData];
        });
    }else{
//        [HUD removeFromSuperview];
    }
}


- (NSArray *) getOperationArray:(NSMutableArray *)transitionInfo
{
    NSMutableArray *transitionArray=[[NSMutableArray alloc]init];
    for(NSDictionary *transitionDic in transitionInfo){
        [transitionArray addObject:[transitionDic objectForKey:@"operationName"]];
    }
    return transitionArray;
}


-(NSArray *)getCiInfo: (NSMutableArray *)ciSetInfo{
    NSMutableArray *ciArray=[[NSMutableArray alloc]init];
    for(NSDictionary *ciDir in ciSetInfo){
        [ciArray addObject:[ciDir objectForKey:@"name"]];
    }
    return ciArray;
}


-(NSArray *)getBizSystemInfo: (NSMutableArray *)bizSystemInfo{
    NSMutableArray *bizSystemArray=[[NSMutableArray alloc]init];
    for(NSDictionary *bizSystemDic in bizSystemArray){
        [bizSystemArray addObject:[bizSystemDic objectForKey:@"name"]];
    }
    return bizSystemArray;
}


-(NSArray *)getBpInfo: (NSMutableArray *)assocatesBpInfo{
    NSMutableArray *bpArray=[[NSMutableArray alloc]init];
    for(NSDictionary *bpDir in assocatesBpInfo){
        [bpArray addObject:[bpDir objectForKey:@"code"]];
    }
    return bpArray;
}

-(NSArray *)getLogInfo: (NSMutableArray *)logInfo{
    NSMutableArray *logArray=[[NSMutableArray alloc]init];
    
    return logArray;
}
//
//#pragma mark -
//- (void)failed:(CCTalkServiceFailure *)failure
//{
//    [iConsole error:@"%@",failure.description ];
//}





@end
