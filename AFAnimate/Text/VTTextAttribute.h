//
//  VTTextAttribute.h
//  Taker
//
//  Created by n on 16/6/23.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/// NSAttributedString+VideoText.h 中需要这个类传入配置参数
@interface VTTextAttribute : NSObject

@property (nonatomic,assign) CGFloat fontSize;
@property (nonatomic,strong) NSString *fontName;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) NSShadow *shadow;

/// 将属性转为字典
@property (nonatomic,readonly) NSDictionary *dictAttributes;

@property (nonatomic,readonly) UIFont *realFont;
@property (nonatomic,readonly) CGFloat ascendDescend;
@end
