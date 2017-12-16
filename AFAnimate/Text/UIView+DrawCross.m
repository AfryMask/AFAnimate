//
//  UIView+DrawCross.m
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "UIView+DrawCross.h"
#import "UIView+APUtils.h"

@implementation UIView (DrawCross)

- (void)drawCross{
    // Draw a series of line segments. Each pair of points is a segment
    CGPoint strokeSegments[] =
    {
        //竖线
        CGPointMake(self.width * 0.5, 0),
        CGPointMake(self.width * 0.5, self.height),
        //横线
        CGPointMake(0, self.height * 0.5),
        CGPointMake(self.width, self.height * 0.5),
    };
    [self drawGrayDashLineWithPoints:strokeSegments count:sizeof(strokeSegments)/sizeof(CGPoint)];
}

- (void)drawVerticalLineAt:(CGFloat)x{
    CGPoint strokeSegments[] =
    {
        //竖线
        CGPointMake(x, 0),
        CGPointMake(x, self.height),
    };
    [self drawGrayDashLineWithPoints:strokeSegments count:sizeof(strokeSegments)/sizeof(CGPoint)];
}

- (void)drawHorizontalLineAt:(CGFloat)y{
    CGPoint strokeSegments[] =
    {
        //横线
        CGPointMake(0, y),
        CGPointMake(self.width, y),
    };
    [self drawGrayDashLineWithPoints:strokeSegments count:sizeof(strokeSegments)/sizeof(CGPoint)];
}

- (void)drawRectDashLineAt:(CGRect)rect{
    
    CGPoint topLeft = CGPointMake(rect.origin.x, rect.origin.y);
    CGPoint topRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y);
    CGPoint bottomLeft = CGPointMake(rect.origin.x, rect.origin.y + rect.size.height);
    CGPoint bottomRight = CGPointMake(rect.origin.x + rect.size.width, rect.origin.y + rect.size.height);
    
    CGPoint strokeSegments[] =
    {
        //topLine
        topLeft,topRight,
        //bottomLine
        bottomLeft,bottomRight,
        //leftLine
        topLeft,bottomLeft,
        //rightLine
        topRight,bottomRight
    };
    [self drawDashLineWithPoints:strokeSegments count:sizeof(strokeSegments)/sizeof(CGPoint) color: [[UIColor whiteColor] colorWithAlphaComponent:0.5]];
}

- (void)drawGrayDashLineWithPoints:(CGPoint *)points count:(NSInteger)pointCount{
    UIColor *color = [UIColor grayColor];
    [self drawDashLineWithPoints:points count:pointCount color:color];
}

- (void)drawDashLineWithPoints:(CGPoint *)points count:(NSInteger)pointCount color:(UIColor *)color{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    CGFloat lengths[] = {4,2}; // old 5,5
    CGContextSetLineDash(ctx, 0, lengths, 2);
    [color setStroke];
    CGContextSetLineWidth(ctx, 1.0);
    CGContextStrokeLineSegments(ctx, points, pointCount);
    CGContextRestoreGState(ctx);
}

#pragma mark - solid line

- (void)drawSolidLineWithPoints:(CGPoint *)points count:(NSInteger)pointCount color:(UIColor *)color{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    [color setStroke];
    CGContextSetLineWidth(ctx, 1.0);
    CGContextStrokeLineSegments(ctx, points, pointCount);
    CGContextRestoreGState(ctx);
}

- (void)drawHorizontalSolidLineAt:(CGFloat)y color:(UIColor *)color{
    CGPoint strokeSegments[] =
    {
        //横线
        CGPointMake(0, y),
        CGPointMake(self.width, y),
    };
    [self drawSolidLineWithPoints:strokeSegments count:sizeof(strokeSegments)/sizeof(CGPoint) color:color];
}
@end
