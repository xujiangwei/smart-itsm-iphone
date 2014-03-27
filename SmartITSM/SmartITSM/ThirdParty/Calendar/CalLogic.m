/*
 * Calendar
 */

#import "CalPrefix.h"
#import "CalLogic.h"
#import "CalPrivate.h"

@interface CalLogic ()
- (void)moveToMonthForDate:(NSDate *)date;
- (void)recalculateVisibleDays;
- (NSUInteger)numberOfDaysInPreviousPartialWeek;
- (NSUInteger)numberOfDaysInFollowingPartialWeek;

@property (nonatomic, strong) NSDate *fromDate;
@property (nonatomic, strong) NSDate *toDate;
@property (nonatomic, strong) NSArray *daysInSelectedMonth;
@property (nonatomic, strong) NSArray *daysInFinalWeekOfPreviousMonth;
@property (nonatomic, strong) NSArray *daysInFirstWeekOfFollowingMonth;

@end

@implementation CalLogic

@synthesize baseDate, fromDate, toDate, daysInSelectedMonth, daysInFinalWeekOfPreviousMonth, daysInFirstWeekOfFollowingMonth;

+ (NSSet *)keyPathsForValuesAffectingSelectedMonthNameAndYear
{
    return [NSSet setWithObjects:@"baseDate", nil];
}

- (id)initForDate:(NSDate *)date
{
    if ((self = [super init]))
    {
        monthAndYearFormatter = [[NSDateFormatter alloc] init];
        [monthAndYearFormatter setDateFormat:NSLocalizedString(@"CalendarTitle", @"")];
        [self moveToMonthForDate:date];
    }
    return self;
}

- (id)init
{
    return [self initForDate:[NSDate date]];
}

- (void)moveToMonthForDate:(NSDate *)date
{
    self.baseDate = [date dateByMovingToFirstDayOfTheMonth];
    [self recalculateVisibleDays];
}

- (void)retreatToPreviousMonth
{
    [self moveToMonthForDate:[self.baseDate dateByMovingToFirstDayOfThePreviousMonth]];
}

- (void)advanceToFollowingMonth
{
    [self moveToMonthForDate:[self.baseDate dateByMovingToFirstDayOfTheFollowingMonth]];
}

- (NSString *)selectedMonthNameAndYear;
{
    return [monthAndYearFormatter stringFromDate:self.baseDate];
}

#pragma mark Low-level implementation details

- (NSUInteger)numberOfDaysInPreviousPartialWeek
{
    int num = [self.baseDate weekday] - 1;
    if (num == 0)
        num = 7;
    return num;
}

- (NSUInteger)numberOfDaysInFollowingPartialWeek
{
    NSDateComponents *c = [self.baseDate componentsForMonthDayAndYear];
    c.day = [self.baseDate numberOfDaysInMonth];
    NSDate *lastDayOfTheMonth = [[NSCalendar currentCalendar] dateFromComponents:c];
    int num = 7 - [lastDayOfTheMonth weekday];
    if (num == 0)
        num = 7;
    return num;
}

- (NSArray *)calculateDaysInFinalWeekOfPreviousMonth
{
    NSMutableArray *days = [NSMutableArray array];

    NSDate *beginningOfPreviousMonth = [self.baseDate dateByMovingToFirstDayOfThePreviousMonth];
    int n = [beginningOfPreviousMonth numberOfDaysInMonth];
    int numPartialDays = [self numberOfDaysInPreviousPartialWeek];
    NSDateComponents *c = [beginningOfPreviousMonth componentsForMonthDayAndYear];
    for (int i = n - (numPartialDays - 1); i < n + 1; i++)
    {
        [days addObject:[NSDate dateForDay:i month:c.month year:c.year]];
    }

    return days;
}

- (NSArray *)calculateDaysInSelectedMonth
{
    NSMutableArray *days = [NSMutableArray array];

    NSUInteger numDays = [self.baseDate numberOfDaysInMonth];
    NSDateComponents *c = [self.baseDate componentsForMonthDayAndYear];
    for (int i = 1; i < numDays + 1; i++)
    {
        [days addObject:[NSDate dateForDay:i month:c.month year:c.year]];
    }

    return days;
}

- (NSArray *)calculateDaysInFirstWeekOfFollowingMonth
{
    NSMutableArray *days = [NSMutableArray array];

    NSDateComponents *c = [[self.baseDate dateByMovingToFirstDayOfTheFollowingMonth] componentsForMonthDayAndYear];
    NSUInteger numPartialDays = [self numberOfDaysInFollowingPartialWeek];

    for (int i = 1; i < numPartialDays + 1; i++)
    {
        [days addObject:[NSDate dateForDay:i month:c.month year:c.year]];
    }

    return days;
}

- (void)recalculateVisibleDays
{
    self.daysInSelectedMonth = [self calculateDaysInSelectedMonth];
    self.daysInFinalWeekOfPreviousMonth = [self calculateDaysInFinalWeekOfPreviousMonth];
    self.daysInFirstWeekOfFollowingMonth = [self calculateDaysInFirstWeekOfFollowingMonth];
    NSDate *from = [self.daysInFinalWeekOfPreviousMonth count] > 0 ? [self.daysInFinalWeekOfPreviousMonth objectAtIndex:0] : [self.daysInSelectedMonth objectAtIndex:0];
    NSDate *to = [self.daysInFirstWeekOfFollowingMonth count] > 0 ? [self.daysInFirstWeekOfFollowingMonth lastObject] : [self.daysInSelectedMonth lastObject];
    self.fromDate = [from dateByMovingToBeginningOfDay];
    self.toDate = [to dateByMovingToEndOfDay];
}

@end
