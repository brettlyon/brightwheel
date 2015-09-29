//
//  BWCommitHistoryView.m
//  Brightwheel
//
//  Created by Brett Lyon on 9/29/15.
//  Copyright (c) 2015 BrettLyon. All rights reserved.
//

#import "BWCommitHistoryView.h"

@interface BWCommitHistoryView ()
@property (assign, nonatomic) NSUInteger maxCommitNumber;
@end

@implementation BWCommitHistoryView

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
    }
    return self;
}

- (void)setCommitHistory:(NSArray *)commitHistory {
    _commitHistory = commitHistory;
    
    self.maxCommitNumber = [self findMaxCommitNumber];
    
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.backgroundColor = [UIColor clearColor];
    
    if (self.commitHistory) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        // Drawing with a light gray stroke color
        CGContextSetRGBStrokeColor(context, 0.95, 0.95, 0.95, 1.0);
        // Drawing with a light gray fill color
        CGContextSetRGBFillColor(context, 0.95, 0.95, 0.95, 1.0);
        // Draw them with a 2.0 stroke width so they are a bit more visible.
        CGContextSetLineWidth(context, 1.0);
        
        CGPoint bottomRightCorner = CGPointMake(self.bounds.size.width, self.bounds.size.height);
        CGContextMoveToPoint(context, bottomRightCorner.x, bottomRightCorner.y);
        CGContextAddLineToPoint(context, self.bounds.origin.x, self.bounds.size.height);
        
        CGFloat normalizationFactor = 0.0;
        if (self.maxCommitNumber > 0) {
            normalizationFactor = 0.8 * self.frame.size.height / (CGFloat)self.maxCommitNumber;
        }
        
        CGFloat deltaX = self.frame.size.width / self.commitHistory.count;
        
        for (NSUInteger i = 0; i < self.commitHistory.count; i++) {
            CGFloat commitNumber = [self.commitHistory[i] floatValue];
            CGPoint datum = CGPointMake((i + 1) * deltaX, self.bounds.size.height - normalizationFactor * commitNumber);
            CGContextAddLineToPoint(context, datum.x, datum.y);
        }
        
        CGContextMoveToPoint(context, bottomRightCorner.x, bottomRightCorner.y);
        CGContextClosePath(context);
        CGContextDrawPath(context, kCGPathFillStroke);
    }
}

- (NSUInteger)findMaxCommitNumber {
    NSUInteger max = 0;
    for (NSUInteger i = 0; i < self.commitHistory.count; i++) {
        NSUInteger commitCount = [self.commitHistory[i] integerValue];
        if (commitCount > max) max = commitCount;
    }
    return max;
}

@end
