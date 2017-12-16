//
//  VTContainerView.m
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "VTContainerView.h"
#import "VTParamObject.h"
#import "GlobalMacros.h"
#import "NSAttributedString+VideoText.h"
#import "VTTextAttribute.h"
#import "NSString+VideoText.h"
#import "UIView+DrawCross.h"
#import "NSShadow+VideoText.h"
#import "VTFontDescriptor.h"
#import "UIView+APUtils.h"
//#import "MovieEditManager.h"

#define YY_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))

#define RGBColor(rgbValue, alphaValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:alphaValue]
#define colorGold               RGBColor(0xae995a, 1)

typedef BOOL(^VTContainerViewCanFullContain)(float fontSize);

@interface VTContainerView ()
@property (nonatomic,assign) CGPoint textCenterInSuperView;
@property (nonatomic,assign) CGFloat fontSize_calcResult;
@property (nonatomic,assign) CGFloat scaleUsedInDrawRect;//本应是从CGContext中取得，但是找不到取scale的方法。所以保存一个值
@property (nonatomic,assign) BOOL gestureToggledOn; //YES表示已打开（显示iconView中）
@end

@implementation VTContainerView
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.paramObj = [VTParamObject new];
        [self.paramObj applyDefaulValue];
        self.backgroundColor = [UIColor clearColor];
        self.needDrawDashRect = NO;
        self.scaleUsedInDrawRect = [UIScreen mainScreen].scale;
    }
    return self;
}

- (CGFloat)drawingHeight{
    VTTextAttribute *attr = [self vtTextAttrWithCalcResult];
    return [self drawingHeightWithAttr:attr];
}

- (void)setParamObj:(VTParamObject *)paramObj {
    _paramObj = paramObj;
}

///"文字" 的高度，包括下划线。可能比self.height大，可能比self.height小。
- (CGFloat)drawingHeightWithAttr:(VTTextAttribute *)attr{
    if (self.paramObj.text.length == 0) {
        return 0;
    }

    NSString *text = self.paramObj.text;
    NSArray *lines = text.lines;
    CGFloat drawingY = 0;//初始绘制时，y为0
    CGFloat lineSpacing = attr.fontSize * self.paramObj.lineSpacingRatio;
    CGFloat ascendDescend = attr.ascendDescend;
//    NSLog(@"ascendDescend = %f",attr.ascendDescend);
    for (NSInteger i=0; i<lines.count; i++) {
        //每次绘制完一行修改drawingY
        drawingY += ascendDescend;

        BOOL needUnderscore = (self.paramObj.vtshadow == VTShadowUnderscore)&&(lines.count == 1/*仅一行*/ || (i < lines.count - 1)/*多行且不为最后一行*/);
        if (needUnderscore) {
            drawingY += [self underscoreToTextSpaceWithFontSize:attr.fontSize];
            drawingY += [self underscoreThicknessWithFontSize:attr.fontSize];
            if (lines.count > 1) {//多行时，需要可以加间距（仅一行时，不用加这个间距了）
                drawingY += [self underscoreToTextSpaceWithFontSize:attr.fontSize];
            }
        } else {
            //不需要下划线，只需要lineSpacing。最后一行不加lingSpacing，普通行需要加
            BOOL isLastLine = (i == lines.count -1);
            if (!isLastLine) {
                drawingY += lineSpacing;
            }
        }
    }

    return drawingY;
}


///"文字+边框"的高度
- (CGFloat)totalDrawingHeightWithDrawingHeight:(CGFloat)drawingHeight{
    CGFloat result = drawingHeight;

    if (_paramObj.vtshadow == VTShadow4Borders || _paramObj.vtshadow == VTShadowUpAndDown){
        result += 2 * [self borderWidthWithFonSize:self.fontSize_calcResult];
        result += 2 * [self.class borderToTextSpaceWithFontSize:self.fontSize_calcResult];
    }

    CGFloat maxVerticalPos = (self.height - result - _paramObj.standardFontSizeValue * 2 ) * 0.5;// (self.height - result)是所有空白的高度，减去2个inset(_paramObj.standardFontSizeValue)
    self.paramObj.verticalPos = YY_CLAMP(self.paramObj.verticalPos, -maxVerticalPos, maxVerticalPos);//限制范围
    return result;
}

