//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSCalendar (CABHelper)

/**
 *  Returns the number of calendar weeks between two dates, counting the weeks that
 *  those dates are in. For example, if startDate is the last day of a week, and endDate
 *  is the first day of the next week (i.e. a day later), this method returns 2. The
 *  dates must be within the same era.
 *
 *  @param startDate The earlier date.
 *  @param endDate   The later date.
 *
 *  @return The number of calendar weeks between startDate and endDate inclusive.
 */
- (NSUInteger)fullCalendarWeeksInEraFromDate:(NSDate *)startDate ToDate:(NSDate *)endDate;

/**
 *
 *
 *  @param date A date in the month required.
 *
 *  @return The first day of the month that the NSDate is in.
 */
- (NSDate *)firstOfMonthWithDate:(NSDate *)date;

/**
 *
 *
 *  @param date A date.
 *
 *  @return The first day of the month immediately after the month that the date is in.
 */
- (NSDate *)firstOfNextMonthWithDate:(NSDate *)date;

/**
 *
 *
 *  @param date A date.
 *
 *  @return The first day of the month immediately before the month that the NSDate is in.
 */
- (NSDate *)firstOfPreviousMonthWithDate:(NSDate *)date;

/**
 *  Returns the first day of a week that is a specified number of
 *  weeks after a certain date.
 *
 *  @param index Number of weeks after the specified date.
 *  @param date  A date.
 *
 *  @return The first day of a week that is a specified number of 
 *  weeks after a specified date.
 */
- (NSDate *)firstDayOfWeek:(NSUInteger)index afterDate:(NSDate *)date;



@end

NS_ASSUME_NONNULL_END