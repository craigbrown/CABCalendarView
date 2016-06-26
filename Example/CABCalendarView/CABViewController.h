//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

@import UIKit;
@import CABCalendarView;

@interface CABViewController : UIViewController <CABCalendarViewDataSource, CABCalendarViewDelegate>

/**
 *  The calendar view managed by the controller object.
 */
@property (weak, nonatomic) IBOutlet CABCalendarView *calendarView;

/**
 *  Header view displaying names of the days of the week.
 */
@property (weak, nonatomic) IBOutlet CABCalendarHeaderView *headerView;

/**
 *  Label to display the currently selected date as text.
 */
@property (weak, nonatomic) IBOutlet UILabel *selectedDateLabel;

@end
