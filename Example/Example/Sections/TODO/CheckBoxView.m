//
//  CheckBoxView.m
//  Example
//
//  Created by Anders Frank on 2014-12-19.
//  Copyright (c) 2014 Anders Frank. All rights reserved.
//

#import "CheckBoxView.h"
#import "UIBezierPath+Draw.h"

@implementation CheckBoxView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {

    CGFloat lineWidth = self.checked ? 2 : 1.5;
    
    UIColor *strokeColor = self.checked ? [UIColor colorWithWhite:115 / 255.0 alpha:1] : [UIColor colorWithRed:0.898 green:0.796 blue:0.000 alpha:1];
    
    CGRect boxRect = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(lineWidth / 2, lineWidth / 2, lineWidth / 2, lineWidth / 2));
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:boxRect cornerRadius:2];
    
    path.lineWidth = lineWidth;
    
    [strokeColor setStroke];
    [path stroke];
    
    if (!self.checked) {
        [[UIColor colorWithRed:0.992 green:0.953 blue:0.471 alpha:1] setFill];
        [path fill];
        
    }
    else {
        [[UIColor colorWithWhite:115 / 255.0 alpha:1] setFill];
        CGRect checkMarkContainer = UIEdgeInsetsInsetRect(rect, UIEdgeInsetsMake(2, 4, 2, 3));
        UIBezierPath *checkMarkPath = [self checkMarkPath];
        checkMarkPath = [checkMarkPath scaleToFitSize:checkMarkContainer.size];
        checkMarkPath = [checkMarkPath centerInRect:checkMarkContainer];
        [checkMarkPath fill];
    }
    
}

- (void)setChecked:(BOOL)checked {
    _checked = checked;
    [self setNeedsDisplay];
}

- (UIBezierPath *)checkMarkPath {
    //// Bezier Drawing
    UIBezierPath* bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint: CGPointMake(8.5, 32.5)];
    [bezierPath addLineToPoint: CGPointMake(31.5, 54.5)];
    [bezierPath addLineToPoint: CGPointMake(75.5, 0.5)];
    [bezierPath addLineToPoint: CGPointMake(81.5, 5.5)];
    [bezierPath addLineToPoint: CGPointMake(34.5, 74.5)];
    [bezierPath addLineToPoint: CGPointMake(0.5, 39.5)];
    [bezierPath addLineToPoint: CGPointMake(8.5, 32.5)];
    [bezierPath closePath];
    return bezierPath;

}

@end
