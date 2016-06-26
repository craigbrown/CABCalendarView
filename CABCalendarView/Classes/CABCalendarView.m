//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "CABCalendarView.h"
#import "NSCalendar+CABHelper.h"
#import "CABCalendarWeekTableViewCell.h"
#import "CABCalendarDayButton.h"

#pragma mark - Private properties
@interface CABCalendarView ()

/**
 *  The tableView used to display the calendar.
 */
@property (strong, nonatomic) UITableView *tableView;

/**
 *  Used to remember the content offset just before scrolling occurs.
 */
@property (nonatomic) CGPoint currentContentOffset;

/**
 *  The calendar object to use for displaying dates, as specified by the delegate.
 */
@property (strong, nonatomic) NSCalendar *calendar;

/**
 *  The first day of the month in which the calendar should start displaying dates, as specified by the delegate.
 */
@property (strong, nonatomic) NSDate *startDate;

/**
 *  The last day of the month in which the calendar should start displaying dates, as specified by the delegate.
 */
@property (strong, nonatomic) NSDate *endDate;

/**
 *  The currently selected date.
 */
@property (strong, nonatomic, readwrite) NSDate *selectedDate;

@end

@implementation CABCalendarView
{
    // Used to remember the date being scrolled to
    NSDate *_newDate;
}

#pragma mark - Initialization

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupDefaultValues];
        [self createTableView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupDefaultValues];
        [self createTableView];
    }
    return self;
}

- (void)setupDefaultValues
{
    self.rowHeight = 44;
}

