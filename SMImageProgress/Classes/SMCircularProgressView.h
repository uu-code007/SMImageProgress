//
//  SMCircularProgressView.h
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "SMCircularProgressLayer.h"



@interface SMCircularProgressView : UIView

/* 环形进度条颜色 */
@property(nonatomic, strong) UIColor *progressTintColor;
/* 内部圆形颜色 */
@property(nonatomic, strong) UIColor *innerTintColor;
/* 环形是否圆角 */
@property(nonatomic,assign) BOOL roundedCorners;
/* 环宽所占半径的比例 */
@property(nonatomic,assign) CGFloat thicknessRatio;
/* 加载进度 */
@property(nonatomic,assign) CGFloat progress;
/* 半径 */
@property(nonatomic,assign) CGFloat radius;
/* 进度样式 */
@property(nonatomic,assign) SMCircularProgressStyle progressStyle;

@property(nonatomic,assign) SMCircularMaskType progressMaskType;
//-(void)setPlaceholderImage:(UIImage *)placeholderImage;

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated initialDelay:(CFTimeInterval)initialDelay;
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated initialDelay:(CFTimeInterval)initialDelay withDuration:(CFTimeInterval)duration;

-(void)dismissProgressAnimated:(BOOL)animated;

@end
