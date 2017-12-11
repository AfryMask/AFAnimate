//
//  AFAnimateView.h
//  AFAnimateText
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class AFAnimateItem;

@interface AFAnimateLayer : CALayer

@property (nonatomic) NSMutableArray<AFAnimateItem *> *items;
- (void)setJSONPath:(NSString *)path;
- (void)setTextArray:(NSArray *)textArray;

- (void)play;
- (void)refreshAtTime:(CGFloat)time;
@end
