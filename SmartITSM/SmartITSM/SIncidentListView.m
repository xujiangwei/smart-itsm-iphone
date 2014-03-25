//
//  SIncidentListView.m
//  SmartITOM
//


#import "SIncidentListView.h"


@implementation SIncidentListView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self build];
    }
    return self;
    
}

- (id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self build];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self build];
    }
    return self;
}

- (void)build
{
}



@end