-(CGFloat)getMaxVerticalPos
{
    CGFloat result = [self drawingHeight];
    
    if (_paramObj.vtshadow == VTShadow4Borders || _paramObj.vtshadow == VTShadowUpAndDown){
        result += 2 * [self borderWidthWithFonSize:self.fontSize_calcResult];
        result += 2 * [self.class borderToTextSpaceWithFontSize:self.fontSize_calcResult];
    }
    CGFloat maxVerticalPos = (self.height - result - _paramObj.standardFontSizeValue * 2 ) * 0.5;
    return maxVerticalPos;
}

///最宽行(仅文字) 的宽度
- (CGFloat)drawingWidthWithFontSize:(CGFloat)fontSize{
    if (self.paramObj.text.length == 0) {
        return 0;
    }

    VTTextAttribute *attr = [self vtTextAttrWithCalcResult];
    attr.fontSize = fontSize;
    NSString *maxWidthLine = self.paramObj.maxWidthLine;
    NSString *maxGlyphLine = self.paramObj.maxGlyphLine;

    CGFloat result = 0;
    CGFloat maxWidthLineWidth = [self.class lineWidthWithText:maxWidthLine attr:attr letterSpacingRatio:_paramObj.letterSpacingRatio];
    if ([maxWidthLine isEqualToString:maxGlyphLine]) {
        result = maxWidthLineWidth;
    } else {
        CGFloat maxGlyphLineWidth = [self.class lineWidthWithText:maxGlyphLine attr:attr letterSpacingRatio:_paramObj.letterSpacingRatio];
        result = MAX(maxWidthLineWidth, maxGlyphLineWidth);
    }
    return result;
}

/// "最宽行+边框" 宽度 为了尽量少计算，使用依赖注入
- (CGFloat)totalDrawingWidthWithDrawingWidth:(CGFloat)drawingWidth{
    CGFloat result = drawingWidth;
    if (_paramObj.vtshadow == VTShadow4Borders){
        result += 2 * [self borderWidthWithFonSize:self.fontSize_calcResult];
        result += 2 * [self.class borderToTextSpaceWithFontSize:self.fontSize_calcResult];
    }
    return result;
}

///创建NSAttributedString需要这个对象。必须先调用calcFontSize，再调用此方法。
- (VTTextAttribute *)vtTextAttrWithCalcResult{
    VTTextAttribute *attr = [VTTextAttribute new];
    attr.fontName = self.paramObj.fontName;
    attr.textColor = self.paramObj.textColorValue;
    attr.fontSize = self.fontSize_calcResult;
    CGFloat scaleUseToShadow = self.scaleUsedInDrawRect;
    attr.shadow = [self.paramObj shadowWithFontSizeCalcResult:self.fontSize_calcResult scale:scaleUseToShadow];
    return attr;
}

///注册字体，计算fontSize
- (void)prepareToDraw{
    
    _paramObj.standardFontSizeValue = MIN(self.width,self.height)*0.1;

    [self.paramObj checkFontDescriptorAndRegister];

    self.fontSize_calcResult = [self calcFontSize];
}

///async的话，在后台prepareToDraw，在主线程setNeedDisplay。同步的话，直接调用prepareToDraw和setNeedsDisplay。
- (void)refreshUIAsync:(BOOL)async{
    if (async) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [self prepareToDraw];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setNeedsDisplay];
            });
        });
    } else {
        [self prepareToDraw];
        [self setNeedsDisplay];
    }
}

/// 同步操作
- (void)drawInCurrentContext{
    [self prepareToDraw];
    [self drawRect:CGRectZero];
}

///包括边框和背景，整个的rect
- (CGRect)totalRectWithTotalSize:(CGSize)totalSize{
    CGRect rect = CGRectMake(0, 0, totalSize.width, totalSize.height);

    //找x
    CGFloat borderX = _paramObj.standardFontSizeValue;
    switch (_paramObj.align) {
        case VTAlignL:
            borderX += 0;
            break;
        case VTAlignM:
            borderX += [self drawableWidth]*0.5 - totalSize.width* 0.5;
            break;
        case VTAlignR:
            borderX += [self drawableWidth] - totalSize.width;
            break;
    }
    rect.origin.x = borderX;

    //找y
    CGFloat borderY = 0;
    CGFloat halfTotalHeight = totalSize.height * 0.5;
    borderY = self.height*0.5 - halfTotalHeight + _paramObj.verticalPos;

    rect.origin.y = borderY;
//    NSLog(@"%@",NSStringFromCGRect(rect));
    return rect;
}

