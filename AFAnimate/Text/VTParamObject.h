//
//  VTParamObject.h
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VTENUMs.h"
@class StoryFilterDecoModel;

#define kVTParamDidChangeNotif @"kVTParamChangeNotif"//object是VTParamObject类型。在手势识别之后会发送这个通知

@class VTFontDescriptor;

@class VTParamObject;
@protocol VTParamObjectDelegate <NSObject>
@optional
- (void)vtParamObject:(VTParamObject *)paramObj didChangedText:(NSString *)text;

@end

///用new创建后，值都是0
@interface VTParamObject : NSObject<NSCoding>

///----这些是可以设置的值
@property (nonatomic, weak) id<VTParamObjectDelegate> delegate;
@property (nonatomic,assign) VTAlign align;
@property (nonatomic,assign) CGFloat verticalPos;//这是delta值,表示偏移量。正数是向下移动，负数向上移动
@property (nonatomic,assign) VTLetterSpacing letterSpacing;
@property (nonatomic,assign) VTLineSpacing lineSpacing;
@property (nonatomic,assign) VTTextColor textColor;
@property (nonatomic,assign) VTFontSize fontSize; ///<从XS到4XL 共8档。寻找最优解时从这个字号开始，设置letterSpacing或文字太多可能导致实际字号比此值小。
@property (nonatomic,readonly) NSString *fontName; ///<字体名，从fontDescriptor中取出
@property (nonatomic,strong) VTFontDescriptor *fontDescriptor;///< 用这个属性保存，滤镜页已选中字体
@property (nonatomic,strong) NSString *text;///< 如果需要读取繁体，先看_traditionalText，有了就不转换了。即lazy create
@property (nonatomic,strong) NSString *userInputText; ///< 用户输入的文字，可能是繁简混合，用在输入框
@property (nonatomic,assign) NSInteger textLineCount;///< text行数，懒加载
@property (nonatomic,readonly) NSString *textNoTranditionalNoUpper;///< 传递到PostViewController
@property (nonatomic,strong) NSString *maxWidthLine;///< 计算出最宽的行，保存在这个变量中
@property (nonatomic,strong) NSString *maxGlyphLine;///< 计算出字形最多的行，保存在这个变量中
@property (nonatomic,assign) VTShadow vtshadow;///< 枚举类型，设置这个值内部会修改shadow
@property (nonatomic,strong) NSShadow *shadow;///<单位为px

@property (nonatomic,assign) CGFloat standardFontSizeValue;///< 标准fontSize，即视频短边的0.1。也是左右空白距离
@property (nonatomic,assign) CGFloat fontSizeValue;///<fontSize对应字体的pointSize。就是standardFontSizeValue*fontSizeRatio

///---- 上面设置的是enum，需要用value。可以用下面这些方法取
@property (nonatomic,readonly) UIFont *font;///<fontSize对应的字体。获取的字体是fontName结合fontSize。
- (UIFont *)fontWithPointSize:(CGFloat)pointSize; ///<使用self.fontName，传入pointSize

@property (nonatomic,readonly) CGFloat fontSizeRatio;
@property (nonatomic,readonly) CGFloat lineSpacingRatio;
@property (nonatomic,readonly) CGFloat letterSpacingRatio;///<这是比例！
@property (nonatomic,readonly) UIColor *textColorValue;
@property (nonatomic,readonly) UIColor *backgroundColorValue;

//字体效果组合
@property (nonatomic,strong) NSString *fontType;

///调用这个方法，会设置为默认值
- (void)applyDefaulValue;

///如果fontDescriptor还没有设置过，则使用defaultFontDescriptor。检测完注册字体。在绘制前会调用此方法。
- (void)checkFontDescriptorAndRegister;

///fontSizeCalcResult是计算出来的字体。scale是屏幕scale，绘制图片时scale应该是1。这个方法中不会修改self.shadow
- (NSShadow *)shadowWithFontSizeCalcResult:(CGFloat)fontSizeCalcResult scale:(CGFloat)scale;

///向服务器传加字信息
- (StoryFilterDecoModel *)decoModelRepresentation;

///滤镜加字
- (void)generateTextData;
@property (nonatomic)UIImage *textData;
@end
