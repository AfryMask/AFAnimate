//
//  AFAnimateTrack.h
//  AFAnimateText
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

@interface AFAnimateTrack : NSObject
@property (nonatomic) CGFloat time;
@property (nonatomic) CGPoint p0;
@property (nonatomic) CGPoint p1;
@property (nonatomic) UIColor *color;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat alpha;

+ (AFAnimateTrack *)trachWithDict:(NSDictionary *)dict baseTrack:(AFAnimateTrack *)baseTrack;
@end
