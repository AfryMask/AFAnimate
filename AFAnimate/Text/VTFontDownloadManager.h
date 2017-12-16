////
////  VTFontDownloadManager.h
////  Taker
////
////  Created by chuyi on 16/6/23.
////  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import "VTFontDescriptor.h"
///**
//VTFontDownloadManager 只会注册一个字体。再次注册时，会调用unRegisterGraphicsFont，将上一次注册的字体取消注册。
//*/
//@interface VTFontDownloadManager : NSObject
//+ (instancetype)sharedInstance;
//- (NSArray<VTFontDescriptor *> *)getAvailableFontDescriptor;
//- (NSArray<VTFontDescriptor *> *)getAllFontDescriptor;
//- (void)downloadWithFontDescriptor:(VTFontDescriptor *)font;
//- (VTFontDescriptor *)defaultFont;
//
///**
// 返回font.fontRealName。在注册之前font.fontRealName其实就就已经存在了！并不是在这个方法中获取的。
// 如果这个font已经注册了，不再注册，直接返回fontRealName。未注册，先unRegisterGraphicsFont再注册字体。
// */
//- (NSString *)registerGraphicsFont:(VTFontDescriptor *)font;
//
///**
// 当不再需要使用字体时，需要取消注册。（cameraVC关闭后就应该取消注册）。
// */
//- (void)unRegisterGraphicsFont;
//
//
///// 在FilterVC第一次弹出inputView时注册默认字体
//+ (void)registerDefaultFont;
//@end

