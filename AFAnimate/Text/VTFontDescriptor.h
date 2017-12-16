//
//  VTFontDescriptor.h
//  Taker
//
//  Created by chuyi on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDataModel.h"
#import "VTENUMs.h"

@interface VTFontDescriptor : BaseDataModel <NSCoding>
@property (nonatomic) NSString *name;///飞猪给的json中有，代码仅用来log
@property (nonatomic) NSString *filename;///文件名
@property (nonatomic) NSString *fonttype;///只有两个可能值：ttf和oft
@property (nonatomic) NSString *language;
@property (nonatomic) NSString *url;/// 有url表示需要下载，没有url表示bundle自带的字体
@property (nonatomic) NSNumber *size;///文件大小，本地文件没有这个属性
@property (nonatomic) NSNumber *defaultFont;///默认字体, 对应json文件的default
@property (nonatomic) NSString *cnonly; //"simplified"强制转化为简体字，“traditional”强制转化为繁体字
@property (nonatomic) NSNumber *borderwidth;
@property (nonatomic) NSNumber *capitalized;
@property (nonatomic) NSNumber *lineheightoffset;
@property (nonatomic) NSNumber *invisible;

@property (nonatomic) VTFontDownLoadStatus downloadStatus;
@property (nonatomic) float downloadPercent;
@property (nonatomic) NSString *fontPath; ///VTFontDownloadManager会设置path，系统的本地路径
/**
 VTFontDownloadManager创建时，对于文件本地已存在的字体直接设置好fontRealName。下载完成时，也设置一次fontRealName。
 用这种方法创建UIFont:
 [[VTFontDownloadManager camInstance] registerGraphicsFont:fontDescriptor]
 [UIFont fontWithName:fontRealName
 */
@property (nonatomic) NSString *fontRealName;

- (instancetype)initWithDict:(NSDictionary *)dict;
@end
