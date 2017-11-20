//
//  SMCircularProgressLayer.h
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface SMCircularProgressLayer : CALayer

@property(nonatomic, strong) UIColor *trackTintColor;
@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic, strong) UIColor *innerTintColor;
@property(nonatomic) BOOL roundedCorners;
@property(nonatomic,assign) CGFloat thicknessRatio;
@property(nonatomic,assign) CGFloat progress;
@property(nonatomic,assign) CGFloat radius;

@end
