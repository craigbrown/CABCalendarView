//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CABCalendarWeekTableViewCell : UITableViewCell

/**
 *  An array containing the individual day buttons in this cell, indexed from earliest to latest day.
 */
@property (strong, nonatomic) NSArray *dayButtons;

@end

NS_ASSUME_NONNULL_END