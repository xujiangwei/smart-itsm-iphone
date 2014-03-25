/*
 * Calendar
 */

#import <UIKit/UIKit.h>

@class CalTileView;

@interface CalMonthView : UIView
{
    NSUInteger numWeeks;
    NSDateFormatter *tileAccessibilityFormatter;
}

@property (nonatomic) NSUInteger numWeeks;

- (id)initWithFrame:(CGRect)rect; // designated initializer
- (void)showDates:(NSArray *)mainDates leadingAdjacentDates:(NSArray *)leadingAdjacentDates trailingAdjacentDates:(NSArray *) trailingAdjacentDates minAvailableDate:(NSDate *)minAvailableDate maxAvailableDate:(NSDate *)maxAvailableDate;
- (CalTileView *)firstTileOfMonth;
- (CalTileView *)tileForDate:(NSDate *)date;
- (void)markTilesForDates:(NSArray *)dates;

@end
