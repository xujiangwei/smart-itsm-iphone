/* 
 * Calendar
 */

#import <Foundation/Foundation.h>

@interface NSDate (CalAdditions)

// All of the following methods use [NSCalendar currentCalendar] to perform
// their calculations.

- (NSDate *)dateByMovingToBeginningOfDay;
- (NSDate *)dateByMovingToEndOfDay;
- (NSDate *)dateByMovingToFirstDayOfTheMonth;
- (NSDate *)dateByMovingToFirstDayOfThePreviousMonth;
- (NSDate *)dateByMovingToFirstDayOfTheFollowingMonth;
- (NSDateComponents *)componentsForMonthDayAndYear;
- (NSUInteger)weekday;
- (NSUInteger)numberOfDaysInMonth;

@end