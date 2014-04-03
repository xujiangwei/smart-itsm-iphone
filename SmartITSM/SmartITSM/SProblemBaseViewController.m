//
//  SProblemBaseViewController.m
//  SmartITSM
//
//  Created by dweng on 14-4-1.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SProblemBaseViewController.h"
#define originalHeight 44.0f
#define isOpen @"120.0f"

@interface SProblemBaseViewController ()

@end

@implementation SProblemBaseViewController
{
    NSMutableDictionary *dicClicked;
    NSInteger count;
}

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
    count = 0;
    dicClicked = [NSMutableDictionary dictionaryWithCapacity:3];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *contentIndentifer = @"Container";
    if (indexPath.row == 0) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:contentIndentifer];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:contentIndentifer];
        }
        NSString *statisticsContent = @"岁月流芳，花开几度，走在岁月里，醉在流香里，总在时光里辗转徘徊。花开几许，落花几度，岁月寒香，飘进谁的诗行，一抹幽香，掺入几许愁伤，流年似花，春来秋往，睁开迷离的双眼，回首张望，随风的尘烟荡漾着迷忙，昨日的光阴已逝去，留下无尽的回忆让人留恋与追忆";
        cell.textLabel.font = [UIFont systemFontOfSize:12.0f];
        cell.textLabel.text = statisticsContent;
        cell.textLabel.textColor = [UIColor brownColor]
        ;
        cell.textLabel.opaque = NO; // 选中Opaque表示视图后面的任何内容都不应该绘制
        cell.textLabel.numberOfLines = 0;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    //    cell.imageView.image = [UIImage imageNamed:@"email.png"];
    //    cell.textLabel.text = [NSString stringWithFormat:@"%d",count];
    count++;
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        UITableViewCell *targetCell = [tableView cellForRowAtIndexPath:indexPath];
        if (targetCell.frame.size.height == originalHeight){
            [dicClicked setObject:isOpen forKey:indexPath];
        }
        else{
            [dicClicked removeObjectForKey:indexPath];
        }
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    NSLog(@"indexPath=%@",indexPath);
    NSLog(@"dicClicked=%@",dicClicked);
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        if ([[dicClicked objectForKey:indexPath] isEqualToString: isOpen])
            return [[dicClicked objectForKey:indexPath] floatValue];
        else
            return originalHeight;
    }
    else {
        return 45.0f;
    }
}

@end