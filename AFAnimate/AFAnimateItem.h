//
//  AFAnimateItem.h
//  AFAnimateText
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFAnimateDefinitions.h"
@class AFAnimateLayer;
@class AFAnimateTrack;

@interface AFAnimateItem : NSObject
@property (nonatomic,weak) AFAnimateLayer *animateLayer;
@property (nonatomic) CALayer *layer;
@property (nonatomic) AFAnimateType type;
@property (nonatomic) NSMutableArray<AFAnimateTrack *> *tracks;


+ (AFAnimateItem *)itemWithDict:(NSDictionary *)dict;
- (void)refreshAtTime:(CGFloat)time;

@end
