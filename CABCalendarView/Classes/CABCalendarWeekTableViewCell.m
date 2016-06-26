//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "CABCalendarWeekTableViewCell.h"
#import "CABCalendarDayButton.h"

static NSUInteger const DaysInWeek = 7;

@implementation CABCalendarWeekTableViewCell
{
    // Instance variable to ensure constraints are only added once
    bool _isConstraintsAdded;
}

#pragma mark - Initialization

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createDayButtons];
    }
    return self;
}

/**
 *  Creates all the day button objects and adds them as subviews.
 */
- (void)createDayButtons
{
    // Create a mutable array to store the buttons in as we create them
    NSMutableArray *dayButtons = [[NSMutableArray alloc] init];
    
    // Create all day buttons in row.
    CGRect dayRect;
    for (int i = 0; i < DaysInWeek; i++) {
        // Create frame for button
        dayRect = CGRectZero;
        
        // Create the button
        CABCalendarDayButton *button = [[CABCalendarDayButton alloc] initWithFrame:dayRect];
        
        // Add it to the array
        [dayButtons addObject:button];
        
        // Add it as a subview
        [self.contentView addSubview:button];
        
    }
    
    // Create a non-mutable array of the buttons and set this as a property
    _dayButtons = [[NSArray alloc] initWithArray:dayButtons];
    
}

#pragma mark - Overriding UIView methods

+ (BOOL)requiresConstraintBasedLayout
{
    return true;
}

- (void)updateConstraints
{
    if (!_isConstraintsAdded) {
        // Add constraints for the individual day buttons
        NSArray *dayButtons = self.dayButtons;
        for (int i = 0; i < dayButtons.count; i++) {
            // Get the button
            CABCalendarDayButton *button = [dayButtons objectAtIndex:i];
            
            // Don't use auto resizing mask
            button.translatesAutoresizingMaskIntoConstraints = false;
            
            // Add the constraints
            [button.topAnchor constraintEqualToAnchor:self.contentView.topAnchor].active = YES;
            [button.bottomAnchor constraintEqualToAnchor:self.contentView.bottomAnchor].active = YES;
            // Leading constraint
            if (i == 0) {
                [button.leadingAnchor constraintEqualToAnchor:self.contentView.leadingAnchor].active = YES;
            }
            else {
                CABCalendarDayButton *leadingButton = [dayButtons objectAtIndex:i - 1];
                [button.leadingAnchor constraintEqualToAnchor:leadingButton.trailingAnchor].active = YES;
                // Width constraint
                CABCalendarDayButton *firstButton = [dayButtons objectAtIndex:0];
                [button.widthAnchor constraintEqualToAnchor:firstButton.widthAnchor].active = YES;
            }
            // Trailing constraint
            if (i == dayButtons.count - 1) {
                [button.trailingAnchor constraintEqualToAnchor:self.contentView.trailingAnchor].active = YES;
            }
            
        }
        _isConstraintsAdded = true;
    }
    [super updateConstraints];
}

@end
