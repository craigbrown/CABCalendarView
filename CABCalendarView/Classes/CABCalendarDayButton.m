//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "CABCalendarDayButton.h"
#import "CABEventMarkerView.h"

CGFloat const markerDiameter = 5;
CGFloat const dateFontSize = 16;

@interface CABCalendarDayButton ()

/**
 *  The event marker view, which when visible indicates there is an event on this day.
 */
@property (strong, nonatomic) CABEventMarkerView *eventMarkerView;

@end

@implementation CABCalendarDayButton
{
    // Instance variable to ensure constraints are only added once
    bool _isConstraintsAdded;
}

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        [self commonInit];
    }
    
    return self;
}

/**
 *  Initialization logic - sets up subviews, customizes appearance, etc.
 */
- (void)commonInit
{
    // Add subviews
    [self addEventMarkerView];
    [self addLabel];
    
    // Appearance
    self.layer.cornerRadius = 5;
    self.layer.borderColor = [[UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:1.0] CGColor];
    self.titleLabel.font = [UIFont systemFontOfSize:dateFontSize];
    
    
    self.selected = NO;
    self.appearsEnabled = YES;
    self.isToday = NO;
    self.showEventMarker = NO;
}

/**
 *  Creates the event marker view and adds it as a subview.
 */
- (void)addEventMarkerView
{
    // Add main event marker but hide it for now (will be visible if property is set)
    CABEventMarkerView *event = [[CABEventMarkerView alloc] initWithFrame:CGRectZero];
    event.hidden = true;
    [self addSubview:event];
    self.eventMarkerView = event;
    
    // turn off autoresizing mask so constraints work properly
    event.translatesAutoresizingMaskIntoConstraints = NO;
}

/**
 *  Creates the day label and adds it as a subview.
 */
- (void)addLabel
{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self addSubview:titleLabel];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    self.titleLabel = titleLabel;
}

#pragma mark - Overriding UIView methods

+ (BOOL)requiresConstraintBasedLayout
{
    return true;
}

- (void)updateConstraints
{
    if (!_isConstraintsAdded) {
        // Add constraints for event marker
        CABEventMarkerView *eventMarker = self.eventMarkerView;
        [eventMarker.heightAnchor constraintEqualToConstant:markerDiameter].active = YES;
        [eventMarker.widthAnchor constraintEqualToConstant:markerDiameter].active = YES;
        [eventMarker.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [NSLayoutConstraint constraintWithItem:eventMarker attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.5 constant:0].active = YES;
        
        // Move label up a bit
        UILabel *label = self.titleLabel;
        [label.heightAnchor constraintLessThanOrEqualToAnchor:self.heightAnchor].active = YES;
        [label.widthAnchor constraintLessThanOrEqualToAnchor:self.widthAnchor].active = YES;
        [label.centerXAnchor constraintEqualToAnchor:self.centerXAnchor].active = YES;
        [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:0.75 constant:0].active = YES;
        
        _isConstraintsAdded = true;
    }
    [super updateConstraints];
}

#pragma mark - Custom setters

- (void)setSelected:(BOOL)selected
{
    [super setSelected:selected];
    
    // Change the appearance if this button is selected
    if (selected) {
        self.backgroundColor = [CABCalendarDayButton selectedBackgroundColor];
        self.layer.borderWidth = 1;
        self.layer.cornerRadius = 5;
    }
    else {
        self.backgroundColor = [CABCalendarDayButton normalBackgroundColor];
        self.layer.borderWidth = 0;
        self.layer.cornerRadius = 0;
    }
}

- (void)setAppearsEnabled:(BOOL)appearsEnabled
{
    _appearsEnabled = appearsEnabled;
    
    // Change the appearance according to whether or not the button should appear enabled
    if (appearsEnabled) {
        self.selected = YES;
        self.backgroundColor = [CABCalendarDayButton normalBackgroundColor];
        self.titleLabel.textColor = [UIColor blackColor];
    }
    else {
        self.selected = NO;
        self.backgroundColor = [CABCalendarDayButton disabledBackgroundColor];
        self.titleLabel.textColor = [UIColor lightGrayColor];
    }
}

- (void)setIsToday:(BOOL)isToday
{
    _isToday = isToday;
    
    if (isToday) {
        self.layer.borderWidth = 1;
    }
    else {
        self.layer.borderWidth = 0;
    }
}

- (void)setShowEventMarker:(BOOL)showEventMarker
{
    _showEventMarker = showEventMarker;
    self.eventMarkerView.hidden = !showEventMarker;
}

#pragma mark - Get background colors

+ (UIColor *)normalBackgroundColor
{
    return [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
}

+ (UIColor *)selectedBackgroundColor
{
    return [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0];
}

+ (UIColor *)disabledBackgroundColor
{
    return [UIColor colorWithRed:0.90 green:0.90 blue:0.90 alpha:1.0];
}


@end
