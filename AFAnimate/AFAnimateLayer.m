//
//  AFAnimateView.m
//  AFAnimateText
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import "AFAnimateLayer.h"
#import "AFAnimateItem.h"
#import "YYTimer.h"

@interface AFAnimateLayer()
@property (nonatomic) CGFloat currentTime;
@property (nonatomic) YYTimer *timer;
@end

@implementation AFAnimateLayer


- (instancetype)init{
    if (self = [super init]) {
        self.items = [NSMutableArray array];
    }
    return self;
}

- (void)setJSONPath:(NSString *)path{
    NSData *jsonData = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if (error){
        return;
    }
    
//    NSString *version = [dict objectForKey:@"version"];
    
    NSArray *itemsArray = [dict objectForKey:@"items"];
    for (int i = 0; i<itemsArray.count; i++) {
        NSDictionary *dict = itemsArray[i];
        AFAnimateItem *item = [AFAnimateItem itemWithDict:dict];
        [self addItem:item];
    }
    
//    UIGraphicsBeginImageContext(self.layer.bounds.size);
//    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
}

- (void)setTextArray:(NSArray *)textArray{
    
    
}

- (void)addItem:(AFAnimateItem *)item{
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [self.items addObject:item];
    item.animateLayer = self;
    item.layer.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self addSublayer:item.layer];
    [CATransaction commit];
}

- (void)removeItem:(AFAnimateItem *)item{
    if ([item.layer.superlayer isEqual:self]) {
        item.animateLayer = nil;
        [item.layer removeFromSuperlayer];
    }
    [self.items removeObject:item];
}

- (void)refreshAtTime:(CGFloat)time{
    for (int i = 0; i<self.items.count; i++){
        AFAnimateItem *item = self.items[i];
        [item refreshAtTime:time];
    }
}

#pragma mark play
- (void)play{
    self.currentTime = 0;
    if (!self.timer) {
        self.timer = [YYTimer timerWithTimeInterval:1.0/30 target:self selector:@selector(onTick) repeats:YES];
    }
    
}

- (void)onTick{
    self.currentTime += 1.0/30;
    [self refreshAtTime:self.currentTime];
}

@end
