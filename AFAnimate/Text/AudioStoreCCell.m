////
////  AudioStoreCCell.m
////  Taker
////
////  Created by makaay on 2017/8/10.
////  Copyright © 2017年 com.pepsin.fork.video_taker. All rights reserved.
////
//
//#import "AudioStoreCCell.h"
//#import "GlobalMacros.h"
////#import "ImageCacheManager.h"
//#import "AudioTrackPlayCircleView.h"
//#import "AudioPlayerInstance.h"
//
//#define kImageWidth (kScreenWidth - kDefaultViewCornerPadding * 2 - 45) / 2
//#define kImageBottom 10
//#define kMainFont fontBold14
//#define kSubFont fontRegular13
//#define kTitleHeight kMainFont.lineHeight
//#define kSubeTitleHeight fontRegular14.lineHeight
//#define kTitleSpaceing 5
//
//
//@interface AudioStoreCCell ()
//@property (nonatomic,strong)UIImageView *imageView;
//@property (nonatomic,strong)AudioTrackPlayCircleView *playCircle;
//@property (nonatomic,strong)UILabel *titleLabel;
//@property (nonatomic,strong)UILabel *subTitleLabel;
//@property (nonatomic,strong)UILabel *countLabel;
//
//@end
//
//@implementation AudioStoreCCell
//
//-(instancetype)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        [self addSubview:self.imageView];
//        [self.imageView addSubview:self.playCircle];
//        [self addSubview:self.titleLabel];
//        [self addSubview:self.subTitleLabel];
//        [self addSubview:self.countLabel];
//    }
//    return self;
//}
//
//-(UIImageView *)imageView
//{
//    if (!_imageView) {
//        _imageView = [UIImageView new];
//        _imageView.frame = CGRectMake(0, 0, kImageWidth, kImageWidth);
//        _imageView.layer.cornerRadius = kDefaultButtonCornerRadius;
//        _imageView.clipsToBounds = YES;
//        _imageView.userInteractionEnabled = YES;
//        _imageView.backgroundColor = colorGold;
//    }
//    return _imageView;
//}
//
//-(AudioTrackPlayCircleView *)playCircle
//{
//    if (!_playCircle) {
//        CGFloat width = 30;
//        _playCircle = [[AudioTrackPlayCircleView alloc] initWithFrame:CGRectMake(0, 0, width, width)];
//        
//        _playCircle.left = 5;
//        _playCircle.bottom = self.imageView.height - 5;
//        
//        _playCircle.backgroundColor = [colorBlack000000 colorWithAlphaComponent:0.3];
//        _playCircle.tintColor = colorWhite;
//        _playCircle.layer.borderColor = colorWhite.CGColor;
//        _playCircle.layer.borderWidth = 1;
//        _playCircle.layer.cornerRadius = width * 0.5;
//        _playCircle.hidden = YES;
//        
//    }
//    return _playCircle;
//}
//
//-(UILabel *)titleLabel
//{
//    if (!_titleLabel) {
//        _titleLabel = [UILabel new];
//        _titleLabel.font = kMainFont;
//        _titleLabel.textColor = colorWhite;
//        _titleLabel.frame = CGRectMake(0, self.imageView.bottom + kImageBottom, self.width, kMainFont.lineHeight);
//    }
//    return _titleLabel;
//}
//
//-(UILabel *)subTitleLabel
//{
//    if (!_subTitleLabel) {
//        _subTitleLabel = [UILabel new];
//        _subTitleLabel.font = kSubFont;
//        _subTitleLabel.textColor = [colorWhite colorWithAlphaComponent:0.3];
//        _subTitleLabel.frame = CGRectMake(0, self.titleLabel.bottom + kTitleSpaceing, self.width, kSubFont.lineHeight);
//    }
//    return _subTitleLabel;
//}
//
//-(UILabel *)countLabel
//{
//    if (!_countLabel) {
//        _countLabel = [UILabel new];
//        _countLabel.font = kSubFont;
//        _countLabel.textColor =  [colorWhite colorWithAlphaComponent:0.3];;
//        _countLabel.frame = CGRectMake(0, self.subTitleLabel.bottom + kTitleSpaceing, self.width, kSubFont.lineHeight);
//    }
//    return _countLabel;
//}
//
//-(void)setModel:(AudioAlbumModel *)model
//{
//    _model = model;
//    self.titleLabel.text = model.title;
//    self.subTitleLabel.text = model.title_s;
//    if (!_subTitleLabel.text.length) {
//        self.countLabel.top = _subTitleLabel.top;
//    } else {
//        self.countLabel.top = self.subTitleLabel.bottom + kTitleSpaceing;
//    }
//    self.countLabel.text = model.trackString;
//    self.imageView.backgroundColor = model.bg_color;
//    
//    self.playCircle.trackModel = model.firstTrackModel;
//    
//    _weaken(self);
//    if (self.model.cover.length) {
//        [ImageCacheManager getImageForURL:model.cover Size:AUDIO_STORE_COVER_SIZE thenDo:^(UIImage *image, NSString *URL, ImageLoadingState state) {
//            if ([URL isEqualToString:weakself.model.cover] && image) {
//                weakself.imageView.image = image;
//            }
//        }];
//    }
//}
//
//-(void)prepareForReuse
//{
//    self.model = nil;
//    self.imageView.image = nil;
//
//    [super prepareForReuse];
//}
//
//+(CGFloat)itemWidth
//{
//    return kImageWidth;
//}
//
//+(CGSize)itemSizeWithAlbumModel:(AudioAlbumModel *)albumModel
//{
//    CGFloat height = kImageWidth + kImageBottom + kTitleHeight + kTitleSpaceing + kSubeTitleHeight + kTitleSpaceing + kSubeTitleHeight;
//    if (!albumModel.title_s.length) {
//        height = height - kSubeTitleHeight - kTitleSpaceing+0.5;
//    }
//    return CGSizeMake(kImageWidth, height);
//}
//@end

