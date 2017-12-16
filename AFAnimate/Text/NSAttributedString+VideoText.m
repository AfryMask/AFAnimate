//
//  NSAttributedString+VideoText.m
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "NSAttributedString+VideoText.h"
#import "VTTextAttribute.h"

@implementation NSAttributedString (VideoText)

///不需要知道高度。绘制时只用ascender+descender画。
- (CGFloat)vtNoWrapWidth{
    CGSize biggestSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGFloat width = [self boundingRectWithSize:biggestSize options:options context:nil].size.width;
    return width;
}

- (CGFloat)vtNoWrapHeight{
    CGSize biggestSize = CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX);
    NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading;
    CGFloat height = [self boundingRectWithSize:biggestSize options:options context:nil].size.height;
    return height;
}

- (instancetype)initWithString:(NSString *)str vtTextAttribute:(VTTextAttribute *)attr{
    if (!str) {
        str = @"";
    }
    self = [self initWithString:str attributes:[attr dictAttributes]];
    if (self) {
        
    }
    return self;
}
@end
