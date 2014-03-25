/*
 * Calendar
 */

#import <UIKit/UIKit.h>
#import "CalGridView.h"

@class CalLogic;
@protocol CalViewDelegate, CalDataSourceCallbacks;

/*
 *    CalView
 *    ------------------
 *
 *    Private interface
 *
 *  As a client of the Cal system you should not need to use this class directly
 *  (it is managed by CalViewController).
 *
 *  CalViewController uses CalView as its view.
 *  CalView defines a view hierarchy that looks like the following:
 *
 *       +-----------------------------------------+
 *       |                header view              |
 *       +-----------------------------------------+
 *       |                                         |
 *       |                                         |
 *       |                                         |
 *       |                 grid view               |
 *       |             (the calendar grid)         |
 *       |                                         |
 *       |                                         |
 *       +-----------------------------------------+
 *       |                                         |
 *       |           table view (events)           |
 *       |                                         |
 *       +-----------------------------------------+
 *
 */
@interface CalView : UIView
{
    UILabel *headerTitleLabel;
    CalLogic *logic;
}

@property (nonatomic, weak) id<CalViewDelegate> delegate;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CalGridView *gridView;

- (id)initWithFrame:(CGRect)frame delegate:(id<CalViewDelegate>)delegate logic:(CalLogic *)logic;
- (BOOL)isSliding;
- (void)markTilesForDates:(NSArray *)dates;
- (void)redrawEntireMonth;

// These 3 methods are exposed for the delegate. They should be called 
// *after* the CalLogic has moved to the month specified by the user.
- (void)slideDown;
- (void)slideUp;
- (void)jumpToSelectedMonth;    // change months without animation (i.e. when directly switching to "Today")

@end

#pragma mark -

@protocol CalViewDelegate

@optional

- (void)showPreviousMonth;
- (void)showFollowingMonth;
- (void)didSelectDate:(NSDate *)date;
- (void)didSelectBeginDate:(NSDate *)beginDate endDate:(NSDate *)endDate;

@end
