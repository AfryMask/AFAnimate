//
//  NSShadow+VideoText.m
//  Taker
//
//  Created by n on 16/6/24.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "NSShadow+VideoText.h"

@implementation NSShadow (VideoText)
- (CGFloat)offsetWidth{
    CGFloat w = self.shadowOffset.width;
    return w;
}

- (CGFloat)offsetHeight{
    CGFloat h = self.shadowOffset.height;
    return h;
}

- (void)setShadowAlpha:(CGFloat)shadowAlpha{
    self.shadowColor = [[UIColor blackColor] colorWithAlphaComponent:shadowAlpha];
}

- (CGFloat)shadowAlpha{
    CGFloat alpha = 0;
    [self.shadowColor getWhite:NULL alpha:&alpha];
    return alpha;
}

@end
