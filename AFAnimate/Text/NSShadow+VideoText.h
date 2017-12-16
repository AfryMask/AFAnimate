//
//  NSShadow+VideoText.h
//  Taker
//
//  Created by n on 16/6/24.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NSShadow (VideoText)
@property (nonatomic,readonly) CGFloat offsetWidth;
@property (nonatomic,readonly) CGFloat offsetHeight;

/// 用这个方法会设置 shadowColor
@property (nonatomic,assign) CGFloat shadowAlpha;
@end