- (void)drawBorderAndBackgroundWithTotalSize:(CGSize)totalSize{
    CGRect totalRect = [self totalRectWithTotalSize:totalSize];
    CGFloat borderWidth = [self borderWidthWithFonSize:self.fontSize_calcResult];
    CGFloat halfBorderWidth = borderWidth * 0.5;
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    switch (_paramObj.vtshadow) {
        case VTShadowUpAndDown:{
            CGFloat topLine = totalRect.origin.y + halfBorderWidth;
            CGFloat bottomLine = CGRectGetMaxY(totalRect) - halfBorderWidth;
            CGPoint strokeSegments[] =
            {
                CGPointMake(totalRect.origin.x, topLine),
                CGPointMake(CGRectGetMaxX(totalRect), topLine),
                CGPointMake(totalRect.origin.x, bottomLine),
                CGPointMake(CGRectGetMaxX(totalRect), bottomLine),
            };
            [_paramObj.textColorValue setStroke];
            CGContextSetLineWidth(ctx, borderWidth);
            CGContextStrokeLineSegments(ctx, strokeSegments, sizeof(strokeSegments)/sizeof(CGPoint));
        }
            break;
        case VTShadow4Borders:{
            [_paramObj.textColorValue setStroke];
            CGRect strokeRect = CGRectInset(totalRect, halfBorderWidth, halfBorderWidth);
            CGContextStrokeRectWithWidth(ctx, strokeRect, borderWidth);
        }
            break;
        default:
            break;
    }
}

//字在上下中间的时候，下方出一条金色的线
- (BOOL)shouldShowCenterHorizontalLine{
    BOOL should = (self.paramObj.verticalPos == 0 && self.gestureToggledOn);
    return should;
}

#pragma mark - 绘制编辑状态的虚线边框
- (CGRect)finalRect
{
    CGFloat drawingHeight = [self drawingHeight]; //"文字" 的高度
    CGFloat drawingWidth  = [self drawingWidthWithFontSize:self.fontSize_calcResult];//"文字" 的宽度
    CGFloat totalDrawingHeight = [self totalDrawingHeightWithDrawingHeight:drawingHeight];//加上边框的高度
    CGFloat totalDrawingWidth  = [self totalDrawingWidthWithDrawingWidth:drawingWidth];//加上边框的宽度度
    CGSize totalSize = CGSizeMake(totalDrawingWidth, totalDrawingHeight);
    CGRect totalRect = [self totalRectWithTotalSize:totalSize];
    
    return totalRect;
}

- (CGRect)pureTextRect
{
    CGFloat drawingHeight = [self drawingHeight]; //"文字" 的高度
    CGFloat drawingWidth  = [self drawingWidthWithFontSize:self.fontSize_calcResult];//"文字" 的宽度
    
    return [self totalRectWithTotalSize:(CGSizeMake(drawingWidth, drawingHeight))];// 左右拖动时会出偏差，必须从totalRect缩减而来
}

