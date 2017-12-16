//
//  VTFontDescriptor.m
//  Taker
//
//  Created by chuyi on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "VTFontDescriptor.h"
#import <CoreText/CoreText.h>

@interface VTFontDescriptor ()
@property (nonatomic) NSNumber *status;///飞猪给的json中，0表示app bundle中没有，1表示bundle中有
@end

@implementation VTFontDescriptor

- (instancetype)initWithDict:(NSDictionary *)dict{
    if (![dict isKindOfClass:[NSDictionary class]]) {
        return nil;
    }
    NSArray *stringPropertyKeys = @[@"name",
                                    @"filename",
                                    @"fonttype",
                                    @"language",
                                    @"url",
                                    @"cnonly"];
    NSArray *numberPropertyKeys = @[@"size",
                                    @"status",
                                    @"defaultFont",
                                    @"borderwidth",
                                    @"capitalized",
                                    @"lineheightoffset",
                                    @"invisible"];
    
    self = [super initWithDictionary:dict stringPropertyKeys:stringPropertyKeys numberPropertyKeys:numberPropertyKeys];
    self.downloadStatus = self.status.integerValue;
    
    return self;
    
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key isEqualToString:@"default"]) {
        [self setValue:value forKey:@"defaultFont"];
        NSNumber *n = [self valueForKey :@"defaultFont"];
        BOOL isNull = [n isKindOfClass:[NSNull class]];
        BOOL isNil = (n == nil);
        if (isNull || isNil) {
            [self setValue:@0 forKey:@"defaultFont"];
        }
    }
}

- (NSString *)fontRealName{
    if (!_fontRealName) {
        NSLog(@"字体（%@）读取真实字体名",self.name);
        NSData *inData = [[NSData alloc]initWithContentsOfFile:self.fontPath];
        CGDataProviderRef provider = CGDataProviderCreateWithCFData((CFDataRef)inData);
        CGFontRef fontcg = CGFontCreateWithDataProvider(provider);
        NSString *fontName = CFBridgingRelease(CGFontCopyPostScriptName(fontcg));
        CFRelease(provider);
        CFRelease(fontcg);
        _fontRealName = fontName;
    }
    
    return _fontRealName;
}

- (NSString *)description{
    return [NSString stringWithFormat:@"\n name:%@,\n defalutFont:%@",self.name,self.defaultFont];
}

#pragma mark - NSCoding
+ (NSArray *)integerProperties{
    NSArray *a = @[
                   @"downloadStatus",
                   ];
    return a;
}

+ (NSArray *)floatProperties{
    NSArray *a = @[
                   @"downloadPercent",
                   ];
    return a;
}

+ (NSArray *)objectProperties{
    NSArray *a = @[
                   @"name",
                   @"filename",
                   @"fonttype",
                   @"language",
                   @"url",
                   @"size",
                   @"defaultFont",
                   @"cnonly",
                   @"borderwidth",
                   @"capitalized",
                   @"lineheightoffset",
                   @"invisible",
                   @"fontRealName",
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
        
        NSString *fontPathRelative = [decoder decodeObjectForKey:@"fontPathRelative"];
        BOOL inAppBundle = (self.url.length == 0);
        if (inAppBundle) {
            NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
            self.fontPath = [bundlePath stringByAppendingString:fontPathRelative];
        } else {
            //下载后，放在homeDirectory中的
            NSString *home = NSHomeDirectory();
            self.fontPath = [home stringByAppendingString:fontPathRelative];
        }
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

    //重装app，路径会变，所以需要用相对路径
    NSString *fontPathRelative;
    BOOL inAppBundle = (self.url.length == 0);
    if (inAppBundle) {
        NSString *bundlePath = [[NSBundle mainBundle] bundlePath];
        fontPathRelative = [self.fontPath stringByReplacingOccurrencesOfString:bundlePath withString:@""];
    } else {
        NSString *home = NSHomeDirectory();
        fontPathRelative = [self.fontPath stringByReplacingOccurrencesOfString:home withString:@""];
    }
    [coder encodeObject:fontPathRelative forKey:@"fontPathRelative"];
}

@end
