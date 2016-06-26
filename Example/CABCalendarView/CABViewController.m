//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "CABViewController.h"

@interface CABViewController ()

/**
 *  The calendar object to use for the calendar view.
 */
@property (strong, nonatomic) NSCalendar *calendar;

/**
 *  The date formatter to use for displaying the currently selected month as text.
 */
@property (strong, nonatomic) NSDateFormatter *dateFormatterMonth;

/**
 *  The date formatter to use for displaying the currently selected date as text.
 */
@property (strong, nonatomic) NSDateFormatter *dateFormatterDay;

@end

@implementation CABViewController

- (void)viewDidLoad
{
    // Set selected date to today
    [self.calendarView setSelectedDate:[NSDate date] animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.calendar = nil;
}

#pragma mark - CABCalendarViewDataSource

- (NSCalendar *)calendar
{
    if (!_calendar) {
        _calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        _calendar.firstWeekday = 2;
    }
    
    return _calendar;
}

- (BOOL)calendarView:(CABCalendarView *)calendarView hasEventAtDate:(NSDate *)date
{
    // For example, there's events today, three days ago, and two days in the future
    return [self.calendar isDateInToday:date] || [self.calendar isDate:date inSameDayAsDate:[NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)-259200]] || [self.calendar isDate:date inSameDayAsDate:[NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)172800]];
}

- (NSCalendar *)calendarForCalendarView:(CABCalendarView *)calendarView
{
    return self.calendar;
}

- (NSDate *)startDateForCalendarView:(CABCalendarView *)calendarView
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = 2010;
    comps.month = 1;
    comps.day = 1;
    return [[self calendarForCalendarView:calendarView] dateFromComponents:comps];
}

- (NSDate *)endDateForCalendarView:(CABCalendarView *)calendarView
{
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    comps.year = 2060;
    comps.month = 1;
    comps.day = 1;
    return [[self calendarForCalendarView:calendarView] dateFromComponents:comps];
}

#pragma mark - CABCalendarViewDelegate
- (void) calendarView:(CABCalendarView *)calendarView didSelectDate:(NSDate *)date
{
    // Change the title in the navigation bar
    if (!self.dateFormatterMonth) {
        NSDateFormatter *dateFormatterMonth = [[NSDateFormatter alloc] init];
        [dateFormatterMonth setDateFormat:@"MMMM yyyy"];
        self.dateFormatterMonth = dateFormatterMonth;
    }
    self.navigationItem.title = [self.dateFormatterMonth stringFromDate:date];
    
    // Update the selectedDateLabel
    if (!self.dateFormatterDay) {
        NSDateFormatter *dateFormatterDay = [[NSDateFormatter alloc] init];
        [dateFormatterDay setDateFormat:@"EEEE d MMMM yyyy"];
        self.dateFormatterDay = dateFormatterDay;
    }
    self.selectedDateLabel.text = [self.dateFormatterDay stringFromDate:date];
    
}

@end