- (void)drawRect:(CGRect)rect{
//    [self drawCross];
//    [self drawVerticalLineAt:_paramObj.standardFontSizeValue];
//    [self drawVerticalLineAt:self.width - _paramObj.standardFontSizeValue];
//    [self drawHorizontalLineAt:_paramObj.standardFontSizeValue];
//    [self drawHorizontalLineAt:self.height - _paramObj.standardFontSizeValue];

//    BLog(@"getDraw %.2f",self.paramObj.verticalPos);
    
    if ([self shouldShowCenterHorizontalLine]) {
        [self drawHorizontalSolidLineAt:self.height * 0.5 color:colorGold];
    }

    VTTextAttribute *attr = [self vtTextAttrWithCalcResult];
    CGFloat lineSpacing = attr.fontSize * self.paramObj.lineSpacingRatio;
    NSString *text = self.paramObj.text;
    NSArray *lines = text.lines;
    CGFloat drawingHeight = [self drawingHeight];//"文字" 的高度
    CGFloat drawingWidth = [self drawingWidthWithFontSize:self.fontSize_calcResult];
    CGFloat totalDrawingHeight = [self totalDrawingHeightWithDrawingHeight:drawingHeight];//加上边框的高度
    BOOL needDrawBorderOrBackground = (_paramObj.vtshadow > VTShadowAround);
    CGSize totalSize = CGSizeMake([self totalDrawingWidthWithDrawingWidth:drawingWidth], totalDrawingHeight);
    if (needDrawBorderOrBackground) {
        [self drawBorderAndBackgroundWithTotalSize:totalSize];
    }
    if (self.needDrawDashRect) {
        // 绘制虚线
        [self drawRectDashLineAt:self.finalRect];
    }
    
    CGFloat ascendDescend = attr.ascendDescend;
    CGFloat drawingY = [self drawingYWithDrawingHeight:drawingHeight];
    CGFloat drawingYOrigin = drawingY;
    CGFloat drawingXOrigin = [self drawingXWithLineWidth:drawingWidth];
//    [self drawHorizontalLineAt:drawingY];//一行的顶部
//    [self drawHorizontalLineAt:drawingY];//顶部+ascender
//    [self drawHorizontalLineAt:drawingY+fabs(attr.realFont.descender)];//再绘制一条descender

    __block CGFloat maxLineWidth = 0;//记住最大的宽度
    __block CGFloat textCenterX = 0;//获得最大宽度的时候更新textCenterX
    for (NSInteger i=0; i<lines.count; i++) {
        NSString *line = lines[i];

        //此时drawingY是一行的左上角点，因为以baseline为原点绘制，所以加上ascender
        drawingY += attr.realFont.ascender;
        __block CGFloat drawingX = 0;
        [line enumerateSubstringsInRange:NSMakeRange(0, line.length) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString * _Nullable substring, NSRange substringRange, NSRange enclosingRange, BOOL * _Nonnull stop) {
            BOOL isFirstGlyph = (substringRange.location == 0);
            if (isFirstGlyph){
                CGFloat lineWidth = [self.class lineWidthWithText:line attr:attr letterSpacingRatio:_paramObj.letterSpacingRatio];
                drawingX = [self drawingXWithLineWidth:lineWidth];
                if (lineWidth > maxLineWidth) {
                    maxLineWidth = lineWidth;
                    textCenterX = drawingX + maxLineWidth*0.5;
                }
//                NSLog(@"textCenterX:%.2f",textCenterX);
            }

            NSAttributedString *glyphAs = [[NSAttributedString alloc]initWithString:substring vtTextAttribute:attr];//glyph 一个字符图形
            CGFloat glyphWidth =[glyphAs vtNoWrapWidth];
            CGRect rectToDraw = CGRectMake(drawingX, drawingY, glyphWidth, ascendDescend);
//            NSLog(@"draw %@,at %.0f,%.0f",substring,drawingX,drawingY);
            [glyphAs drawWithRect:rectToDraw options:0 context:nil];
            //每次绘制完一个 字形，修改drawingX
            drawingX += glyphWidth + (attr.fontSize *self.paramObj.letterSpacingRatio);
        }];

        //每次绘制完一行修改drawingY
        drawingY += fabs(attr.realFont.descender);
        BOOL needUnderscore = (self.paramObj.vtshadow == VTShadowUnderscore)&&(lines.count == 1/*仅一行*/ || (i < lines.count - 1)/*多行且不为最后一行*/);
        if (needUnderscore) {
            drawingY += [self underscoreToTextSpaceWithFontSize:attr.fontSize];
            drawingY += [self underscoreThicknessWithFontSize:attr.fontSize] * 0.5;
            [self.class drawLineAtPoint:CGPointMake(drawingXOrigin, drawingY) length:drawingWidth thick:[self underscoreThicknessWithFontSize:attr.fontSize] color:self.paramObj.textColorValue];
            drawingY += [self underscoreThicknessWithFontSize:attr.fontSize] * 0.5;
            if (lines.count > 1) {//多行时，需要可以加间距（仅一行时，不用加这个间距了）
                drawingY += [self underscoreToTextSpaceWithFontSize:attr.fontSize];
            }
        } else {
            //不需要下划线，只需要lineSpacing。最后一行不加lingSpacing，普通行需要加
            BOOL isLastLine = (i == lines.count -1);
            if (!isLastLine) {
                drawingY += lineSpacing;
            }
        }
    }
    
    CGPoint textCenter = CGPointMake(textCenterX, drawingYOrigin+drawingHeight*0.5);
    CGPoint textCenterInSuperView;
    if (self.superview) {
        textCenterInSuperView = [self convertPoint:textCenter toView:self.superview];
    }else{
        textCenterInSuperView = CGPointMake(1, 1);
    }
    self.textCenterInSuperView = textCenterInSuperView;
    
}

