
//
//  TestView.m
//  AFAnimateDemo
//
//  Created by 初毅 on 2017/12/16.
//  Copyright © 2017年 初毅. All rights reserved.
//

#import "TestView.h"
#import "VTContainerView.h"
#import "VTParamObject.h"

@interface TestView()
@property (nonatomic) VTContainerView *testView;
@end

@implementation TestView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (void)setup{
    self.testView = [[VTContainerView alloc]initWithFrame:self.bounds];
    [self addSubview:self.testView];
    VTParamObject *obj = [[VTParamObject alloc]init];
    obj.text = @"123";
    [obj applyDefaulValue];
    
    self.backgroundColor = [UIColor redColor];
    self.testView.backgroundColor = [UIColor blackColor];
    
    self.testView.paramObj = obj;
    [self.testView refreshUIAsync:YES];
    
    
    
}

@end
