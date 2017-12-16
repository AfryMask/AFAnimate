//
//  NSString+VideoText.h
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSString (VideoText)
///获得line数组
- (NSArray <NSString *>*)lines;

///行数
- (NSInteger)lineCount;

/// 最宽的行，会用boundingRect去计算的！
- (NSString *)maxWidthLineWithFont:(UIFont *)font;

///字形最多的行
- (NSString *)maxGlypthLine;

///获得glyphCount 字形个数
- (NSInteger)glyphCount;

///这个方法是在PostViewController中调用。不属于VideoText的！
/// [@"abcdef" trimToGlyphCount:3]返回的结果应是"abc…"
- (instancetype)trimToGlyphCount:(NSInteger)count;
@end
