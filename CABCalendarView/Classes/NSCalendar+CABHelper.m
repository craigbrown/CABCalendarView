//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "NSCalendar+CABHelper.h"

@implementation NSCalendar (CABHelper)

- (NSUInteger)fullCalendarWeeksInEraFromDate:(NSDate *)startDate ToDate:(NSDate *)endDate
{
    // Change times of dates to be 23:58:45 to workaround bug in ordinal week number
    NSDateComponents *startDateComps = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:startDate];
    NSDateComponents *endDateComps = [self components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:endDate];
    startDateComps.hour = 23;
    startDateComps.minute = 58;
    startDateComps.second = 45;
    endDateComps.hour = 23;
    endDateComps.minute = 58;
    endDateComps.second = 45;
    
    startDate = [self dateFromComponents:startDateComps];
    endDate = [self dateFromComponents:endDateComps];
    
    NSInteger startWeek = [self ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitEra forDate:startDate];
    NSInteger endWeek = [self ordinalityOfUnit:NSCalendarUnitWeekOfYear inUnit:NSCalendarUnitEra forDate:endDate];
    
    return endWeek - startWeek + 1;
    
}

- (NSDate *)firstOfMonthWithDate:(NSDate *)date
{
    NSCalendarUnit unitFlags = (NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth);
    NSDateComponents *comps = [self components:unitFlags fromDate:date];
    comps.day = 1;
    
    return [self dateFromComponents:comps];
}

- (NSDate *)firstOfNextMonthWithDate:(NSDate *)date
{
    NSCalendarUnit unitFlags = (NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth);
    NSDateComponents *comps = [self components:unitFlags fromDate:date];
    comps.month += 1;
    comps.day = 1;
    
    return [self dateFromComponents:comps];
}

- (NSDate *)firstOfPreviousMonthWithDate:(NSDate *)date
{
    NSCalendarUnit unitFlags = (NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth);
    NSDateComponents *comps = [self components:unitFlags fromDate:date];
    comps.month -= 1;
    comps.day = 1;
    
    return [self dateFromComponents:comps];
}

- (NSDate *)firstDayOfWeek:(NSUInteger)index afterDate:(NSDate *)date
{
    NSDateComponents *compsToAdd = [[NSDateComponents alloc] init];
    [compsToAdd setWeekOfMonth:index];
    
    NSDate *firstOfOriginalWeek = [self firstDayOfWeekWithDate:date];
    
    return [self dateByAddingComponents:compsToAdd toDate:firstOfOriginalWeek options:0];
}

#pragma mark - Private helper methods

/**
 *  Returns the date on the first day of the week which the specified date is in.
 *
 *  @param date A date in the week for which the first day is required.
 *
 *  @return The date on the first day of the week which the specified date is in.
 */
- (NSDate *)firstDayOfWeekWithDate:(NSDate *)date
{
    NSCalendarUnit unitFlags = (NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitWeekOfMonth);
    NSDateComponents *comps = [self components:unitFlags fromDate:date];
    [comps setWeekday:[self firstWeekday]];
    
    return [self dateFromComponents:comps];
}


@end
