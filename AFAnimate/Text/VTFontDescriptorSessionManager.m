////
////  VTFontDescriptorSessionManager.m
////  Taker
////
////  Created by chuyi on 16/6/23.
////  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
////
//
//#import "VTFontDescriptorSessionManager.h"
//#import "GlobalMacros.h"
//#define _weaken(obj) __weak __typeof(obj) weak##obj = obj;
//
//@interface VTFontDescriptorSessionManager ()
//@property (nonatomic,strong) NSString *urlStr;
//@property (nonatomic,strong) NSProgress *progress;
//@end
//
//@implementation VTFontDescriptorSessionManager
//- (void)downloadWithURLString:(NSString *)urlStr{
//    self.urlStr = urlStr;
//    
//    NSURL *url = [NSURL URLWithString:urlStr];
//    
//    
//    NSURL *destinationFileURL = [[self class] localVideoURLForString:urlStr];// 根据urlStr创建一个文件路径，用于保存文件
//    NSLog(@"downloadURL%@",destinationFileURL);
//    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:15];
//    NSProgress *progress = nil;
//    
//    _weaken(self)
//    NSURLSessionDownloadTask *downloadTask = [self downloadTaskWithRequest:request progress:&progress destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
//        return destinationFileURL;
//    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
//        if (error){
//            NSLog(@"VideoURLCacheSessionManager downloadWithURL error :%@",error);
//            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_FontDownloadField object:urlStr];
//        } else {
//            [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_FontDownloaded object:urlStr];
//        }
//        [weakself invalidateSessionCancelingTasks:YES];//调用invalidate才会释放，参考issue#2149
//    }];
//    self.progress = progress;
//    [progress addObserver:self forKeyPath:@"fractionCompleted" options:NSKeyValueObservingOptionNew context:nil];
//    [downloadTask resume];
//
//}
//
//- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
//    if (![keyPath isEqualToString:@"fractionCompleted"]) {
//        return;
//    }
//    NSProgress *progress = object;
//    NSDictionary *userInfo = @{@"fractionCompleted":@(progress.fractionCompleted)};
//    [[NSNotificationCenter defaultCenter] postNotificationName:kNotification_FontDownloading object:self.urlStr userInfo:userInfo];
//}
//
//+ (NSURL *)localVideoURLForString:(NSString *)str{
//    NSString *filePath = [self filePathForURLString:str];
//    NSURL *result = [NSURL fileURLWithPath:filePath];
//    return result;
//}
//
//+ (NSString *)filePathForURLString:(NSString *)urlStr{
//    NSString *fileName = [NSString stringWithFormat:@"%ld.font",(unsigned long)urlStr.hash];
//    NSString *filePath = [[self videoCacheDirPath] stringByAppendingPathComponent:fileName];
//    return filePath;
//}
//
//+ (NSString *)videoCacheDirPath{
//    static NSString *videoCacheDir = nil;
//    if (!videoCacheDir){
//        NSArray *documentDirectory = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//        NSString *documentsDirectory = documentDirectory.lastObject;
//        videoCacheDir = [NSString stringWithFormat:@"%@/fonts/",documentsDirectory]; // 文件夹路径
//    }
//    return videoCacheDir;
//}
//
//- (void)dealloc{
//    [self.progress removeObserver:self forKeyPath:@"fractionCompleted"];
//}
//
//@end

