/*
 * Calendar
 */

#import <UIKit/UIKit.h>

typedef enum {
    CalSelectionModeSingle = 0,
    CalSelectionModeRange,
} CalSelectionMode;

@class CalTileView, CalMonthView, CalLogic;
@protocol CalViewDelegate;

/*
 *    CalGridView
 *    ------------------
 *
 *    Private interface
 *
 *  As a client of the Cal system you should not need to use this class directly
 *  (it is managed by CalView).
 *
 */
@interface CalGridView : UIView
{
    id<CalViewDelegate> delegate;  // Assigned.
    CalLogic *logic;
    CalMonthView *frontMonthView;
    CalMonthView *backMonthView;
}

@property (nonatomic, assign) BOOL transitioning;
@property (nonatomic, assign) CalSelectionMode selectionMode;
@property (nonatomic, strong) NSDate *minAvailableDate;
@property (nonatomic, strong) NSDate *maxAVailableDate;
@property (nonatomic, strong) NSDate *beginDate;
@property (nonatomic, strong) NSDate *endDate;

- (id)initWithFrame:(CGRect)frame logic:(CalLogic *)logic delegate:(id<CalViewDelegate>)delegate;
- (void)markTilesForDates:(NSArray *)dates;

// These 3 methods should be called *after* the CalLogic
// has moved to the previous or following month.
- (void)slideUp;
- (void)slideDown;
- (void)jumpToSelectedMonth;    // see comment on CalView

@end
