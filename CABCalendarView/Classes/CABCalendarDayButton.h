//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CABCalendarDayButton : UIControl

/**
 *  The date which is represented by the button.
 */
@property (nullable, strong, nonatomic) NSDate *date;

/**
 *  The label used to display the day number.
 */
@property (strong, nonatomic) UILabel *titleLabel;

/**
 *  Whether the control appears to be enabled. The button is still able to be pressed when set to false.
 */
@property (nonatomic) BOOL appearsEnabled;

/**
 *  Whether the button represents today.
 */
@property (nonatomic) BOOL isToday;

/**
 *  Whether the event marker should be shown.
 */
@property (nonatomic) BOOL showEventMarker;

@end

NS_ASSUME_NONNULL_END