//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 A view to display the days of the week above a CABCalendarView. This class intentionally offers a very limited scope for customization; developers who have more complex requirements may wish to create their own header view.
 */
IB_DESIGNABLE
@interface CABCalendarHeaderView : UIView

/**
 *  The weekday represented by the first day in the row. 1 for Sunday, 2 for Monday, etc.
 */
@property (nonatomic) IBInspectable NSUInteger firstWeekday;

/**
 *  Initializes and returns a newly allocated calendarHeaderView object with the specified frame rectangle and firstWeekday property.
 *
 *  @param frame        The frame rectangle for the calendarHeaderView.
 *  @param firstWeekday The weekday represented by the first day in the row. 1 for Sunday, 2 for Monday, etc.
 *
 *  @return An initialized calendarHeaderView object.
 */
- (instancetype)initWithFrame:(CGRect)frame firstWeekday:(NSUInteger)firstWeekday;

/**
 *  Updates each label with the short weekday name. Call this after changing the firstWeekday property.
 */
- (void)updateLabels;

@end

NS_ASSUME_NONNULL_END