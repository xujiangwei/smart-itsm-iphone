/*
 * Calendar
 */

#import <CoreGraphics/CoreGraphics.h>
#import "CalPrefix.h"
#import "CalMonthView.h"
#import "CalTileView.h"
#import "CalView.h"
#import "CalPrivate.h"

extern const CGSize kTileSize;

@implementation CalMonthView

@synthesize numWeeks;

- (id)initWithFrame:(CGRect)frame
{
    if ((self = [super initWithFrame:frame])) {
        tileAccessibilityFormatter = [[NSDateFormatter alloc] init];
        [tileAccessibilityFormatter setDateFormat:@"EEEE, MMMM d"];
        self.opaque = NO;
        self.clipsToBounds = YES;
        for (int i = 0; i < 6; i++)
        {
            for (int j = 0; j < 7; j++)
            {
                CGRect r = CGRectMake(j*kTileSize.width, i*kTileSize.height, kTileSize.width, kTileSize.height);
                [self addSubview:[[CalTileView alloc] initWithFrame:r]];
            }
        }
    }
    return self;
}

- (void)showDates:(NSArray *)mainDates leadingAdjacentDates:(NSArray *)leadingAdjacentDates trailingAdjacentDates:(NSArray *) trailingAdjacentDates minAvailableDate:(NSDate *)minAvailableDate maxAvailableDate:(NSDate *)maxAvailableDate
{
    int tileNum = 0;
    NSArray *dates[] = { leadingAdjacentDates, mainDates, trailingAdjacentDates };

    for (int i = 0; i < 3; i++)
    {
        for (int j = 0; j < dates[i].count; j++)
        {
            NSDate *d = dates[i][j];
            CalTileView *tile = [self.subviews objectAtIndex:tileNum];
            [tile resetState];
            tile.date = d;
            if ((minAvailableDate && [d compare:minAvailableDate] == NSOrderedAscending) || (maxAvailableDate && [d compare:maxAvailableDate] == NSOrderedDescending))
            {
                tile.type = CalTileTypeDisable;
            }
            if (i == 0 && j == 0)
            {
                tile.type |= CalTileTypeFirst;
            }
            if (i == 2 && j == dates[i].count-1)
            {
                tile.type |= CalTileTypeLast;
            }
            if (dates[i] != mainDates)
            {
                tile.type |= CalTileTypeAdjacent;
            }
            if ([d isToday])
            {
                tile.type |= CalTileTypeToday;
            }
            tileNum++;
        }
    }

    numWeeks = ceilf(tileNum / 7.f);
    [self sizeToFit];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextDrawTiledImage(ctx, (CGRect){CGPointZero,kTileSize}, [[UIImage imageNamed:@"Calendar.bundle/cal_tile.png"] CGImage]);
}

- (CalTileView *)firstTileOfMonth
{
    CalTileView *tile = nil;
    for (CalTileView *t in self.subviews)
    {
        if (!t.belongsToAdjacentMonth)
        {
            tile = t;
            break;
        }
    }
    
    return tile;
}

- (CalTileView *)tileForDate:(NSDate *)date
{
    CalTileView *tile = nil;
    for (CalTileView *t in self.subviews)
    {
        if ([t.date isEqualToDate:date])
        {
            tile = t;
            break;
        }
    }
    return tile;
}

- (void)sizeToFit
{
    self.height = 1.f + kTileSize.height * numWeeks;
}

- (void)markTilesForDates:(NSArray *)dates
{
    for (CalTileView *tile in self.subviews)
    {
        tile.marked = [dates containsObject:tile.date];
        NSString *dayString = [tileAccessibilityFormatter stringFromDate:tile.date];
        if (dayString)
        {
            NSMutableString *helperText = [[NSMutableString alloc] initWithCapacity:128];
            if ([tile.date isToday])
                [helperText appendFormat:@"%@ ", NSLocalizedString(@"Today", @"Accessibility text for a day tile that represents today")];
            [helperText appendString:dayString];
            if (tile.marked)
                [helperText appendFormat:@". %@", NSLocalizedString(@"Marked", @"Accessibility text for a day tile which is marked with a small dot")];
            [tile setAccessibilityLabel:helperText];
        }
    }
}

@end
