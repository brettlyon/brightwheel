//
//  BWGradientView.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/29/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWGradientView.h"

@implementation BWGradientView

+ (UIColor *)lightestColor {
    return [UIColor colorWithWhite:0.0 alpha:0.0];
}

+ (UIColor *)darkestColor {
    return [UIColor colorWithWhite:0.0 alpha:0.03];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    UIColor *startColor = [[self class] darkestColor];
    UIColor *endColor = [[self class] lightestColor];
    
    [self drawLinearGradientWithContext:context inRect:self.bounds startColor:startColor.CGColor endColor:endColor.CGColor];
}

- (void)drawLinearGradientWithContext:(CGContextRef)context inRect:(CGRect)rect startColor:(CGColorRef)startColor endColor:(CGColorRef)endColor {
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = @[(__bridge id)startColor, (__bridge id)endColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

@end
