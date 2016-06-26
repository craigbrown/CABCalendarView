//
//  Copyright (c) 2016 Craig Brown. All rights reserved.
//
//  You may use, distribute and modify this code under the terms of the MIT license.
//  See the LICENSE file for more details, or visit https://opensource.org/licenses/MIT
//

#import "CABEventMarkerView.h"

@implementation CABEventMarkerView

#pragma mark - Initialization

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        self.markerColor = [UIColor blueColor];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame andColor:(UIColor *)color
{
    self = [super initWithFrame:frame];
    if (self) {
        self.markerColor = color;
    }
    return self;
}

#pragma mark - Drawing the view

- (void)drawRect:(CGRect)rect
{
    [self drawCircleWithRect:rect andColor:self.markerColor];
    
}

- (void)drawCircleWithRect:(CGRect)rect andColor:(UIColor *)color
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextAddEllipseInRect(ctx, rect);
    CGContextSetFillColor(ctx, CGColorGetComponents([color CGColor]));
    CGContextFillPath(ctx);
}


@end
