//
//  GCDrawingView.m
//  Finishing Touches
//
//  Created by Blake Oistad on 10/15/15.
//  Copyright © 2015 Thomas Crawford. All rights reserved.
//

#import "GCDrawingView.h"
#import "UIColor+GCColor.h"

@implementation GCDrawingView


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();  //creates the drawing context to store the drawings
    CGContextSetStrokeColor(context, CGColorGetComponents([[UIColor blueColor] CGColor]));          //chooses blue color and converts from uicolor to cgcolor
    CGContextMoveToPoint(context, 74.0, 74.0);
    CGContextAddLineToPoint(context, 124.0, 124.0);
    CGContextDrawPath(context, kCGPathStroke);              //commit the stroke
    
    CGContextSetStrokeColor(context, CGColorGetComponents([[UIColor redColor] CGColor]));
    CGContextSetLineWidth(context, 3.0);
    CGFloat lengths[2] = {6.0,3.0};                           //struct holding 2 items, 6.0 draws a line 6 pixels long, then 3.0 is the space between the lines, creates dotted line
    CGContextSetLineDash(context, 0, lengths, 2);
    CGContextMoveToPoint(context, 124.0, 124.0);
    CGContextAddLineToPoint(context, 124.0, 170.0);
    CGContextAddLineToPoint(context, 60.0, 140.0);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetLineDash(context, 0, nil, 0);               //resets line dash
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor johnDeerGreenColor] CGColor]));          //set fill color to purple
    CGRect rect1 = CGRectMake(150.0, 150.0, 100.0, 50.0);
    CGContextFillRect(context, rect1);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextSetLineWidth(context, 2.0);
    CGContextSetRGBStrokeColor(context, 0, 0, 0, 1.0);                       //sets color to black with an alpha of 1 or not transparent
    CGContextSetFillColor(context, CGColorGetComponents([[UIColor cokeRedColor]CGColor]));
    CGRect rect2 = CGRectMake(170.0, 170.0, 100.0, 75.0);
    CGContextFillEllipseInRect(context, rect2);
    CGContextAddEllipseInRect(context, rect2);
    CGContextDrawPath(context, kCGPathStroke);
    
    
}









@end
