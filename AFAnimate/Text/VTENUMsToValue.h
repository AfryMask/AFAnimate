//
//  VTENUMsToValue.h
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VTENUMs.h"
#import <UIKit/UIKit.h>

@interface VTENUMsToValue : NSObject
+ (float)ratioFromLetterSpacing:(VTLetterSpacing)letterSpacing;
+ (UIColor *)colorFromTextColor:(VTTextColor)textColor;
+ (float)ratioFromLineSpacing:(VTLineSpacing)lineSpacing;
+ (float)ratioFromFontSize:(VTFontSize)fontSize;

///这个shadow单位都是px。绘制到屏幕上时需要换算单位
+ (NSShadow *)shadowForVTShadow:(VTShadow)vtshadow;
@end
