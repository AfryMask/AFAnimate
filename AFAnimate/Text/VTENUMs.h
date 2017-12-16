//
//  VTENUMs.h
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#ifndef VTENUMs_h
#define VTENUMs_h


/// 文字对齐方式
typedef NS_ENUM(NSInteger, VTAlign) {
    VTAlignL,
    VTAlignM,
    VTAlignR,
};
#define VTDefaultAlign VTAlignM

/// 字距
typedef NS_ENUM(NSInteger, VTLetterSpacing) {
    VTLetterSpacingXS,
    VTLetterSpacingS,
    VTLetterSpacingM,
    VTLetterSpacingL,
    VTLetterSpacingXL,
    VTLetterSpacingXXL,
    VTLetterSpacing3XL,
    VTLetterSpacing4XL
};
#define VTDefaultLetterSpacing VTLetterSpacingXS

/// 行距
typedef NS_ENUM(NSInteger, VTLineSpacing) {
    VTLineSpacingXS,
    VTLineSpacingS,
    VTLineSpacingM,
    VTLineSpacingL,
    VTLineSpacingXL,
    VTLineSpacingXXL,
    VTLineSpacing3XL,
    VTLineSpacing4XL
};
#define VTDefaultLineSpacing VTLineSpacingS

/// 文字颜色
typedef NS_ENUM(NSInteger, VTTextColor) {
    VTTextColorWhite,
    VTTextColorBlack
    
};
#define VTDefaultTextColor VTTextColorWhite

/// 字号
typedef NS_ENUM(NSInteger, VTFontSize) {
    VTFontSizeXS,
    VTFontSizeS,
    VTFontSizeM,
    VTFontSizeL,
    VTFontSizeXL,
    VTFontSizeXXL,
    VTFontSize3XL,
    VTFontSize4XL,
};
#define VTDefaultFontSize VTFontSizeM

///效果
typedef NS_ENUM(NSInteger, VTShadow) {
    VTShadowNone,
    VTShadowAround,
    VTShadowSmooth,
    VTShadowUpAndDown,//上下加横线
    VTShadow4Borders,//四个边框
    VTShadowUnderscore,//下划线
};
#define VTDefaultShadow VTShadowSmooth

/// 字体下载进度
typedef NS_ENUM(NSInteger, VTFontDownLoadStatus) {
    VTFontDownLoadStatusNeverDownload,
    VTFontDownLoadStatusDownloaded,
    VTFontDownLoadStatusDownloading,
    VTFontDownLoadStatusDownloadFailed
};
#define VTDefaultFontDownLoadStatus VTFontDownLoadStatusNeverDownload

#endif /* VTENUMs_h */
