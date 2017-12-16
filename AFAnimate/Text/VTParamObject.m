//
//  VTParamObject.m
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "VTParamObject.h"
#import "VTENUMsToValue.h"
#import "NSShadow+VideoText.h"
#import "VTFontDescriptor.h"
#import "VTFontDownloadManager.h"
//#import <OpenCCFrameWork/OpenCCFrameWork.h>
//#import "StoryFilterModel.h"
#import "VTENUMTitles.h"
//#import "UIColor+HexString.h"
#import "NSString+VideoText.h"
//#import "MovieEditValueDefinitions.h"
//#import "MovieEditManager.h"

@interface VTParamObject()
@property (nonatomic,strong) NSString *traditionalText; ///< 强制转化的繁体
@property (nonatomic,strong) NSString *simplifiedText; ///< 强制转化的简体
@end

@implementation VTParamObject{
    NSString *_capitalized;
}
@synthesize text = _text;

- (void)applyDefaulValue{
    _align = VTDefaultAlign;
    _letterSpacing = VTDefaultLetterSpacing;
    _lineSpacing = VTDefaultLineSpacing;
    _textColor = VTDefaultTextColor;
    _fontSize = VTDefaultFontSize;
    _verticalPos = 0;
    _fontDescriptor = nil;
    self.vtshadow = VTDefaultShadow;
}

///每次setText时都把繁体设置为nil
- (void)setText:(NSString *)text{
    _text = text;
    _userInputText = text;
    _textLineCount = 0;
    _traditionalText = nil;
    _simplifiedText  = nil;
    _capitalized = nil;
    if ([self.delegate respondsToSelector:@selector(vtParamObject:didChangedText:)]) {
        [self.delegate vtParamObject:self didChangedText:text];
    }
    if (text) {
        NSDictionary *userInfo = [NSDictionary dictionaryWithObject:text forKey:@"text"];
//        [kDefaultNotificationCenter postNotificationName:NOTIFICATION_MEVTTEXT_CHANGED object:self userInfo:userInfo];
    }
}

- (NSInteger)textLineCount{
    if (!_textLineCount) {
        _textLineCount = self.text.lineCount;
    }
    return _textLineCount;
}

- (NSString *)textNoTranditionalNoUpper{
    return _text;
}

- (NSString *)text{
    if (!_text) {
        return _text;
    }
    if ([self.fontDescriptor.cnonly isEqualToString:@"traditional"]) {
        if (!_traditionalText) {
//            OpenCCService *s2t = [[OpenCCService alloc]initWithConverterType:OpenCCServiceConverterTypeS2T];
//            NSString *textAfterConvert = [s2t convert:_text];
//            _traditionalText = textAfterConvert;
        }
        return _traditionalText;
    } else if ([self.fontDescriptor.cnonly isEqualToString:@"simplified"]) {
        if (!_simplifiedText) {
//            OpenCCService *t2s = [[OpenCCService alloc] initWithConverterType:OpenCCServiceConverterTypeT2S];
//            NSString *textAfterConvert = [t2s convert:_text];
//            _simplifiedText = textAfterConvert;
        }
        return _simplifiedText;
    } else if (self.fontDescriptor.capitalized.boolValue){
        if (!_capitalized) {
            _capitalized = [_text uppercaseString];
        }
        return _capitalized;
    }else {
        return _text;
    }
    return _text;
}

///还需要加上lineheightoffset
- (CGFloat)lineSpacingRatio{
    CGFloat ratio = [VTENUMsToValue ratioFromLineSpacing:self.lineSpacing] + self.fontDescriptor.lineheightoffset.floatValue;
    return ratio;
}

- (CGFloat)letterSpacingRatio{
    CGFloat ratio = [VTENUMsToValue ratioFromLetterSpacing:self.letterSpacing];
    return ratio;
}

- (CGFloat)fontSizeRatio{
    CGFloat ratio = [VTENUMsToValue ratioFromFontSize:self.fontSize];
    return ratio;
}

- (NSString *)fontName{
    return self.fontDescriptor.fontRealName;
}

