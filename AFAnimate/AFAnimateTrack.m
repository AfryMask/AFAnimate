
//
//  AFAnimateTrack.m
//  AFAnimateText
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import "AFAnimateTrack.h"
#import <UIKit/UIKit.h>

@implementation AFAnimateTrack
+ (AFAnimateTrack *)trachWithDict:(NSDictionary *)dict baseTrack:(AFAnimateTrack *)baseTrack{
    AFAnimateTrack *track = [AFAnimateTrack new];
    track.p0 = baseTrack.p0;
    track.p1 = baseTrack.p1;
    track.color = baseTrack.color;
    track.width = baseTrack.width;
    track.alpha = baseTrack.alpha;
    
    NSString *time = [dict objectForKey:@"time"];
    track.time = time.doubleValue;
    
    NSString *point0 = [dict objectForKey:@"p0"];
    if (point0) {
        track.p0 = CGPointFromString(point0);
    }
    
    NSString *point1 = [dict objectForKey:@"p1"];
    if (point1) {
        track.p1 = CGPointFromString(point1);
    }
    
    NSString *color = [dict objectForKey:@"color"];
    if (color) {
        long ori = strtoul([color UTF8String],0,16);
        CGFloat r = ((float)((ori & 0xFF0000) >> 16))/255.0;
        CGFloat g = ((float)((ori & 0xFF00) >> 8))/255.0;
        CGFloat b = ((float)(ori & 0xFF))/255.0;
        track.color = [UIColor colorWithRed:r green:g blue:b alpha:1];
    }
    
    NSString *width = [dict objectForKey:@"width"];
    if (width) {
        track.width = width.floatValue;
    }
    
    NSString *alpha = [dict objectForKey:@"alpha"];
    if (alpha) {
        track.alpha = alpha.floatValue;
    }
    
    return track;
}
@end
