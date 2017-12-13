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

typedef NS_OPTIONS(NSUInteger, SMCircularProgressStyle) {
SMCircularProgressStyleAnnular = 0,/* 环形线圈进去*/
SMCircularProgressStylePieChart = 1,/* 饼形遮罩进度 */
};

typedef NS_ENUM(NSUInteger, SMCircularMaskType) {
     SMCircularMaskTypeBlack = 0,
    SMCircularMaskTypeNone = 1,
   
};
@interface SMCircularProgressLayer : CALayer

@property(nonatomic, strong) UIColor *progressTintColor;
@property(nonatomic, strong) UIColor *innerTintColor;
@property(nonatomic) BOOL roundedCorners;
@property(nonatomic,assign) CGFloat progress;
@property(nonatomic,assign) CGFloat thicknessRatio;
@property(nonatomic,assign) CGFloat radius;
@property(nonatomic,assign) CGRect maskRect;
@property(nonatomic,assign) SMCircularProgressStyle progressStyle;

@property(nonatomic,assign) SMCircularMaskType progressMaskType;
/* 占位图片 */
//@property(nonatomic,strong) UIImage *placeholderImage;
@end
