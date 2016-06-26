//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "CABCalendarHeaderView.h"

static const int DaysInWeek = 7;

@implementation CABCalendarHeaderView
{
    // Instance variable to ensure constraints are only added once
    bool _isConstraintsAdded;
    
    // Instance variable to store the labels which display the day names
    NSArray *_dayLabels;
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

- (instancetype)initWithFrame:(CGRect)frame firstWeekday:(NSUInteger)firstWeekday
{
    self = [self initWithFrame:frame];
    self.firstWeekday = firstWeekday;
    return self;
}

- (void)commonInit
{
    // Appearance
    self.backgroundColor = [UIColor colorWithRed:0.98 green:0.98 blue:0.98 alpha:1.0];
    
    // Create all day labels in row.
    NSMutableArray *dayLabels = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < DaysInWeek; i++) {
        // Create the label
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
        
        // Set up the style
        label.font = [UIFont systemFontOfSize:12];
        label.textAlignment = NSTextAlignmentCenter;
        
        // Add it as a subview
        [self addSubview:label];
        
        // Add it to the mutable array
        [dayLabels addObject:label];
    }
    
    // Create a non-mutable array
    _dayLabels = [NSArray arrayWithArray:dayLabels];
    
    // Update the labels with day names
    [self updateLabels];
    
}

#pragma mark - Overriding UIView methods

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self updateLabels];
}

+ (BOOL)requiresConstraintBasedLayout
{
    return true;
}

- (void)updateConstraints
{
    if (!_isConstraintsAdded) {
        // Loop through labels and add constraints
        for (int i = 0; i < _dayLabels.count; i++) {
            // Get the label
            UILabel *label = [_dayLabels objectAtIndex:i];
            
            // Don't use auto resizing mask
            label.translatesAutoresizingMaskIntoConstraints = false;
            
            // Add the constraints
            [label.topAnchor constraintEqualToAnchor:self.topAnchor].active = YES;
            [label.bottomAnchor constraintEqualToAnchor:self.bottomAnchor].active = YES;
            // Leading constraint
            if (i == 0) {
                [label.leadingAnchor constraintEqualToAnchor:self.leadingAnchor].active = YES;
            }
            else {
                UILabel *leadingLabel = [_dayLabels objectAtIndex:i - 1];
                [label.leadingAnchor constraintEqualToAnchor:leadingLabel.trailingAnchor].active = YES;
                // Width constraint
                UILabel *firstLabel = [_dayLabels objectAtIndex:0];
                [label.widthAnchor constraintEqualToAnchor:firstLabel.widthAnchor].active = YES;
            }
            // Trailing constraint
            if (i == _dayLabels.count - 1) {
                [label.trailingAnchor constraintEqualToAnchor:self.trailingAnchor].active = YES;
            }
            
        }
        
        
        _isConstraintsAdded =  true;
    }
    
    [super updateConstraints];
}

#pragma mark - Public methods

- (void)updateLabels
{
    // Get the firstWeekday property, ensure it's between 1 and 7
    NSUInteger firstWeekday = self.firstWeekday;
    if (firstWeekday < 1) {
        firstWeekday = 1;
    }
    else if (firstWeekday > DaysInWeek) {
        firstWeekday = DaysInWeek;
    }
    
    // Get array of localized short weekday names and a date formatter
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSArray *shortWeekdaySymbols = [dateFormatter shortWeekdaySymbols];
    
    // Loop through labels and update text
    for (int i = 0; i < _dayLabels.count; i++) {
        // Get the label
        UILabel *label = [_dayLabels objectAtIndex:i];
        
        // Work out index of array to look at based on firstWeekday property
        NSUInteger arrayIndex = (i + firstWeekday - 1) % [shortWeekdaySymbols count];
        
        // Set label text
        label.text = [[dateFormatter shortWeekdaySymbols] objectAtIndex:arrayIndex];
        
    }
}

@end
