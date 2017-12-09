//
//  ViewController.m
//  AFAnimateDemo
//
//  Created by 初毅 on 2017/12/9.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import "ViewController.h"
#import "AFAnimate.h"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

@interface ViewController ()
@property (nonatomic) AFAnimateLayer *animateLayer;
@property (nonatomic) UIButton *playButton;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CALayer *layer = self.view.layer;
    
    self.animateLayer = [AFAnimateLayer new];
    self.animateLayer.frame = CGRectMake(kScreenWidth/4, 100, kScreenWidth/2, kScreenWidth/2);
    self.animateLayer.backgroundColor = [[UIColor greenColor]colorWithAlphaComponent:0.2].CGColor;
    [layer addSublayer:self.animateLayer];
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"test.json" ofType:nil];
    [self.animateLayer setJSONPath:jsonPath];
    
    [self setupPlayButton];
}

- (void)setupPlayButton{
    self.playButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.playButton.frame = CGRectMake(0, CGRectGetMaxY(self.animateLayer.frame)+100, kScreenWidth, 100);
    self.playButton.backgroundColor = [[UIColor cyanColor]colorWithAlphaComponent:0.2];
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.view addSubview:self.playButton];
    
    [self.playButton addTarget:self action:@selector(playButtonClicked) forControlEvents:UIControlEventTouchUpInside];
}

- (void)playButtonClicked{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        [self.animateLayer play];
    });
}


@end
