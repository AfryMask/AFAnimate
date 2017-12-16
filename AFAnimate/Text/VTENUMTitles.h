//
//  VTENUMsToTitle.h
//  Taker
//
//  Created by n on 16/6/22.
//  Copyright © 2016年 com.pepsin.fork.video_taker. All rights reserved.
//

#import <Foundation/Foundation.h>

///获得各个ENUM的titles数组
@interface VTENUMTitles : NSObject
+ (NSArray *)alignTitles;
+ (NSArray *)letterSpacingTitles;
+ (NSArray *)lineSpacingTitles;
+ (NSArray *)textColorTitles;
+ (NSArray *)fontSizeTitles;
+ (NSArray *)shadowTitles;
@end
