//
//  VTContainerView.h
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <UIKit/UIKit.h>

@class VTParamObject;

@interface VTContainerView : UIView
@property (nonatomic,strong) VTParamObject *paramObj;
@property (nonatomic,assign) BOOL needDrawDashRect;
@property (nonatomic,assign,readonly) CGRect finalRect; //包括边框和效果的文字最终区域
@property (nonatomic,assign,readonly) CGRect pureTextRect; //文字最终区域


/// 注意size单位是px，会在主线程中执行
- (UIImage *)getImageWithVideoSize:(CGSize)size;
- (void)refreshUIAsync:(BOOL)async;
- (CGFloat)getMaxVerticalPos;
@end