- (void)createTableView
{
    // Create tableView object and add it as a subview
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    [self addSubview:tableView];
    self.tableView = tableView;
    
    // Set up the new tableView
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO; //disable selection
    tableView.scrollsToTop = NO; //disable tap status bar to scroll to top
    tableView.showsVerticalScrollIndicator = NO; // disable the scroll bar
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone; // turn off separators between cells
    tableView.translatesAutoresizingMaskIntoConstraints = NO; // turn off autoresizing mask so constraints work properly
    
    // Set up tableView constraints
    [tableView.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
    [tableView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
    [tableView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
    [tableView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
    
    // Set up the scroll view properties
    tableView.decelerationRate = UIScrollViewDecelerationRateFast; //ensures quick scrolling between months
}

#pragma mark - Overriding UIView methods

+ (BOOL)requiresConstraintBasedLayout
{
    return true;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    // Get properties from dataSource if set through IB
    [self reloadData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // turn off separators between cells - need to do this here, as it gets changed somehow after being set in createTableView
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

#pragma mark - Public methods

- (void)reloadData
{
    // Remove the properties we already have
    self.calendar = nil;
    self.startDate = nil;
    self.endDate = nil;
    
    // Get the properties again
    [self calendar];
    self.selectedDate = [[self startDate] copy];
    [self endDate];
    
    // Reload the tableView
    [self.tableView reloadData];
    
    // Scroll to selected cell
    [self scrollToFirstOfMonthWithDate:self.selectedDate animated:NO];
}

- (void)setSelectedDate:(NSDate *)selectedDate animated:(BOOL)animated
{
    NSDate *oldSelectedDate = _selectedDate;
    _selectedDate = [self.calendar startOfDayForDate:selectedDate]; //Always convert to midnight, we don't care about time
    
    // If selected new month, scroll to that month
    if (!oldSelectedDate || ![self.calendar isDate:selectedDate equalToDate:oldSelectedDate toUnitGranularity:NSCalendarUnitMonth]) {
        [self scrollToFirstOfMonthWithDate:selectedDate animated:animated];
    }
    
    // Reload the cells
    [self.tableView reloadData];
    
    // Notify the delegate
    if (self.delegate) {
        [self.delegate calendarView:self didSelectDate:selectedDate];
    }
}

#pragma mark - Custom setters

- (void)setRowHeight:(CGFloat)rowHeight
{
    _rowHeight = rowHeight;
    if (self.tableView) {
        self.tableView.rowHeight = rowHeight;
    }
    
}

- (void)setSelectedDate:(NSDate *)selectedDate
{
    [self setSelectedDate:selectedDate animated:NO];
}

#pragma mark - User interaction

/**
 *  Called when a CABCalendarDayButton is pressed.
 *
 *  @param button The button that was pressed.
 */
- (void)dayButtonPressed:(CABCalendarDayButton *)button
{
    [self setSelectedDate:[button.date copy] animated:YES];
}

#pragma mark - CABCalendarViewDataSource Helper

/**
 *  Asks the data source whether the specified date has an event and returns the answer, or returns false if no data source exists. The result is cached to prevent multiple calls to the data source; call reloadData to clear this cache.
 *
 *  @param date The date at which the calendar-view is asking whether an event occurs.
 *
 *  @return The value returned by the data source, or false if no data source exists.
 */
- (BOOL)hasEventAtDate:(NSDate *)date
{
    id<CABCalendarViewDataSource> dataSource = self.dataSource;
    if (dataSource && [dataSource respondsToSelector:@selector(calendarView:hasEventAtDate:)]) {
            return [dataSource calendarView:self hasEventAtDate:date];
        }
    return false;
}

/**
 *  Asks the data source for the calendar object to use and returns this object, or returns a new Gregorian calendar if no data source exists. The result is cached to prevent multiple calls to the data source; call reloadData to clear this cache.
 *
 *  @return The calendar returned by the data source, or a new Gregorian calendar object if no data source exists.
 */
- (NSCalendar *)calendar
{
    // If calendar is null, get it from the delegate or use the default one
    if (!_calendar) {
        _calendar = self.dataSource ? [self.dataSource calendarForCalendarView:self] : [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    }
    
    return _calendar;
}

/**
 *  Asks the data source for the start date to use and returns it, or returns the reference date if no data source exists. The result is cached to prevent multiple calls to the data source; call reloadData to clear this cache.
 *
 *  @return The date returned by the data source, or the reference date if no data source exists.
 */
- (NSDate *)startDate
{
    // If start date is null, get it from the delegate or use the default one
    if (!_startDate) {
        NSDate *dayInStartMonth = self.dataSource ? [self.dataSource startDateForCalendarView:self] : [NSDate dateWithTimeIntervalSinceReferenceDate:0];
        _startDate = [self.calendar firstOfMonthWithDate:dayInStartMonth];
    }
    return _startDate;
}

/**
 *  Asks the data source for the end date to use and returns it, or returns a date ten years in the future if no data source exists. The result is cached to prevent multiple calls to the data source; call reloadData to clear this cache.
 *
 *  @return The date returned by the data source, or the reference date if no data source exists.
 */
- (NSDate *)endDate
{
    // If end date is null, get it from the delegate or use the default one (10 years from now)
    if (!_endDate) {
        NSDate *dayInEndMonth = self.dataSource ? [self.dataSource endDateForCalendarView:self] : [NSDate dateWithTimeIntervalSinceNow:(NSTimeInterval)315576000];
        _endDate = [self.calendar firstOfNextMonthWithDate:dayInEndMonth];
    }
    return _endDate;
}

#pragma mark - Calendar Helper Methods

/**
 *  Returns the zero-based row index of the row containing the specified date.
 *
 *  @param date The date in the row whose index should be returned.
 *
 *  @return The zero-based row index of the row containing the specified date.
 */
- (NSUInteger)indexOfRowContainingDate:(NSDate *)date
{
    NSDate *startDate = self.startDate;
    NSDate *endDate = self.endDate;
    
    // Compare date argument with earliest and latest possible dates
    NSComparisonResult startDateComparison = [date compare:startDate];
    NSComparisonResult endDateComparison = [date compare:endDate];
    
    // If date is before startDate
    if (startDateComparison == NSOrderedAscending) {
        date = startDate;
    }
    // If date is after endDate
    else if (endDateComparison == NSOrderedDescending) {
        date = endDate;
    }
    
    return [self.calendar fullCalendarWeeksInEraFromDate:startDate ToDate:date];
    
}

/**
 *  Scrolls the calendar so that the top-most week visible is the week containing the first day of a particular month.
 *
 *  @param date     Any date in the month required.
 *  @param animated YES if you want to animate the change in position; NO if it should be immediate.
 */
- (void)scrollToFirstOfMonthWithDate:(NSDate *)date animated:(BOOL)animated
{
    // Get the indexPath
    NSIndexPath *indexPath = [self indexPathForRowContainingFirstOfMonthWithDate:date];
    [[self tableView] scrollToRowAtIndexPath:indexPath
                            atScrollPosition:UITableViewScrollPositionTop
                                    animated:animated];
}

/**
 *  Returns the index path in the table view for the row containing the first day of a particular month.
 *
 *  @param date Any date in the month required.
 *
 *  @return The index path in the table view for the row containing the first day of a particular month.
 */
- (NSIndexPath *)indexPathForRowContainingFirstOfMonthWithDate:(NSDate *)date
{
    // Get the first of the month
    NSDate *firstOfMonth = [self.calendar firstOfMonthWithDate:date];
    
    // Get the index of the row containing the first of the month
    NSUInteger rowIndex = [self indexOfRowContainingDate:firstOfMonth];
    
    if (rowIndex == NSNotFound) {
        return nil;
    }
    else {
        rowIndex = rowIndex - 1;
    }
    
    // Get the indexPath for the row
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:rowIndex inSection:0];
    
    return indexPath;
}


#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Dequeue a cell
    NSString *cellIdentifier = @"CABCalendarWeekCell";
    CABCalendarWeekTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Create cell if one wasn't dequeued
    if (cell == nil) {
        cell = [[CABCalendarWeekTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
    }
    
    
    // Set up the day buttons in the cell
    NSCalendar *calendar = self.calendar;
    NSDate *dateOfFirstDay = [calendar firstDayOfWeek:indexPath.row afterDate:[self startDate]];
    
    for (int i = 0; i < [cell.dayButtons count]; i++) {
        NSDate *date = [calendar dateByAddingUnit:NSCalendarUnitDay value:i toDate:dateOfFirstDay options:0];
        [self setupDayButton:[[cell dayButtons] objectAtIndex:i] withDate:date];
    }
    
    
    return cell;
}

- (void)setupDayButton:(CABCalendarDayButton *) button withDate:(NSDate *)date
{
    // Set the date for the current day button
    button.date = date;
    
    // Get the day part of the date and display it on button
    NSCalendar *calendar = self.calendar;
    NSDateComponents *comps = [calendar components:NSCalendarUnitDay fromDate:date];
    NSString *day = [NSString stringWithFormat:@"%@", @([comps day])];
    button.titleLabel.text = day;
    
    // Disable button if not in current month
    button.appearsEnabled = [calendar isDate:date equalToDate:self.selectedDate toUnitGranularity:NSCalendarUnitMonth];
    
    // Check if button represents today
    button.isToday = [calendar isDateInToday:date];
    
    // Check if button is selected
    button.selected = [date isEqualToDate:self.selectedDate];
    
    // Check if button has event
    button.showEventMarker = [self hasEventAtDate:date];
    
    // Action
    [button addTarget:self action:@selector(dayButtonPressed:) forControlEvents:UIControlEventTouchDown];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.calendar fullCalendarWeeksInEraFromDate:self.startDate ToDate:self.endDate];
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // Remember the current offset for use in calculations when dragging has ended
    self.currentContentOffset = self.tableView.contentOffset;
}

// This makes the calendar snap to the top of a month when scrolling, so you can't scroll to half-way through a month.
- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    
    BOOL changingMonths = NO;
    NSDate *selectedDate = self.selectedDate;
    NSCalendar *calendar = self.calendar;
    
    // Calculate relative offset
    CGFloat offset = targetContentOffset->y - self.currentContentOffset.y;
    
    // Calculate relative offset measured in cells
    NSInteger offsetCells = floorf(offset / self.rowHeight);
    
    NSDate *newDate;
    // If we are scrolling at least two lines down, go to next month
    if (offsetCells  >= 2) {
        newDate = [calendar firstOfNextMonthWithDate:selectedDate];
        changingMonths = YES;
    }
    // If we are scrolling at least two lines up, go to prev month
    else if (offsetCells <= -2) {
        newDate = [calendar firstOfPreviousMonthWithDate:selectedDate];
        changingMonths = YES;
    }
    // Otherwise stay on the current month
    else {
        newDate = [calendar firstOfMonthWithDate:selectedDate];
    }
    
    // Work out new coordinates to scroll to
    NSIndexPath *indexPathNew = [self indexPathForRowContainingFirstOfMonthWithDate:newDate];
    CGRect rect = [self.tableView rectForRowAtIndexPath:indexPathNew];
    *targetContentOffset = rect.origin;
    
    // Update cells
    if (changingMonths) {
        _newDate = newDate;
    }
    
}

// Reload the data when scrolling has finished
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_newDate) {
        [self setSelectedDate:_newDate animated:NO];
        _newDate = nil;
        [self.tableView reloadData];
    }
}

@end
