//
//  NSString+VideoText.m
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "NSString+VideoText.h"
#import "NSAttributedString+VideoText.h"

@implementation NSString (VideoText)

- (NSArray<NSString *> *)lines{
    NSMutableArray *lines = [NSMutableArray array];
    [self enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        [lines addObject:line];
    }];
    return lines;
}

- (NSInteger)lineCount{
    return  self.lines.count;
}

- (NSString *)maxWidthLineWithFont:(UIFont *)font{
    __block NSString *maxWidthLine = nil;
    __block float maxWidthLineWidth = 0;
    [self enumerateLinesUsingBlock:^(NSString * _Nonnull line, BOOL * _Nonnull stop) {
        CGFloat width = [line vtWidthWithFont:font];
        if (width > maxWidthLineWidth) {
            maxWidthLineWidth = width;
            maxWidthLine = line;
        }
    }];
    return maxWidthLine;
}

- (NSString *)maxGlypthLine{
    NSInteger glyphCount = 0;
    NSString *maxGlyphLine = nil;
    for (NSString *str in self.lines) {
        NSInteger strGlyphCount = [str glyphCount];
        if (strGlyphCount > glyphCount) {
            maxGlyphLine = str;
        }
    }
    return maxGlyphLine;
}

///私有方法。因为widthWithFont和系统命名冲突，前面加上vt
- (CGFloat)vtWidthWithFont:(UIFont *)font{
    VTTextAttribute *attr = [VTTextAttribute new];
    attr.fontName = font.fontName;
    attr.fontSize = font.pointSize;

    NSAttributedString *as = [[NSAttributedString alloc]initWithString:self vtTextAttribute:attr];
    CGFloat width = [as vtNoWrapWidth];
    return width;
}

- (NSInteger)glyphCount{
    NSRange fullRange = NSMakeRange(0, [self length]);
    __block NSInteger count = 0;
    [self enumerateSubstringsInRange:fullRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
        count += 1;
    }];
    return count;

    /*
     用这种方法也可以，但是怕出毛病
     http://objccn.io/issue-9-1/
     NSUInteger realLength = [s lengthOfBytesUsingEncoding:NSUTF32StringEncoding] / 4;
     */
}

- (instancetype)trimToGlyphCount:(NSInteger)count{
    if (self.glyphCount > count) {
        __block NSString *result = @"";
        NSRange fullRange = NSMakeRange(0, [self length]);
        __block NSInteger i = 0;
        [self enumerateSubstringsInRange:fullRange options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            result = [result stringByAppendingString:substring];
            i += 1;//i为已处理字形数
            if (i == count - 1) {
                result = [result stringByAppendingString:@"…"];
                *stop = YES;
            }
        }];
        return result;
    } else {
        return self;
    }
}
@end