- (void)checkFontDescriptorAndRegister{
    BOOL dontHaveFontDescriptor = (!self.fontDescriptor);
    if (dontHaveFontDescriptor){
        self.fontDescriptor = nil;
    }
//    [[VTFontDownloadManager sharedInstance] registerGraphicsFont:self.fontDescriptor];
}


- (CGFloat)fontSizeValue{
    CGFloat v = self.standardFontSizeValue * self.fontSizeRatio;
    return v;
}

- (UIFont *)font{
    UIFont *f = [self fontWithPointSize:self.fontSizeValue];
    return f;
}

- (UIFont *)fontWithPointSize:(CGFloat)pointSize{
    UIFont *f = [UIFont fontWithName:self.fontName size:pointSize];
    if (!f) {
        NSLog(@"fontWithName return nil!! %@",self.fontName);
    }
    return f;
}

- (UIColor *)textColorValue{
    UIColor *color = [VTENUMsToValue colorFromTextColor:self.textColor];
    return color;
}

- (UIColor *)backgroundColorValue{
    if (self.textColor == VTTextColorWhite) {
        return [VTENUMsToValue colorFromTextColor:VTTextColorBlack];
    } else {
        return [VTENUMsToValue colorFromTextColor:VTTextColorWhite];
    }
}
//
//- (NSShadow *)shadow{
//    if (_shadow) {
//        return _shadow;
//    } else {
//        NSShadow *s = [NSShadow new];
//        s.shadowOffset = CGSizeMake(2, 2);
//        s.shadowColor = [UIColor blueColor];
//        return s;
//    }
//}

- (void)setShadow:(NSShadow *)shadow{
    _shadow = shadow;
}

- (void)setVerticalPos:(CGFloat)verticalPos {
    _verticalPos = verticalPos;
//    NSLog(@"verticalPos = %f",verticalPos);
}

- (void)setFontSize:(VTFontSize)fontSize {
    _fontSize = fontSize;
    NSLog(@"FontSize = %ld",fontSize);
}

#ifndef YY_CLAMP // return the clamped value
#define YY_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif
- (NSShadow *)shadowWithFontSizeCalcResult:(CGFloat)fontSizeCalcResult scale:(CGFloat)scale{
    
    NSShadow *sha = [self.shadow copy];//注意这里是copy，没有修改self.shadow的值
    //先对self.shadow按比例缩放。单位为px
    CGFloat ratio = fontSizeCalcResult / self.standardFontSizeValue;//比例可能是3~0.1，如果用户只输入一个字且选字号为300%，则比例为3.
    sha.shadowBlurRadius *= ratio;
    sha.shadowOffset = CGSizeMake(sha.offsetWidth * ratio, sha.offsetHeight * ratio);

    //再根据屏幕进行scale。单位转为pt。1px为 1/scale pt。
    sha.shadowBlurRadius /= scale;
    sha.shadowOffset = CGSizeMake(sha.offsetWidth / scale, sha.offsetHeight / scale);

    //再调整到取值范围区间（取值范围的单位是px，此时的单位是pt，也需要转换单位）。在view上绘制时，最小值也是1px，即1/scale pt。
    sha.shadowBlurRadius = YY_CLAMP(sha.shadowBlurRadius, 1/scale, 25/scale);

    return sha;
}

- (void)setVtshadow:(VTShadow)vtshadow{
    _vtshadow = vtshadow;
    self.shadow = [VTENUMsToValue shadowForVTShadow:vtshadow];
}


#pragma mark ----- decoModel relate ----
- (StoryFilterDecoModel *)decoModelRepresentation{
//    StoryFilterDecoModel *m = [StoryFilterDecoModel new];
//    m.text = _text;
//    m.fontName = _fontDescriptor.name;//不是fontRealName就是json中的name
//    m.fontSize = [VTENUMTitles fontSizeTitles][_fontSize];
//    m.align = [self.class decoStringOfAlign:_align];
//    m.textColor = [self.textColorValue hexString];
//    m.shadow = [self.class decoStringOfVTShadow:_vtshadow];
//    m.letterSpace = [VTENUMTitles letterSpacingTitles][_letterSpacing];
//    m.lineSpace = [VTENUMTitles lineSpacingTitles][_lineSpacing];
//    m.pos = [self.class decoStringOfVerticalPos:_verticalPos];
    return nil;
}