/// 这条线的长度length，thick这条线的宽度（厚度）
+ (void)drawLineAtPoint:(CGPoint)point length:(CGFloat)length thick:(CGFloat)thick color:(UIColor *)color{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSaveGState(ctx);
    [color set];

    CGContextSetLineWidth(ctx, thick);
//    NSLog(@"thick: %.1f",thick);
    CGPoint endPoint = point;
    endPoint.x = point.x + length;
    CGPoint strokeSegments[] =
    {
        //横线
        point,
        endPoint,
    };

    CGContextStrokeLineSegments(ctx, strokeSegments, 2);
    CGContextRestoreGState(ctx);
}

#pragma mark -
#pragma mark - 获取图片
- (UIImage *)getImageWithVideoSize:(CGSize)size{
    
    __block UIImage *resultImage;
    void(^block)(void) = ^() {
        //修改scale、verticalPos和frame
        self.scaleUsedInDrawRect = 1.0;
        CGFloat verticalPosBeforeChange = self.paramObj.verticalPos;
        CGFloat posScale = self.paramObj.verticalPos / self.height;
        self.paramObj.verticalPos = size.height * posScale;  // 取图时的位置需要乘以scale
        
        CGRect frameBeforeChange = self.frame;
        self.width = size.width;
        self.height = size.height;
        
        //修改阴影offset
        CGSize shadowSizeBeforeChange = self.paramObj.shadow.shadowOffset;
        CGSize changeSize = CGSizeMake(shadowSizeBeforeChange.width * 1.5, shadowSizeBeforeChange.height * 1.5);
        self.paramObj.shadow.shadowOffset = changeSize;
        //修改阴影radius
        CGFloat shadowRadiusBeforeChange = self.paramObj.shadow.shadowBlurRadius;
        CGFloat changeRadius = shadowRadiusBeforeChange * 1.5;
        self.paramObj.shadow.shadowBlurRadius = changeRadius;
        //修改阴影alpha
//        CGFloat shadowAlphaBeforeChange = self.paramObj.shadow.shadowAlpha;
//        CGFloat changeAlpha = shadowAlphaBeforeChange * 1.5;
//        self.paramObj.shadow.shadowBlurRadius = changeAlpha;
        
        //绘制
        UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);//指定context的scale为1.0
        
        [self drawInCurrentContext];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();

        //恢复
        self.paramObj.shadow.shadowOffset = shadowSizeBeforeChange;
        self.paramObj.shadow.shadowBlurRadius = shadowRadiusBeforeChange;
//        self.paramObj.shadow.shadowAlpha = shadowAlphaBeforeChange;
        
        self.scaleUsedInDrawRect = [UIScreen mainScreen].scale;
        self.paramObj.verticalPos = verticalPosBeforeChange;
        self.frame = frameBeforeChange;

        [self prepareToDraw];//恢复以前的standardFontSizeValue值，这是必要的步骤
    };

    BOOL currentInMain = [[NSThread currentThread] isEqual: [NSThread mainThread]];
    if (currentInMain) {
        block();
    } else {
        dispatch_sync(dispatch_get_main_queue(), ^{
            block();
        });
    }

    return resultImage;
}

///可以绘制文字的部分，即中间部分。总是比self.width小
- (CGFloat)drawableWidth{
    CGFloat drawableWidth = self.width - _paramObj.standardFontSizeValue * 2;
    return drawableWidth;
}

- (CGFloat)drawableHeight{
    CGFloat drawableWidth = self.height - _paramObj.standardFontSizeValue * 2;
    return drawableWidth;
}


/// 文字的顶部。绘制时指定baseline（需要+ascender）。 要求你传入drawingHeight，表示此方法严重依赖于drawingHeight
- (CGFloat)drawingYWithDrawingHeight:(CGFloat)drawingHeight{
    CGFloat drawingY = 0;
    CGFloat halfDrawingHeight = drawingHeight * 0.5;
    drawingY = self.height*0.5 - halfDrawingHeight + _paramObj.verticalPos;//在centerY的基础上增加delta
    return drawingY;
}

