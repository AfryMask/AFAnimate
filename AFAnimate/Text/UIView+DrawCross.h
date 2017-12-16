//
//  UIView+DrawCross.h
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (DrawCross)
///下面所有的方法都必须在 -DrawRect 方法中调用


- (void)drawCross;
- (void)drawVerticalLineAt:(CGFloat)x;
- (void)drawHorizontalLineAt:(CGFloat)y;
- (void)drawRectDashLineAt:(CGRect)rect;

///points是数组，count是数组中的元素个数
- (void)drawDashLineWithPoints:(CGPoint *)points count:(NSInteger)pointCount color:(UIColor *)color;

#pragma mark - solid line
- (void)drawSolidLineWithPoints:(CGPoint *)points count:(NSInteger)pointCount color:(UIColor *)color;
- (void)drawHorizontalSolidLineAt:(CGFloat)y color:(UIColor *)color;

@end
