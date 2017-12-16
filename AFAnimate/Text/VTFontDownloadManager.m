////
////  VTFontDownloadManager.m
////  Taker
////
////  Created by chuyi on 16/6/23.
////  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
////
//
//#import "VTFontDownloadManager.h"
//#import <UIKit/UIKit.h>
//#import "VTFontDescriptorSessionManager.h"
//#import <CoreText/CoreText.h>
//#import "GlobalMacros.h"
//#import "VTENUMs.h"
//#import "CFunctions.h"
//
//@interface VTFontDownloadManager ()
//@property (nonatomic) NSArray<VTFontDescriptor *> *fonts;
//@property (nonatomic) NSMutableArray *downloadingUrls;
//@property (nonatomic) NSFileManager *fileManager;
//@property (nonatomic) VTFontDescriptor *lastFont;///< 最近注册的字体
//@end
//
//@implementation VTFontDownloadManager
//
//+ (instancetype)sharedInstance
//{
//    static id sharedInstance = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        sharedInstance = [[self alloc] init];
//    });
//    return sharedInstance;
//}
//
//- (instancetype)init{
//    if (self = [super init]) {
//        self.downloadingUrls = [NSMutableArray array];
//        
//        self.fileManager = [NSFileManager defaultManager];
//        NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = documentDirectory.lastObject;
//        NSString *fontsFolderPath = [NSString stringWithFormat:@"%@/%@",documentsDirectory,@"fonts"]; // 文件夹路径
//        
//        NSString *fontsBundleFolderPath = [[NSBundle mainBundle] resourcePath];
//        NSString *fontsBundleJSONPath = [NSString stringWithFormat:@"%@/%@", fontsBundleFolderPath, @"fonts.json"]; // bundle的fonts.json路径
//        
//        // 保证文件夹存在
//        BOOL isDir = YES;
//        BOOL isDirExist = [self.fileManager fileExistsAtPath:fontsFolderPath isDirectory:&isDir];
//        if (!isDirExist) {
//            BOOL bCreateDir = [self.fileManager createDirectoryAtPath:fontsFolderPath withIntermediateDirectories:YES attributes:nil error:nil];
//            if (!bCreateDir) {
//                NSLog(@"文件夹创建失败");
//            }
//        }
//        
//        NSData *fontsData = [[NSData alloc] initWithContentsOfFile:fontsBundleJSONPath];
//        NSMutableArray *tempArr = [NSMutableArray array];
//        NSError *error = nil;
//        NSArray *fontsArr = [NSJSONSerialization JSONObjectWithData:fontsData options:NSJSONReadingAllowFragments error:&error];
//        for (NSDictionary *dict in fontsArr) {
//            VTFontDescriptor *font = [[VTFontDescriptor alloc]initWithDict:dict];
//            
//            // 如果程序包里有字体
//            NSString *path;
//            if (font.downloadStatus == VTFontDownLoadStatusDownloaded) {
//                if ([font.language isEqualToString:@"en"]) {
//                    path = [NSString stringWithFormat:@"%@/%@.%@",fontsBundleFolderPath,font.filename,font.fonttype];
//                }else{
//                    path = [NSString stringWithFormat:@"%@/%@.%@",fontsBundleFolderPath,font.filename,font.fonttype];
//                }
//                font.fontPath = path;
//                font.downloadPercent = 1.0;
//                [tempArr addObject:font];
//            }else if (font.url.length > 0){
//                // 如果程序包里没有字体，本地有字体：注册字体，变更状态
//                path = [VTFontDescriptorSessionManager filePathForURLString:font.url];
//                BOOL exists = [self.fileManager fileExistsAtPath:path];
//                if (exists) {
//                    font.fontPath = path;
//                    font.fontRealName = [self getFontNameWithPath:path];
//                    if (font.fontRealName.length == 0){
//                        continue;
//                    }
//                    font.downloadStatus = VTFontDownLoadStatusDownloaded;
//                    font.downloadPercent = 1.0;
//                }else{
//                    font.fontPath = @"";
//                    font.downloadStatus = VTFontDownLoadStatusNeverDownload;
//                    font.downloadPercent = 0.0;
//                }
//                [tempArr addObject:font];
//            }
//        }
//        self.fonts = tempArr;
//        
//    }
//    
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fontDownloading:) name:kNotification_FontDownloading object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fontDownloaded:) name:kNotification_FontDownloaded object:nil];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(fontDownloadField:) name:kNotification_FontDownloadField object:nil];
//    
//    return self;
//}
//
//
//- (void)dealloc{
//    [kDefaultNotificationCenter removeObserver:self];
//}
//
//#pragma mark - download
//
//- (void)fontDownloading:(NSNotification *)notification{
//    NSString *currentUrl = notification.object;
//    [self.downloadingUrls removeObject:notification.object];
//    for (VTFontDescriptor *font in self.fonts) {
//        if ([font.url isEqualToString:currentUrl]) {
//            font.downloadStatus = VTFontDownLoadStatusDownloading;
//            NSDictionary *dict = notification.userInfo;
//            NSNumber *process = dict[@"fractionCompleted"];
//            font.downloadPercent = process.floatValue;
//        }
//    }
//}
//
//- (void)fontDownloaded:(NSNotification *)notification{
//    NSString *currentUrl = notification.object;
//    [self.downloadingUrls removeObject:notification.object];
//    for (VTFontDescriptor *font in self.fonts) {
//        if ([font.url isEqualToString:currentUrl]) {
//            NSString *path = [VTFontDescriptorSessionManager filePathForURLString:font.url];
//            BOOL exists = [self.fileManager fileExistsAtPath:path];
//            if (exists) {
//                font.fontPath = path;
//                font.downloadStatus = VTFontDownLoadStatusDownloaded;
//                font.downloadPercent = 1.0;
//                NSLog(@"字体（%@）下载完成",font.name);
//            }
//        }
//    }
//}
//
//- (void)fontDownloadField:(NSNotification *)notification{
//    NSString *currentUrl = notification.object;
//    [self.downloadingUrls removeObject:notification.object];
//    for (VTFontDescriptor *font in self.fonts) {
//        if ([font.url isEqualToString:currentUrl]) {
//            font.downloadStatus = VTFontDownLoadStatusDownloadFailed;
//            font.downloadPercent = 0.0;
//            NSLog(@"字体（%@）下载失败",font.name);
//        }
//    }
//}
//
//- (NSString *)getFontNameWithPath:(NSString *)path{
//    
//    NSData *inData = [[NSData alloc]initWithContentsOfFile:path];
//    CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
//    CGFontRef fontcg = CGFontCreateWithDataProvider(provider);
//    NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontcg));
//    BOOL error = NO;
//    if (provider){
//        CFRelease(provider);
//    }else{
//        error = YES;
//    }
//    if (fontcg){
//        CFRelease(fontcg);
//    }else{
//        error = YES;
//    }
//    if (error){
//        return nil;
//    }
//    return fontName;
//    
//}
//
//- (NSString *)registerGraphicsFont:(VTFontDescriptor *)vtfont{
//    
//    // 如果已经注册这个字体，直接返回字体名
//    if ([vtfont.fontRealName isEqualToString:self.lastFont.fontRealName]) {
//        NSLog(@"字体（%@）重复使用",vtfont.name);
//        return vtfont.fontRealName;
//    }
//    
//    // 取消上一次注册
//    [self unRegisterGraphicsFont];
//    
//    NSURL *url2 = [NSURL fileURLWithPath:vtfont.fontPath];
//    CFErrorRef cfError = nil;
//    BOOL suc = CTFontManagerRegisterFontsForURL((__bridge CFTypeRef)url2, kCTFontManagerScopeNone, &cfError);
//    if (suc) {
//        NSLog(@"字体（%@）注册成功",vtfont.name);
//    } else {
//        NSError *error = (__bridge NSError *)cfError;
//        NSLog(@"Failed to load font: %@", error);
//    }
//    self.lastFont = vtfont;
//    
//    return vtfont.fontRealName;
//}
//
//- (void)unRegisterGraphicsFont{
//    if (self.lastFont) {
//        CFErrorRef cfError = nil;
//        NSURL *url = [NSURL fileURLWithPath:self.lastFont.fontPath];
//        BOOL suc = CTFontManagerUnregisterFontsForURL((__bridge CFTypeRef)url, kCTFontManagerScopeNone, &cfError);
//        if (suc){
//             NSLog(@"字体（%@）取消注册成功",self.lastFont.name);
//        } else  {
//            NSError *error = (__bridge NSError *)cfError;
//            NSLog(@"Failed to unload font: %@", error);
//        }
//        self.lastFont = nil;
//    }
//}
//
//- (NSArray<VTFontDescriptor *> *)getAvailableFontDescriptor{
//    NSMutableArray *tempArr = [NSMutableArray array];
//    for (VTFontDescriptor *font in self.fonts) {
//        if (font.downloadStatus == VTFontDownLoadStatusDownloaded) {
//            [tempArr addObject:font];
//        }
//    }
//    return [self inorderWithCurrentLanguage:tempArr];
//}
//
//- (NSArray<VTFontDescriptor *> *)getAllFontDescriptor{
//    return [self inorderWithCurrentLanguage:self.fonts];
//}
//
//- (UIFontDescriptor *)getFontWithFontDescriptor:(VTFontDescriptor *)descriptor{
//    return nil;
//}
//
//- (void)downloadWithFontDescriptor:(VTFontDescriptor *)font{
//    if ([self.downloadingUrls containsObject:font.url]) {
//        NSLog(@"文件已经在下载:");
//        return;
//    }
//    
//    NSString *path = [VTFontDescriptorSessionManager filePathForURLString:font.url];
//    BOOL exists = [self.fileManager fileExistsAtPath:path];
//    if (exists) {
//        NSLog(@"文件已存在:");
//        return;
//    }
//    
//    VTFontDescriptorSessionManager *manager = [[VTFontDescriptorSessionManager alloc]init];
//    [self.downloadingUrls addObject:font.url];
//    [manager downloadWithURLString:font.url];
//    
//}
//
//- (VTFontDescriptor *)defaultFont{
//    for (VTFontDescriptor *font in self.fonts) {
//        if (font.defaultFont.boolValue == YES) {
//            return font;
//        }
//    }
//    return nil;
//}
//
//- (NSArray<VTFontDescriptor *> *)inorderWithCurrentLanguage:(NSArray<VTFontDescriptor *> *)arr{
//    
//    NSMutableArray *enArr = [NSMutableArray array];
//    NSMutableArray *cnArr = [NSMutableArray array];
//    for (VTFontDescriptor *font in arr) {
//        if (!font.invisible.integerValue) {
//            if ([font.language isEqualToString:@"en"]) {
//                [enArr addObject:font];
//            }else{
//                [cnArr addObject:font];
//            }
//        }
//    }
//    
//    NSArray *newArr;
//    // 获取当前语言
////    NSString *currentLanguage = [languages objectAtIndex:0];
//    if ([JudgeLanguage isChinese]) {
//        newArr = [cnArr arrayByAddingObjectsFromArray:enArr];
//    }else{
//        newArr = [enArr arrayByAddingObjectsFromArray:cnArr];
//    }
//    
//    return newArr;
//}
//
//+ (void)registerDefaultFont{
//    OTAsyncRun(^(){
//        VTFontDownloadManager *manager = [VTFontDownloadManager sharedInstance];
//        [manager registerGraphicsFont:[manager defaultFont]];
//    });
//}
//
//
//@end

