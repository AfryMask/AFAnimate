//
//  NSAttributedString+VideoText.h
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "VTTextAttribute.h"

@interface NSAttributedString (VideoText)

///不换行的情况需要多大的width
- (CGFloat)vtNoWrapWidth;

///不换行的情况需要多大的height
- (CGFloat)vtNoWrapHeight;

///用VTTextAttribute对象创建
- (instancetype)initWithString:(NSString *)str vtTextAttribute:(VTTextAttribute *)attr;

@end
