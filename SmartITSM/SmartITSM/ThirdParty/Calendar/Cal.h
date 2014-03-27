
/*
 *    The Cal UI component
 *    ------------------------
 *
 *  The Cal system aims to mimic the month view in Apple's mobile calendar app.
 *  When the user taps a date on the calendar, any associated events for that date
 *  will be displayed in a table view directly below the calendar. As a client
 *  of this component, your only responibility is to provide the events for each date
 *  by providing an implementation of the CalDataSource protocol.
 *
 *  EXAMPLE USAGE
 *  -------------
 *  Note: All of the following example code assumes that it is being called from
 *  within another UIViewController which is in a UINavigationController hierarchy.
 *
 *  How to display a very basic calendar (without any events):
 *
 *      CalViewController *calendar = [[[CalViewController alloc] init] autorelease];
 *      [self.navigationController pushViewController:calendar animated:YES];
 *
 *  In most cases you will have some custom data that you want to attach
 *  to the dates on the calendar. Assuming that your implementation of the
 *  CalDataSource protocol is provided by "MyCalDataSource", then all you
 *  need to do to display your annotated calendar is the following:
 *
 *      id<CalDataSource> source = [[[MyCalDataSource alloc] init] autorelease];
 *      CalViewController *calendar = [[[CalViewController alloc] initWithDataSource:source] autorelease];
 *      [self.navigationController pushViewController:calendar animated:YES];
 *
 *  Note that "MyCalDataSource" will tell the system which days to mark with a
 *  dot and will provide the UITableViewCells that display the details for
 *  the currently selected date.
 *
 */

#import "CalViewController.h"
#import "CalDataSource.h"

// The CalDataSource implementation should post this notification
// whenever its content has changed. Cal uses this notification to
// keep the UI in sync with the data source.
extern NSString *const CalDataSourceChangedNotification;
