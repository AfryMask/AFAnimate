//
//  VTTextAttribute.m
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "VTTextAttribute.h"

@implementation VTTextAttribute

- (NSDictionary *)dictAttributes{
    NSMutableDictionary *attr = [NSMutableDictionary dictionary];
    attr[NSForegroundColorAttributeName] = self.textColor;

    attr[NSFontAttributeName] = [UIFont systemFontOfSize:21];

    if (self.shadow) {
        attr[NSShadowAttributeName] = self.shadow;
    }

    return attr;
}

- (UIFont *)realFont{
    UIFont *realFont = [UIFont fontWithName:self.fontName size:self.fontSize];
    return realFont;
}

- (CGFloat)ascendDescend{
    UIFont *realFont = self.realFont;
    CGFloat result = realFont.ascender + fabs(realFont.descender);
//    NSLog(@"Font - ascender = %f, descender = %f",realFont.ascender,realFont.descender);
//    NSLog(@"Font - lineHeight = %f, leading = %f",realFont.lineHeight,realFont.leading);
//    NSLog(@"Font - capHeight = %f, xHeight = %f",realFont.capHeight,realFont.xHeight);
//    NSLog(@"Font - pointSize = %f baseline = %f",realFont.pointSize,realFont.lineHeight - realFont.ascender);
    return result;
}

/// 可以不设置，默认是白色
- (UIColor *)textColor{
    if (_textColor) {
        return _textColor;
    } else {
        return [UIColor whiteColor];
    }
}
@end
