//
//  SpecificValueDefinitions.h
//  Taker
//
//  Created by chuyi on 2017/3/22.
//  Copyright © 2017年 com.pepsin.fork.video_taker. All rights reserved.
//

#ifndef SpecificValueDefinitions_h
#define SpecificValueDefinitions_h

#define kSpecificModelButtonWidth 44
#define kSpecificDetailLeftPadding 15

#define kStabilizerButtonHeight (65)

// 效果的调节类型
// 更改枚举后必须更改SpecificFilterGroup 中的 allAdjustValueKey 和 allAdjustModeKey
typedef NS_ENUM( NSInteger, SpecificAdjustType ) {
    SpecificAdjustTypeNon, // 不调节
    SpecificAdjustTypeFilter, // 滤镜强度
    //调色
    SpecificAdjustTypeExposure, // 曝光
    SpecificAdjustTypeContrast, // 对比度
    SpecificAdjustTypeSaturation, // 饱和度
    SpecificAdjustTypeWhiteBalance, // 白平衡
    SpecificAdjustTypeTint, // 色调
    SpecificAdjustTypeSharpen, // 锐化
    //修饰
    SpecificAdjustTypeGrain, // 颗粒
    SpecificAdjustTypeDarkCorner, // 暗角
    SpecificAdjustTypeLeak, // 漏光
    SpecificAdjustTypeTilt, // 柔化
    
    //高级调色
    SpecificAdjustTypeFade, // 褪色
    SpecificAdjustTypeHighlightsSave, // 高光减淡
    SpecificAdjustTypeShadowsSave, // 阴影加亮
    SpecificAdjustTypeSky, // 天空
    //形变
    SpecificAdjustTypeProportion, // 比例
    SpecificAdjustTypeRotate, // 旋转
    SpecificAdjustTypeScaleV, // 垂直畸变
    SpecificAdjustTypeScaleH, // 水平畸变
    //特殊变换
    SpecificAdjustTypeMirror, // 镜像
    SpecificAdjustTypeBeauty, // 美颜
};

#define kSpecificAdjustTypeCount (16)

// 旋转调节类型中的 旋转方向按钮
typedef NS_ENUM( NSInteger, SpecificRotateMode ) {
    SpecificRotateModeUp,
    SpecificRotateModeLeft,
    SpecificRotateModeDown,
    SpecificRotateModeRight,
};

// 暗角调节类型中的 暗角模式
typedef NS_ENUM( NSInteger, SpecificDarkCornerMode ) {
    SpecificDarkCornerModeCamera,
    SpecificDarkCornerModeFilm,
};

// 镜像调节类型中的 保留位置
typedef NS_ENUM( NSInteger, SpecificMirrorMode ) {
    SpecificMirrorModeNon,
    SpecificMirrorModeUp,
    SpecificMirrorModeLeft,
    SpecificMirrorModeDown,
    SpecificMirrorModeRight,
};

// 比例调节类型中的 画幅比例
typedef NS_ENUM( NSInteger, SpecificProportionMode) {
    SpecificProportionModeNon,
    SpecificProportionMode16_9,
    SpecificProportionMode4_3,
    SpecificProportionMode3_2,
    SpecificProportionMode1_1,
    SpecificProportionMode2_3,
    SpecificProportionMode3_4,
    SpecificProportionMode9_16,
};

// 颗粒
typedef NS_ENUM( NSInteger, SpecificGrainMode) {
    SpecificGrainMode400,
};

// 漏光
typedef NS_ENUM( NSInteger, SpecificLeakMode) {
    SpecificLeakMode01,
    SpecificLeakMode02,
    SpecificLeakMode03,
    SpecificLeakMode04,
};

// 漏光保留
typedef NS_ENUM( NSInteger, SpecificLeakSaveOrientation) {
    SpecificLeakSaveOrientationNon,
    SpecificLeakSaveOrientationTop,
    SpecificLeakSaveOrientationLeft,
    SpecificLeakSaveOrientationBottom,
    SpecificLeakSaveOrientationRight,
};

// 漏光的方向
typedef NS_ENUM( NSInteger, SpecificLeakSubMode) {
    SpecificLeakSubModeDefault,
    SpecificLeakSubModeV,
    SpecificLeakSubModeH,
    SpecificLeakSubModeHV,
};

#endif /* SpecificValueDefinitions_h */