/// 文字的x坐标
- (CGFloat)drawingXWithLineWidth:(CGFloat)lineWidth{
    //如果有边框，先把边框（和空白距离）算进去
    CGFloat borderAndSpace = 0;
    if (_paramObj.vtshadow == VTShadow4Borders){
        borderAndSpace += [self borderWidthWithFonSize:self.fontSize_calcResult];
        borderAndSpace += [self.class borderToTextSpaceWithFontSize:self.fontSize_calcResult];
    }

    CGFloat drawingX = _paramObj.standardFontSizeValue;  //距离屏幕左边 0.1短边宽
    switch (_paramObj.align) {
        case VTAlignL:
            drawingX += borderAndSpace;
            break;
        case VTAlignM:
            drawingX += [self drawableWidth]*0.5 - lineWidth*0.5;
            break;
        case VTAlignR:
            drawingX += [self drawableWidth] - borderAndSpace - lineWidth;
            break;
    }
    return drawingX;
}

/// 计算字体大小
- (CGFloat)calcFontSize{
    UIFont *font = self.paramObj.font;
    NSString *maxWidthLine = [self.paramObj.text maxWidthLineWithFont:font];
    NSString *maxGlyphLine = [self.paramObj.text maxGlypthLine];
    self.paramObj.maxWidthLine = maxWidthLine;
    self.paramObj.maxGlyphLine = maxGlyphLine;

    __weak __typeof(self) weakSelf=self;
    VTContainerViewCanFullContain canFullContainBlock = ^(float fontSize){
        VTTextAttribute *attr = [VTTextAttribute new];
        attr.fontName = weakSelf.paramObj.fontName;
        attr.fontSize = fontSize;
        CGFloat scaleUseToShadow = self.scaleUsedInDrawRect;
        attr.shadow = [weakSelf.paramObj shadowWithFontSizeCalcResult:attr.fontSize scale:scaleUseToShadow];
        const CGFloat drawingWidth = [weakSelf drawingWidthWithFontSize:fontSize];
        const CGFloat textHeight = [weakSelf drawingHeightWithAttr:attr];

        CGFloat lineWidthWithEffect = drawingWidth;//加上效果后的宽度
        CGFloat textHeightWithEffect = textHeight;
        if (weakSelf.paramObj.vtshadow == VTShadow4Borders) { // 宽度加2个边框的宽度再+2个边框到文字的距离
            lineWidthWithEffect += [weakSelf.class borderToTextSpaceWithFontSize:fontSize]*2;
            lineWidthWithEffect += [weakSelf borderWidthWithFonSize:fontSize] * 2;

            textHeightWithEffect += [weakSelf.class borderToTextSpaceWithFontSize:fontSize]*2;
            textHeightWithEffect += [weakSelf borderWidthWithFonSize:fontSize] * 2;
        } else if (weakSelf.paramObj.vtshadow == VTShadowUpAndDown) {
            textHeightWithEffect += [weakSelf.class borderToTextSpaceWithFontSize:fontSize]*2;
            textHeightWithEffect += [weakSelf borderWidthWithFonSize:fontSize] * 2;
        }

        BOOL canFullContain_Width = (lineWidthWithEffect <= [self drawableWidth]);
        BOOL canFullContain_Height = (textHeightWithEffect <= [self drawableHeight]);

        BOOL canFullContain = canFullContain_Width && canFullContain_Height;
        return canFullContain;
    };

    CGFloat fontSizeValue = floor(self.paramObj.fontSizeValue  * self.scaleUsedInDrawRect)/self.scaleUsedInDrawRect;//第一次尝试标准fontsize
    BOOL canFullContain = canFullContainBlock(fontSizeValue);

    if (canFullContain) {
        return fontSizeValue;
    } else {
        CGFloat binarySearchResultFontSize = [self.class binarySearchWithMinFontSize:1.0/self.scaleUsedInDrawRect maxFontSize:fontSizeValue canFullContainBlock:canFullContainBlock];
        return binarySearchResultFontSize;
    }
}

///获取borderWidth时可能还没有self.fontSize_calcResult
- (CGFloat) borderWidthWithFonSize:(CGFloat)fontSize{
    CGFloat scale = [self scaleCompareWith1010];
    CGFloat width = scale * (CGFloat)_paramObj.fontDescriptor.borderwidth.integerValue;//单位是px
    width *= [self fontRealScaleWithFontSize:fontSize];//根据字体比例缩放。 单位仍是px
    width /= self.scaleUsedInDrawRect; //单位是pt
    return width;
}

