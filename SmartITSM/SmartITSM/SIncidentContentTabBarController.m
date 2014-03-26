//
//  SIncidentContentTabBarController.m
//  SmartITSM
//
//  Created by dweng on 14-3-26.
//  Copyright (c) 2014年 Ambrose. All rights reserved.
//

#import "SIncidentContentTabBarController.h"
#import "SIncidentOperationPopoverController.h"
#import "UIBarButtonItem+WEPopover.h"

@interface SIncidentContentTabBarController ()

@end

@implementation SIncidentContentTabBarController

@synthesize popoverController;

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

    popoverClass = [WEPopoverController class];
    
    currentPopoverCellIndex = -1;

    
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(20,0,81,30)];
    
    [rightButton setTitle:@"操作" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    rightButton.titleLabel.font=[UIFont systemFontOfSize:14];
    [rightButton addTarget:self action:@selector(operation:)forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
    self.navigationItem.rightBarButtonItem= rightItem;
}



-(void)operation:(UIButton*)sender
{
    
    //    UIActionSheet *actionSheet = [[UIActionSheet alloc]
    //                                  initWithTitle:@""
    //                                  delegate:self
    //                                  cancelButtonTitle:@"取消"
    //                                  destructiveButtonTitle:@"解决"
    //                                  otherButtonTitles:@"分派二线",@"退出",nil];
    //    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    //    [actionSheet showInView:self.view];
    
    
	if (!self.popoverController) {
		
		UIViewController *contentViewController = [[SIncidentOperationPopoverController alloc] initWithStyle:UITableViewStylePlain];
		self.popoverController = [[popoverClass alloc] initWithContentViewController:contentViewController];
		self.popoverController.delegate = self;
		self.popoverController.passthroughViews = [NSArray arrayWithObject:self.navigationController.navigationBar];
		
		[self.popoverController presentPopoverFromBarButtonItem:self.navigationItem.rightBarButtonItem
									   permittedArrowDirections:(UIPopoverArrowDirectionUp|UIPopoverArrowDirectionDown)
													   animated:YES];
        
	} else {
		[self.popoverController dismissPopoverAnimated:YES];
		self.popoverController = nil;
	}
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark WEPopoverControllerDelegate implementation

- (void)popoverControllerDidDismissPopover:(WEPopoverController *)thePopoverController {
	//Safe to release the popover here
	self.popoverController = nil;
}

- (BOOL)popoverControllerShouldDismissPopover:(WEPopoverController *)thePopoverController {
	//The popover is automatically dismissed if you click outside it, unless you return NO here
	return YES;
}


@end