+ (NSString *)decoStringOfAlign:(VTAlign)align{
    NSString *str = @"";
    switch (align) {
        case VTAlignL:
            str = @"L";
            break;
        case VTAlignM:
            str = @"M";
            break;
        case VTAlignR:
            str = @"R";
            break;
    }
    return str;
}

///可选值如下 OFF AROUND SMOOTH UPANDDOWN 4BORDERS INLINE
+ (NSString *)decoStringOfVTShadow:(VTShadow)vtshadow{
    NSString *str = @"";
    switch (vtshadow) {
        case VTShadowNone:
//            str = @"OFF";
            break;
        case VTShadowAround:
            str = @"AROUND";
            break;
        case VTShadowSmooth:
            str = @"SMOOTH";
            break;
        case VTShadowUpAndDown:
            str = @"UPANDDOWN";
            break;
        case VTShadow4Borders:
            str = @"4BORDERS";
            break;
        case VTShadowUnderscore:
            str = @"INLINE";
            break;
        default:
            break;
    }
    return str;
}

+ (NSString *)decoStringOfVerticalPos:(CGFloat)verticalPos{
    NSString *str = [NSString stringWithFormat:@"%.2f",verticalPos];
    return str;
}

#pragma mark - NSCoding

+ (NSArray *)integerProperties{
    NSArray *a = @[
                   @"align",
                   @"letterSpacing",
                   @"lineSpacing",
                   @"textColor",
                   @"fontSize",
                   @"textLineCount",
                   @"vtshadow",
                   ];
    return a;
}

+ (NSArray *)floatProperties{
    NSArray *a = @[
                   @"verticalPos",
                   @"standardFontSizeValue",
                   @"fontSizeValue",
//                   @"fontSizeRatio",
//                   @"lineSpacingRatio",
//                   @"letterSpacingRatio"
                   ];
    return a;
}

+ (NSArray *)objectProperties{
    NSArray *a = @[
//                   @"fontName",
                   @"text",
//                   @"textNoTranditionalNoUpper",
                   @"maxWidthLine",
                   @"maxGlyphLine",
                   @"shadow",
                   @"fontType",
//                   @"font",
//                   @"textColorValue",
//                   @"backgroundColorValue"
                   ];
    return a;
}

- (id)initWithCoder:(NSCoder *)decoder {
    self = [super init];
    if (self) {
        for (NSString *key in [self.class integerProperties]) {
            NSInteger a = [decoder decodeIntegerForKey:key];
            [self setValue:@(a) forKey:key];
        }
        for (NSString *key in [self.class floatProperties]) {
            CGFloat a = [decoder decodeFloatForKey:key];
            [self setValue:@(a) forKey:key];
        }
        for (NSString *key in [self.class objectProperties]) {
            NSObject *a = [decoder decodeObjectForKey:key];
            [self setValue:a forKey:key];
        }
        _fontDescriptor = [decoder decodeObjectOfClass:[VTFontDescriptor class] forKey:@"fontDescriptor"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    for (NSString *key in [self.class integerProperties]) {
        NSNumber *num = [self valueForKey:key];
        [coder encodeInteger:num.integerValue forKey:key];
    }
    for (NSString *key in [self.class floatProperties]) {
        NSNumber *num = [self valueForKey:key];
        [coder encodeFloat:num.floatValue forKey:key];
    }
    for (NSString *key in [self.class objectProperties]) {
        NSObject *obj = [self valueForKey:key];
        [coder encodeObject:obj forKey:key];
    }
    [coder encodeObject:_fontDescriptor forKey:@"fontDescriptor"];
}

- (VTParamObject *)mutableCopy{
    NSData *archive = [NSKeyedArchiver archivedDataWithRootObject:self];
    VTParamObject *new = [NSKeyedUnarchiver unarchiveObjectWithData:archive];
    return new;
}

- (void)generateTextData{
//    UIImage *textImage = [[MovieEditManager sharedInstance]getTextImageWithParamObject:self];
    self.textData = nil;
}

- (void)dealloc{
    NSLog(@"VTParamObject dealloc");
}

@end








