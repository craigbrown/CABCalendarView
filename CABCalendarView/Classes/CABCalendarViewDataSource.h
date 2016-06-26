//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

@class CABCalendarView;

@protocol CABCalendarViewDataSource <NSObject>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Optional methods
@optional

/**
 *  Asks the data source whether there is an event at the date specified.
 *
 *  @param calendarView A calendar view object which will display the event indicator.
 *  @param date         The date at which the calendar-view is asking whether an event occurs.
 *
 *  @return Returns YES if the calendar-view should display an event at the specified date, otherwise NO.
 */
- (BOOL)calendarView:(CABCalendarView *)calendarView hasEventAtDate:(NSDate *)date;

#pragma mark - Required methods
@required

/**
 *  Asks the data source to provide the NSCalendar object to use for this calendar view.
 *
 *  @param calendarView A calendar view object requesting the calendar object it should use.
 *
 *  @return Returns the calendar object to be used by the calender view.
 */
- (NSCalendar *)calendarForCalendarView:(CABCalendarView *)calendarView;

/**
 *  Asks the data source for a date in the earliest month that the calendar-view should display.
 *
 *  @param calendarView A calendar-view object requesting a date in the month at which it should start.
 *
 *  @return A date in the earliest month that the calendar-view should display.
 */
- (NSDate *)startDateForCalendarView:(CABCalendarView *)calendarView;

/**
 *  Asks the data source for a date in the latest month that the calendar-view should display.
 *
 *  @param calendarView A calendar-view object requesting a date in the month at which it should end.
 *
 *  @return A date in the latest month that the calendar-view should display.
 */
- (NSDate *)endDateForCalendarView:(CABCalendarView *)calendarView;

@end

NS_ASSUME_NONNULL_END
