//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

@class CABCalendarView;

@protocol CABCalendarViewDelegate <NSObject>

NS_ASSUME_NONNULL_BEGIN

#pragma mark - Optional methods
@optional

/**
 *  Tells the delegate that the specified date is now selected.
 *
 *  @param calendarView A calendar view object informing the delegate about the new date selection.
 *  @param date         The new selected date in calendarView.
 */
- (void)calendarView:(CABCalendarView *)calendarView didSelectDate:(NSDate *)date;

@end

NS_ASSUME_NONNULL_END