//
//  SMCircularProgressLayer.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "SMCircularProgressLayer.h"

#define maskColor [[UIColor blackColor] colorWithAlphaComponent:0.7]

@implementation SMCircularProgressLayer

+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([key isEqualToString:@"progress"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)drawInContext:(CGContextRef)context{
   
    if (self.progressStyle == SMCircularProgressStyleAnnular) {
        [self drawAnnularInContext:context];
    }else{
        [self drawPieChartInContext:context];
    }
}

- (void)drawAnnularInContext:(CGContextRef)context{
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = 0;
    radians = (float)((progress * 2.0f * M_PI) - M_PI_2);
    
    if (_progressMaskType == SMCircularMaskTypeBlack) {
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGMutablePathRef rectPath = CGPathCreateMutable();
        CGPathMoveToPoint(rectPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddRect(rectPath, NULL, self.maskRect);
        CGPathCloseSubpath(rectPath);
        CGContextAddPath(context, rectPath);
        CGContextFillPath(context);
        CGPathRelease(rectPath);
    }
    
    CGContextSetFillColorWithColor(context, _innerTintColor.CGColor);
    CGMutablePathRef progressPath = CGPathCreateMutable();
    CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, _radius, (float)(4.0f * M_PI_2), 0, false);
    CGPathCloseSubpath(progressPath);
    CGContextAddPath(context, progressPath);
    CGContextFillPath(context);
    CGPathRelease(progressPath);
    
    if (progress > 0.0f) {
        CGContextSetFillColorWithColor(context, self.progressTintColor.CGColor);
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, _radius, (float)(3.0f * M_PI_2), radians, false);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
    }
    
    if (progress > 0.0f && self.roundedCorners) {
        CGFloat pathWidth = _radius * self.thicknessRatio;
        CGFloat xOffset = centerPoint.x + (_radius - pathWidth/2) * sinf(radians + M_PI_2);
        CGFloat yOffset = centerPoint.y - (_radius  - pathWidth/2) *  cosf(radians + M_PI_2);
        CGPoint endPoint = CGPointMake(xOffset, yOffset);
        
        CGRect startEllipseRect = (CGRect) {
            .origin.x = centerPoint.x - pathWidth / 2.0f,
            .origin.y = centerPoint.y - _radius,
            .size.width = pathWidth,
            .size.height = pathWidth
        };
        CGContextAddEllipseInRect(context, startEllipseRect);
        CGContextFillPath(context);
        
        CGRect endEllipseRect = (CGRect) {
            .origin.x = endPoint.x - pathWidth / 2.0f,
            .origin.y = endPoint.y - pathWidth / 2.0f,
            .size.width = pathWidth,
            .size.height = pathWidth
        };
        CGContextAddEllipseInRect(context, endEllipseRect);
        CGContextFillPath(context);
    }
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGFloat innerRadius = _radius * (1.0f - self.thicknessRatio);
    CGRect clearRect = (CGRect) {
        .origin.x = centerPoint.x - innerRadius,
        .origin.y = centerPoint.y - innerRadius,
        .size.width = innerRadius * 2.0f,
        .size.height = innerRadius * 2.0f
    };
    CGContextAddEllipseInRect(context, clearRect);
    CGContextFillPath(context);
    
  //  if (_progressMaskType == SMCircularMaskTypeBlack) {
        CGContextSetBlendMode(context, kCGBlendModeNormal);
        CGContextSetFillColorWithColor(context, maskColor.CGColor);
        CGContextAddEllipseInRect(context, clearRect);
        CGContextFillPath(context);
 //   }
}


-(void)drawPieChartInContext:(CGContextRef)context{
    CGPoint centerPoint = CGPointMake(self.bounds.size.width / 2.0f, self.bounds.size.height / 2.0f);
    CGFloat progress = MIN(self.progress, 1.0f - FLT_EPSILON);
    CGFloat radians = 0;
    radians = (float)((progress * 2.0f * M_PI) - M_PI_2);
    
    CGContextSetFillColorWithColor(context, maskColor.CGColor);
    CGMutablePathRef rectPath = CGPathCreateMutable();
    CGPathMoveToPoint(rectPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddRect(rectPath, NULL, self.maskRect);
    CGPathCloseSubpath(rectPath);
    CGContextAddPath(context, rectPath);
    CGContextFillPath(context);
    CGPathRelease(rectPath);
    
    CGContextSetBlendMode(context, kCGBlendModeClear);
    CGMutablePathRef trackPath = CGPathCreateMutable();
    CGPathMoveToPoint(trackPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(trackPath, NULL, centerPoint.x, centerPoint.y, _radius, (float)(2.0f * M_PI), 0.0f, TRUE);
    CGPathCloseSubpath(trackPath);
    CGContextAddPath(context, trackPath);
    CGContextFillPath(context);
    CGPathRelease(trackPath);
    
    CGContextSetBlendMode(context, kCGBlendModeNormal);
    CGContextSetFillColorWithColor(context, maskColor.CGColor);
    CGMutablePathRef centTintPath = CGPathCreateMutable();
    CGPathMoveToPoint(centTintPath, NULL, centerPoint.x, centerPoint.y);
    CGPathAddArc(centTintPath, NULL, centerPoint.x, centerPoint.y, _radius - _radius * self.thicknessRatio, (float)(2.0f * M_PI), 0.0f, TRUE);
    CGPathCloseSubpath(centTintPath);
    CGContextAddPath(context, centTintPath);
    CGContextFillPath(context);
    CGPathRelease(centTintPath);
    
    if (progress > 0.0f) {
        CGContextSetBlendMode(context, kCGBlendModeClear);
        CGContextSetFillColorWithColor(context,[UIColor clearColor].CGColor);  //self.progressTintColor.CGColor);
        CGMutablePathRef progressPath = CGPathCreateMutable();
        CGPathMoveToPoint(progressPath, NULL, centerPoint.x, centerPoint.y);
        CGPathAddArc(progressPath, NULL, centerPoint.x, centerPoint.y, _radius, (float)(3.0f * M_PI_2), radians, false);
        CGPathCloseSubpath(progressPath);
        CGContextAddPath(context, progressPath);
        CGContextFillPath(context);
        CGPathRelease(progressPath);
    }
}

@end
