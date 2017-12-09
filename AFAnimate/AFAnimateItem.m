//
//  AFAnimateItem.m
//  AFAnimateText
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import "AFAnimateItem.h"
#import "AFAnimateTrack.h"
#import "AFAnimateLayer.h"

#define RGBColor(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1]

@interface AFAnimateItem()

@end

@implementation AFAnimateItem

+ (AFAnimateItem *)itemWithDict:(NSDictionary *)dict{
    

    AFAnimateItem *item = [AFAnimateItem new];
    
    NSString *type = [dict objectForKey:@"type"];
    if ([type isEqualToString:@"line"]) {
        item.type = AFAnimateTypeLine;
        item.layer = [CAShapeLayer new];
        item.layer.frame = CGRectMake(0, 0, 100, 100);
    }
    
    NSArray *tracks = [dict objectForKey:@"tracks"];
    item.tracks = [NSMutableArray arrayWithCapacity:tracks.count];
    AFAnimateTrack *baseTrack;
    for (int i = 0; i<tracks.count; i++) {
        NSDictionary *trackDict = tracks[i];
        AFAnimateTrack *track = [AFAnimateTrack trachWithDict:trackDict baseTrack:baseTrack];
        NSAssert(!baseTrack || track.time > baseTrack.time, @"后一track的时间戳必须大于前一track");
        baseTrack = track;
        if (track) {
            [item.tracks addObject:track];
        }
    }
    
    return item;
    
}

- (void)refreshAtTime:(CGFloat)time{
    if (!self.animateLayer) {
        return;
    }
    CGSize size = self.animateLayer.frame.size;
    AFAnimateTrack *lastTrack;
    AFAnimateTrack *nextTrack;
    for (int i = 0; i<self.tracks.count; i++) {
        AFAnimateTrack *track = self.tracks[i];
        if (track.time <= time){
            lastTrack = track;
        }else{
            break;
        }
    }
    for (int i = (int)self.tracks.count - 1; i >= 0; i--) {
        AFAnimateTrack *track = self.tracks[i];
        if (track.time > time){
            nextTrack = track;
        }else{
            break;
        }
    }
    
    if (self.type == AFAnimateTypeLine) {
        UIColor *color = [UIColor blackColor];
        CGPoint p0 = CGPointZero;
        CGPoint p1 = CGPointZero;
        CGFloat width = 1;
        CGFloat alpha = 1;
        if (lastTrack && nextTrack) {
            CGFloat percent = (time - lastTrack.time)/(nextTrack.time - lastTrack.time);
            p0 = [self mixPoint:lastTrack.p0 withPoint:nextTrack.p0 percent:percent];
            p1 = [self mixPoint:lastTrack.p1 withPoint:nextTrack.p1 percent:percent];
            color = [self mixColor:lastTrack.color withColor:nextTrack.color percent:percent];
            width = [self mixFloat:lastTrack.width withFloat:nextTrack.width percent:percent];
            alpha = [self mixFloat:lastTrack.alpha withFloat:nextTrack.alpha percent:percent];
        }else if (lastTrack){
            p0 = lastTrack.p0;
            p1 = lastTrack.p1;
            color = lastTrack.color;
            alpha = lastTrack.alpha;
        }else{
            return;
        }
        
        CGPoint realP0 = CGPointMake(p0.x * size.width, p0.y * size.height);
        CGPoint realP1 = CGPointMake(p1.x * size.width, p1.y * size.height);
        
        UIBezierPath *path = [UIBezierPath new];
        path.lineJoinStyle = kCGLineJoinRound;
        [path moveToPoint:realP0];
        [path addLineToPoint:realP1];
        CAShapeLayer *layer = (CAShapeLayer *)self.layer;
        layer.path = path.CGPath;
        layer.strokeColor = color.CGColor;
        layer.lineWidth = width;
        layer.lineCap = @"round";
        NSLog(@"alpha %f",alpha);
        layer.opacity = alpha;
    }
}

- (CGPoint)mixPoint:(CGPoint)pa withPoint:(CGPoint)pb percent:(CGFloat)percent{
    CGFloat x = pa.x + (pb.x-pa.x) * percent;
    CGFloat y = pa.y + (pb.y-pa.y) * percent;
    return CGPointMake(x, y);
}

- (UIColor *)mixColor:(UIColor *)ca withColor:(UIColor *)cb percent:(CGFloat)percent{
    CGFloat ra,ga,ba;
    [ca getRed:&ra green:&ga blue:&ba alpha:nil];
    CGFloat rb,gb,bb;
    [cb getRed:&rb green:&gb blue:&bb alpha:nil];
    
    CGFloat r = ra + (rb-ra) * percent;
    CGFloat g = ga + (gb-ga) * percent;
    CGFloat b = ba + (bb-ba) * percent;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1];
}

- (CGFloat)mixFloat:(CGFloat)fa withFloat:(CGFloat)fb percent:(CGFloat)percent{
    CGFloat f = fa + (fb-fa) * percent;
    return f;
}

@end