- (CGFloat) underscoreThicknessWithFontSize:(CGFloat)fontSize{
    CGFloat scale = [self scaleCompareWith1010];
    CGFloat thick = scale * 2;//单位是px
    thick *= [self fontRealScaleWithFontSize:fontSize];//根据字体比例缩放。 单位仍是px
    thick = MAX(thick, 1.0);//最小值1.0px
    thick /= self.scaleUsedInDrawRect; //单位是pt
    return thick;
}

- (CGFloat) underscoreToTextSpaceWithFontSize:(CGFloat)fontSize{
    CGFloat scale = [self scaleCompareWith1010];
    CGFloat space = scale * 50;//单位是px
    space *= [self fontRealScaleWithFontSize:fontSize];//根据字体比例缩放。 单位仍是px
    space /= self.scaleUsedInDrawRect; //单位是pt

    CGFloat lineSpacing = fontSize * self.paramObj.lineSpacingRatio;
    space += lineSpacing;

    return space;
}

- (CGFloat) fontRealScaleWithFontSize:(CGFloat)fontSize{
    CGFloat scale = fontSize/self.paramObj.standardFontSizeValue;
    return scale;
}

///标准短边是1010px。当view短边为1010px时，scale为1。 当view短边为505时，scale为0.5。
- (CGFloat) scaleCompareWith1010{
    CGFloat scale = MIN(self.height,self.width) * self.scaleUsedInDrawRect / 1010;
    return scale;
}

///上下横线、四周边框 时才会用这个方法
+ (CGFloat) borderToTextSpaceWithFontSize:(CGFloat)fontSize{
    CGFloat space =  0.5 * fontSize;
    return space;
}

#pragma mark - VTGestureViewDelegate
#ifndef YY_CLAMP // return the clamped value
#define YY_CLAMP(_x_, _low_, _high_)  (((_x_) > (_high_)) ? (_high_) : (((_x_) < (_low_)) ? (_low_) : (_x_)))
#endif

#pragma mark -
#pragma mark - 手势代理

- (void)postParamObjChangeNotif{
    [[NSNotificationCenter defaultCenter]postNotificationName:kVTParamDidChangeNotif object:self.paramObj];
}

#pragma mark - class method
+ (CGFloat)binarySearchWithMinFontSize:(CGFloat)minFontSize maxFontSize:(CGFloat)maxFontSize canFullContainBlock:(VTContainerViewCanFullContain) canFullContainBlock {
    CGFloat delta = minFontSize;
    CGFloat lastBest = minFontSize, minInCurrentLoop = minFontSize, maxInCurrentLoop = maxFontSize - delta, mid;
    while (minInCurrentLoop <= maxInCurrentLoop) {
        mid = (minInCurrentLoop + maxInCurrentLoop)*0.5;
        BOOL canFullContain = canFullContainBlock(mid);
        if (canFullContain) {
            lastBest = minInCurrentLoop;
            minInCurrentLoop = mid + delta;
//            NSLog(@"minInCurrentLoop:%.2f",minInCurrentLoop);
        } else {
            maxInCurrentLoop = mid - delta;
            lastBest = maxInCurrentLoop;
//            NSLog(@"maxInCurrentLoop:%.2f",maxInCurrentLoop);
        }
    }
    // make sure to return last best
    // this is what should always be returned
    return lastBest;
}


// 文字宽+字距宽。字宽依据attr中给定的fontSize计算得到
+ (CGFloat)lineWidthWithText:(NSString *)line attr:(VTTextAttribute *)attr letterSpacingRatio:(CGFloat)letterSpacingRatio{
    NSAttributedString *as = [[NSAttributedString alloc]initWithString:line vtTextAttribute:attr];
    CGFloat pureTextWidth = [as vtNoWrapWidth];
    CGFloat letterSpacingWidth = (line.glyphCount-1) * (attr.fontSize * letterSpacingRatio);
    CGFloat totalWidth = pureTextWidth + letterSpacingWidth;
    return totalWidth;
}

- (void)setFrame:(CGRect)frame {
    [super setFrame:frame];
    NSLog(@"VTFrame = %@",NSStringFromCGRect(frame));
}

@end
