////
////  OTFontsView.m
////  Taker
////
////  Created by makaay on 16/6/23.
////  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
////
//
//#import "OTAudioStoreView.h"
//#import "GlobalMacros.h"
//#import "AFNetworkReachabilityManager.h"
//#import "OTAlertView.h"
//#import "MEAsset.h"
//#import "MovieEditManager.h"
//#import "AudioStoreCCell.h"
//#import "AudioAlbumHeaderView.h"
//#import "AudioAlbumFooterView.h"
//#import "AudioAlbumDetailView.h"
//#import "AudioStoreNetwokHelper.h"
//#import "AudioCollectionModel.h"
//#import "AudioAlbumModel.h"
//#import "FilterNavigationBar.h"
//
//#define CELL_ID @"OTFontTableViewCell"
//#define kPadding 15
//
//@interface OTAudioStoreView()<UICollectionViewDelegate,UICollectionViewDataSource>
//
//@property (nonatomic,strong)UIView *contentView;
//
//@property (nonatomic,strong)FilterNavigationBar *navigationBar;
//
//@property (nonatomic,strong)UICollectionView *collectionView;
//
////数据源
//@property (nonatomic,strong)NSArray *audioArray;
//
//@property (nonatomic,strong)AudioAlbumDetailView *detailsView;
//
//@property (nonatomic,strong)AudioStoreNetwokHelper *networkHelper;
//
//@property (nonatomic,strong)UIActivityIndicatorView *indicatorView;
//
//@property (nonatomic,strong)UIButton *retryButton;
//@end
//
//@implementation OTAudioStoreView
//
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        self.backgroundColor = [colorBlack000000 colorWithAlphaComponent:0.6];
//        [self addSubview:self.contentView];
//        [self.contentView addSubview:self.navigationBar];
//        [self.contentView addSubview:self.collectionView];
//        [self.contentView addSubview:self.detailsView];
//        [self.contentView addSubview:self.indicatorView];
//        [self.indicatorView startAnimating];
//        [self.networkHelper refresh];
//        self.hidden = YES;
//    }
//    return self;
//}
//
//-(UIActivityIndicatorView *)indicatorView
//{
//    if (!_indicatorView) {
//        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
//        _indicatorView.center = CGPointMake(self.contentView.width/2, self.contentView.height / 2);
//    }
//    return _indicatorView;
//}
//
//-(AudioStoreNetwokHelper *)networkHelper
//{
//    if (!_networkHelper) {
//        _networkHelper = [AudioStoreNetwokHelper new];
//        _weaken(self);
//        _networkHelper.albumsBlock = ^(BOOL success, NSInteger userWallet, NSArray *result) {
//            if (success) {
//               [weakself.navigationBar setDiamondsCount:@(userWallet)];
//            }
//            [weakself.indicatorView stopAnimating];
//            [weakself.collectionView reloadData];
//        };
//    }
//    return _networkHelper;
//}
//
//-(UIView *)contentView
//{
//    if (!_contentView) {
//        _contentView = [UIView new];
//        CGFloat topInset = kDefaultViewCornerPadding + kSafe_TopH;
//        _contentView.frame = CGRectMake(kDefaultViewCornerPadding, topInset, self.width - kDefaultViewCornerPadding * 2, self.height - topInset * 2);
//        _contentView.backgroundColor = colorBlack242322;
//        _contentView.layer.cornerRadius = kDefaultViewCornerRadius;
//        _contentView.clipsToBounds = YES;
//    }
//    return _contentView;
//}
//
//-(FilterNavigationBar *)navigationBar
//{
//    if (!_navigationBar) {
//        _navigationBar = [[FilterNavigationBar alloc] initWithType:FilterNavigationBarTypeAudioStore];
//        _weaken(self);
//        _navigationBar.leftButtonClickBlock = ^{
//            [weakself hideAudioView];
//        };
//        _navigationBar.rightButtonClickBlock = ^{
//            
//        };
//    }
//    return _navigationBar;
//}
//
//-(UICollectionView *)collectionView
//{
//    if (!_collectionView) {
//        UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//        layout.minimumInteritemSpacing = kPadding;
//        layout.minimumLineSpacing = kPadding;
//        layout.headerReferenceSize = CGSizeMake(self.contentView.width, fontBold20.lineHeight);
//        layout.footerReferenceSize = CGSizeMake(self.contentView.width, 25);
//        layout.sectionInset = UIEdgeInsetsMake(20, kPadding, 15, kPadding);
//        
//        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, self.navigationBar.height, self.contentView.width, self.contentView.height - self.navigationBar.height) collectionViewLayout:layout];
//        _collectionView.delegate = self;
//        _collectionView.dataSource = self;
//        _collectionView.bounces = YES;
//        _collectionView.bouncesZoom = YES;
//        
//        if (IS_IOS11) {
//            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
//        }
//        [_collectionView registerClass:[AudioStoreCCell class] forCellWithReuseIdentifier:@"AudioStoreCCell"];
//        [_collectionView registerClass:[AudioAlbumHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"AudioAlbumHeaderView"];
//        [_collectionView registerClass:[AudioAlbumFooterView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"AudioAlbumFooterView"];
//        
//        self.collectionView.backgroundColor = colorClear;
//    }
//    return _collectionView;
//}
//
//-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return self.networkHelper.collections.count;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    AudioCollectionModel *collectionModel = self.networkHelper.collections[section];
//    return collectionModel.albums.count;
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    AudioCollectionModel *collectionModel = self.networkHelper.collections[indexPath.section];
//    BOOL isHeader = [kind isEqualToString:UICollectionElementKindSectionHeader];
//    if (isHeader) {
//        //必须要deque，用这种方式可以提供一个不被回收的headerView
//        
//        AudioAlbumHeaderView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"AudioAlbumHeaderView" forIndexPath:indexPath];
//        reusableView.title = collectionModel.type;
//        return reusableView;
//    } else {
//        //Footer
//         AudioAlbumFooterView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"AudioAlbumFooterView" forIndexPath:indexPath];
//        if (indexPath.section == self.networkHelper.collections.count - 1) {
//            reusableView.hidden = YES;
//        } else {
//            reusableView.hidden = NO;
//        }
//        return reusableView;
//    }
//}
//
//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    AudioCollectionModel *collectionModel = self.networkHelper.collections[indexPath.section];
//    AudioStoreCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AudioStoreCCell" forIndexPath:indexPath];
//    cell.model = collectionModel.albums[indexPath.row];
//    return cell;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    AudioCollectionModel *collectionModel = self.networkHelper.collections[indexPath.section];
//    AudioAlbumModel *albumModel = collectionModel.albums[indexPath.item];
//    
//    CGFloat height1 = [AudioStoreCCell itemSizeWithAlbumModel:albumModel].height;
//    
//    if (indexPath.item % 2 == 0 && indexPath.item !=0) {
//            
//            AudioAlbumModel *lastModel = collectionModel.albums[indexPath.item - 1];
//            CGFloat height2 = [AudioStoreCCell itemSizeWithAlbumModel:lastModel].height;
//            
//            height1 = MAX(height1, height2);
//        
//    } else {
//        if (indexPath.item < collectionModel.albums.count - 1) {
//            
//            AudioAlbumModel *nextModel = collectionModel.albums[indexPath.item + 1];
//            CGFloat height2 = [AudioStoreCCell itemSizeWithAlbumModel:nextModel].height;
//            
//            height1 = MAX(height1, height2);
//            
//        }
//    }
//    
//  
//    
//    return CGSizeMake([AudioStoreCCell itemWidth], height1);
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    if (section == 0) {
//        return CGSizeMake(self.contentView.width, fontBold20.lineHeight + 15);
//    }
//    return CGSizeMake(self.contentView.width, fontBold20.lineHeight);
//}
//
//-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    AudioCollectionModel *collectionModel = self.networkHelper.collections[indexPath.section];
//    
//    [self initDetailViewWithModel:collectionModel.albums[indexPath.row]];
//    [self showDetailsView:YES];
//}
//
//-(void)initDetailViewWithModel:(AudioAlbumModel *)albumModel;
//{
//    self.detailsView = [[AudioAlbumDetailView alloc] initWithFrame:self.contentView.bounds];
//    self.detailsView.left = self.contentView.width;
//    self.detailsView.model = albumModel;
//    _weaken(self);
//    self.detailsView.popBlock = ^{
//        [weakself showDetailsView:NO];
//    };
//    self.detailsView.useAudioBlock = ^{
//        [weakself hideAudioView];
//    };
//    [self.contentView addSubview:self.detailsView];
//}
//
//-(void)showDetailsView:(BOOL)isFadeIn
//{
//    [[AudioPlayerInstance sharedInstance] pauseCurrentItem];
//    self.contentView.userInteractionEnabled = NO;
//    CGFloat left = 0;
//    if (!isFadeIn) {
//        self.detailsView.left = 0;
//        left = self.contentView.width;
//    } else {
//        self.detailsView.left = self.contentView.width;
//    }
//    [UIView animateWithDuration:0.2 animations:^{
//        self.detailsView.left = left;
//    } completion:^(BOOL finished) {
//        if (!isFadeIn) {
//            [self.detailsView removeFromSuperview];
//            self.detailsView = nil;
//        }
//        self.contentView.userInteractionEnabled = YES;
//    }];
//    
//}
//
//-(void)hideAudioView
//{
//    [[AudioPlayerInstance sharedInstance] pauseCurrentItem];
//    [UIView animateWithDuration:0.3
//                          delay:0
//         usingSpringWithDamping:0.8
//          initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         self.contentView.top = self.height;
//                         self.alpha = 0;
//                     } completion:^(BOOL finished) {
//                         self.hidden = YES;
//                         if (self.hideBlock) {
//                             self.hideBlock();
//                         }
//                         [self.detailsView removeFromSuperview];
//                         self.detailsView = nil;
//                     }];
//}
//
//-(void)showAudioView
//{
//    self.hidden = NO;
//    self.alpha = 1;
//    self.contentView.top = self.height;
//    if (!self.networkHelper.collections.count) {
//        [self.indicatorView startAnimating];
//        [self.networkHelper refresh];
//    }
//    CGFloat topInset = kDefaultViewCornerPadding + kSafe_TopH;
//    [self.superview bringSubviewToFront:self];
//    [UIView animateWithDuration:0.3
//                          delay:0
//         usingSpringWithDamping:0.8
//          initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseOut
//                     animations:^{
//                         
//                         self.contentView.top = topInset;
//                         
//                     } completion:^(BOOL finished) {
//                         
//                     }];
//}
//
//@end

