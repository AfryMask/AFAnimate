
//
//  HorizontalButtonsView.m
//  Taker
//
//  Created by makaay on 2017/3/21.
//  Copyright © 2017年 com.pepsin.fork.video_taker. All rights reserved.
//

#import "HorizontalButtonsView.h"
#import "GlobalMacros.h"
//#import "SpecificScrollViewCell.h"

#define cellWidth 44
#define cellHeight 70
#define cellSpace 10

#define besideSpace 20
#define kBottomViewHeight 50
#define kScrollviewHeight 85

@interface HorizontalButtonsView()

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSMutableArray *buttonsArray;
@property (nonatomic,strong) NSArray *dataSourceArray;

@end


@implementation HorizontalButtonsView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.buttonsArray = [NSMutableArray array];
        [self initScrollView];
    }
    return self;
}


-(void)initScrollView
{
//    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 7, self.width, self.height)];
//    self.scrollView.showsHorizontalScrollIndicator = NO;
//    [self addSubview:self.scrollView];
}

-(void)constructButtonsWithArray:(NSArray *)dataSource withType:(SpecificAdjustType)type
{
//    if (self.buttonsArray.count) {
//        [self.buttonsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            SpecificScrollViewCell *cell = obj;
//            [cell removeFromSuperview];
//        }];
//        [self.buttonsArray removeAllObjects];
//    }
//
//    int cellCount = (int)dataSource.count;
//    CGFloat allCellWidth = cellWidth * cellCount + cellSpace * (cellCount-1) + besideSpace * 2;
//    if (allCellWidth < kScreenWidth) {
//        self.scrollView.width = allCellWidth;
//        self.scrollView.contentSize = CGSizeMake(allCellWidth, 0);
//        for (int i=0; i<cellCount; i++) {
//            SpecificScrollViewCell *cell = [[SpecificScrollViewCell alloc]initWithFrame:CGRectMake(besideSpace + cellWidth*i + cellSpace*i, 0, cellWidth, cellHeight)];
//            cell.tag = 10000+i;
//            NSNumber *number = dataSource[i];
//            [cell setMode:number.integerValue withType:type];
//            [cell addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self.scrollView addSubview:cell];
//            [self.buttonsArray addObject:cell];
//        }
//    }else{
//        self.scrollView.width = self.width;
//        self.scrollView.contentSize = CGSizeMake(allCellWidth, 0);
//        for (int i=0; i<cellCount; i++) {
//            SpecificScrollViewCell *cell = [[SpecificScrollViewCell alloc]initWithFrame:CGRectMake(besideSpace + cellWidth*i + cellSpace*i, 0, cellWidth, cellHeight)];
//            cell.tag = 10000+i;
//            NSNumber *number = dataSource[i];
//            [cell setMode:number.integerValue withType:type];
//            [cell addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self.scrollView addSubview:cell];
//            [self.buttonsArray addObject:cell];
//        }
//    }
//    self.scrollView.centerX = kScreenWidth/2.0;
//    self.scrollView.contentOffset = CGPointMake(0, 0);
//    [self addSubview:self.scrollView];
}


//-(void)buttonDidClick:(SpecificScrollViewCell *)sender
//{
////    if (!sender.isSelectCell) {
//        [self setSelectedMode:sender.mode];
//        
//        if (self.buttonClickBlock) {
//            self.buttonClickBlock(sender.mode);
//        }
////    }
//}
//
//-(void)setSelectedMode:(NSInteger)selectedMode
//{
//    _selectedMode = selectedMode;
//    [self HighlightButtonWithMode:selectedMode];
//}
//
//-(void)HighlightButtonWithMode:(NSInteger)mode
//{
//    [self.buttonsArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        SpecificScrollViewCell *cell = obj;
//        if (cell.mode == mode) {
//            [cell selectCell:YES];
//        } else {
//            [cell selectCell:NO];
//        }
//    }];
//}

@end
