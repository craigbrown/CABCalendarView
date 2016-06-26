//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>
#import "CABCalendarViewDataSource.h"
#import "CABCalendarViewDelegate.h"

NS_ASSUME_NONNULL_BEGIN

/**
 *  An interface for a scrollable calendar. Requires a CABCalendarViewDelegate in order to display calendar and event information. Nothing will display until the reloadData method is called. Only the Gregorian calendar is supported. Other calendars can be used, but behaviour may not be as expected.
 */
IB_DESIGNABLE
@interface CABCalendarView : UIView <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

/**
 *  Delegate object that conforms to the CABCalendarViewDataSource protocol.
 */
@property (nullable, weak, nonatomic) IBOutlet id<CABCalendarViewDataSource> dataSource;

/**
 *  Delegate object that conforms to the CABCalendarViewDelegate protocol.
 */
@property (nullable, weak, nonatomic) IBOutlet id<CABCalendarViewDelegate> delegate;

/**
 *  The currently selected date.
 */
@property (strong, nonatomic, readonly) NSDate *selectedDate;

/**
 *  The height of each row of dates in the calendar view.
 */
@property (nonatomic) IBInspectable CGFloat rowHeight;

/**
 *  Call this method to reload all the data that is used to construct the calendar.
 */
- (void)reloadData;

/**
 *  Sets the currently selected date, and optionally animates the change.
 *
 *  @param selectedDate The new date to be selected.
 *  @param animated     YES if the change should be animated, NO otherwise.
 */
- (void)setSelectedDate:(NSDate *)selectedDate animated:(BOOL)animated;

@end

NS_ASSUME_NONNULL_END