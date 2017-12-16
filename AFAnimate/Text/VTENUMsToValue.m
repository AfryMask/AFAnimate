//
//  VTENUMsToValue.m
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "VTENUMsToValue.h"
#import "GlobalMacros.h"
#import "NSShadow+VideoText.h"

#define RGBColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]

@implementation VTENUMsToValue

+ (float)ratioFromLetterSpacing:(VTLetterSpacing)letterSpacing{
    NSDictionary *d = @{@(VTLetterSpacingXS)    :@(0),
                        @(VTLetterSpacingS)     :@(0.2),
                        @(VTLetterSpacingM)     :@(0.5),
                        @(VTLetterSpacingL)     :@(1.0),
                        @(VTLetterSpacingXL)    :@(1.5),
                        @(VTLetterSpacingXXL)   :@(2.0),
                        @(VTLetterSpacing3XL)   :@(2.5),
                        @(VTLetterSpacing4XL)   :@(3.0),
                        };
    NSNumber *num = d[@(letterSpacing)];
    if (num) {
        return num.floatValue;
    } else {
        [NSException raise:@"参数不正确" format:@""];
        return 0;
    }
}


+ (UIColor *)colorFromTextColor:(VTTextColor)textColor{
    NSDictionary *d = @{@(VTTextColorWhite)    :RGBColor(0xFFFFFF, 1),
                        @(VTTextColorBlack)    :RGBColor(0x131211, 1),
                        };
    UIColor *color = d[@(textColor)];
    if (color) {
        return color;
    } else {
        [NSException raise:@"参数不正确" format:@""];
        return nil;
    }
}

+ (float)ratioFromLineSpacing:(VTLineSpacing)lineSpacing{
    NSDictionary *d = @{    @(VTLineSpacingXS)	: @-0.2,
                            @(VTLineSpacingS)	: @0,
                            @(VTLineSpacingM)	: @0.2,
                            @(VTLineSpacingL)	: @0.5,
                            @(VTLineSpacingXL)	: @1.0,
                            @(VTLineSpacingXXL)	: @1.5,
                            @(VTLineSpacing3XL)	: @2.0,
                            @(VTLineSpacing4XL)	: @3.0
                        };
    NSNumber *num = d[@(lineSpacing)];
    if (num) {
        return num.floatValue;
    } else {
        [NSException raise:@"参数不正确" format:@""];
        return 0;
    }
}

+ (float)ratioFromFontSize:(VTFontSize)fontSize{
    NSDictionary *d = @{
                        @(VTFontSizeXS) :    @0.4,
                        @(VTFontSizeS)  :    @0.7,
                        @(VTFontSizeM)  :    @1.0,
                        @(VTFontSizeL)  :    @1.5,
                        @(VTFontSizeXL) :    @2.0,
                        @(VTFontSizeXXL):    @3.0,
                        @(VTFontSize3XL):    @4.5,
                        @(VTFontSize4XL):    @6.0,
                        };
    NSNumber *num = d[@(fontSize)];
    if (num) {
        return num.floatValue;
    } else {
        [NSException raise:@"参数不正确" format:@""];
        return 0;
    }
}

+ (NSShadow *)shadowForVTShadow:(VTShadow)vtshadow{
    NSShadow *shadowObj = [NSShadow new];
    switch (vtshadow) {
        case VTShadowNone:
        case VTShadowUpAndDown:
        case VTShadow4Borders:
        case VTShadowUnderscore:
            shadowObj.shadowBlurRadius = 0;
            shadowObj.shadowOffset = CGSizeMake(0, 0);
            shadowObj.shadowAlpha  = 0;
            break;
        case VTShadowSmooth:
            shadowObj.shadowBlurRadius = 2;
            shadowObj.shadowOffset = CGSizeMake(1, 1);
            shadowObj.shadowAlpha  = 0.5;
            //test
//            shadowObj.shadowAlpha  = 1;
            break;
        case VTShadowAround:
            shadowObj.shadowBlurRadius = 25;
            shadowObj.shadowOffset = CGSizeMake(0, 0);
            shadowObj.shadowAlpha  = 0.2;
            //test
//            shadowObj.shadowAlpha  = 1;
            break;
    }
    return shadowObj;
}



@end
