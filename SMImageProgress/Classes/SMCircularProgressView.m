//
//  SMCircularProgressView.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "SMCircularProgressView.h"

@interface SMCircularProgressView()<CAAnimationDelegate>{
    
}
@property (nonatomic,strong)SMCircularProgressLayer *circularProgressLayer;
@property (nonatomic,strong)UIImage *placeholderImage;
@property (nonatomic, strong) CAShapeLayer *circlePathLayer;

@end
@implementation SMCircularProgressView


+ (Class)layerClass
{
    return [SMCircularProgressLayer class];
}

- (SMCircularProgressLayer *)circularProgressLayer
{
    return (SMCircularProgressLayer *)self.layer;
}

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
    
        [self setProgressTintColor:[UIColor whiteColor]];
        [self setInnerTintColor:[[UIColor grayColor] colorWithAlphaComponent:0.7]];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setThicknessRatio:0.2f];
        [self setRadius:30];
        [self setRoundedCorners:YES];
        [self setProgressStyle:SMCircularProgressStyleAnnular];
        self.circularProgressLayer.contentsScale = [[UIScreen mainScreen] scale];
    }    
    return self;
}

-(void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    self.circularProgressLayer.maskRect = self.bounds;
}

#pragma mark - Progress

- (CGFloat)progress
{
    return self.circularProgressLayer.progress;
}

-(void)setProgress:(CGFloat)progress{
    
   [self setProgress:progress animated:NO];
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated
{
    [self setProgress:progress animated:animated initialDelay:0.0];
}

- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
       initialDelay:(CFTimeInterval)initialDelay{
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    [self setProgress:progress
             animated:animated
         initialDelay:initialDelay
         withDuration:fabs(self.progress - pinnedProgress)];
}

- (void)setProgress:(CGFloat)progress
           animated:(BOOL)animated
       initialDelay:(CFTimeInterval)initialDelay
       withDuration:(CFTimeInterval)duration{

    [self.circularProgressLayer removeAnimationForKey:@"progress"];
    
    CGFloat pinnedProgress = MIN(MAX(progress, 0.0f), 1.0f);
    if (animated) {
        CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"progress"];
        animation.duration = duration;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.fillMode = kCAFillModeForwards;
        animation.fromValue = [NSNumber numberWithFloat:self.progress];
        animation.toValue = [NSNumber numberWithFloat:pinnedProgress];
        animation.beginTime = CACurrentMediaTime() + initialDelay;
        [self.circularProgressLayer addAnimation:animation forKey:@"progress"];
    } else {
         self.circularProgressLayer.progress = pinnedProgress;
        [self.circularProgressLayer setNeedsDisplay];
       
    }
}



#pragma mark - 进度消失
-(void)dismissProgressAnimated:(BOOL)animated{
    if (animated) {
        [self dismissProgress];
    }else{
        self.hidden = YES;
    }
}

#pragma mark - 进度消失动画
- (void)dismissProgress{
    _circlePathLayer = [CAShapeLayer layer];
    _circlePathLayer.frame = self.bounds;
    _circlePathLayer.lineWidth = 0;
    _circlePathLayer.fillColor = [UIColor clearColor].CGColor;
    _circlePathLayer.strokeStart = 0;
    _circlePathLayer.strokeColor = self.tintColor.CGColor;

    self.circularProgressLayer.mask = self.circlePathLayer;
    CGRect circleFrame = CGRectMake(0, 0, 40, 40);
    circleFrame.origin.x = CGRectGetMidX(self.circlePathLayer.bounds) - CGRectGetMidX(circleFrame);
    circleFrame.origin.y = CGRectGetMidY(self.circlePathLayer.bounds) - CGRectGetMidY(circleFrame);

    CGFloat finalRadius = [self distanceBetweenPoint1:CGPointZero point2:CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))];
    CGFloat radius = finalRadius - 20;
    CGRect outerRect = CGRectInset(circleFrame, -radius, -radius);
    UIBezierPath *toPath = [UIBezierPath bezierPathWithOvalInRect:outerRect];

    CGFloat fromLineWidth = self.circlePathLayer.lineWidth;
    [CATransaction begin];
    [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
    self.circlePathLayer.lineWidth = 2*finalRadius;
    self.circlePathLayer.path = toPath.CGPath;
    [CATransaction commit];

    CABasicAnimation *lineWidthAnimation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(lineWidth))];
    lineWidthAnimation.duration = 1;
    lineWidthAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    lineWidthAnimation.removedOnCompletion = NO;
    lineWidthAnimation.fillMode = kCAFillModeForwards;
    lineWidthAnimation.fromValue = @(2*finalRadius);
    lineWidthAnimation.toValue = @(fromLineWidth);
    lineWidthAnimation.delegate = self;
    [self.circlePathLayer addAnimation:lineWidthAnimation forKey:@"strokeWidth"];
}

-(CGFloat)distanceBetweenPoint1:(CGPoint)point1 point2:(CGPoint)point2{
    return [self radiusForPoint:CGPointMake(point1.x - point2.x, point1.y - point2.y)];
}

-(CGFloat)radiusForPoint:(CGPoint)point{
    return sqrtf((point.x*point.x) + (point.y*point.y));
}

#pragma mark - 核心动画的代理方法

-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.hidden = YES;
}



#pragma mark - 属性的Set && Get

- (UIColor *)progressTintColor
{
    return self.circularProgressLayer.progressTintColor;
}

- (void)setProgressTintColor:(UIColor *)progressTintColor
{
    self.circularProgressLayer.progressTintColor = progressTintColor;
    [self.circularProgressLayer setNeedsDisplay];
}

- (UIColor *)innerTintColor
{
    return self.circularProgressLayer.innerTintColor;
}

- (void)setInnerTintColor:(UIColor *)innerTintColor
{
    self.circularProgressLayer.innerTintColor = innerTintColor;
    [self.circularProgressLayer setNeedsDisplay];
}

- (BOOL)roundedCorners
{
    return self.roundedCorners;
}

- (void)setRoundedCorners:(BOOL)roundedCorners
{
    self.circularProgressLayer.roundedCorners = roundedCorners;
    [self.circularProgressLayer setNeedsDisplay];
}

- (CGFloat)thicknessRatio
{
    return self.circularProgressLayer.thicknessRatio;
}

- (void)setThicknessRatio:(CGFloat)thicknessRatio
{
    self.circularProgressLayer.thicknessRatio = MIN(MAX(thicknessRatio, 0.f), 1.f);
    [self.circularProgressLayer setNeedsDisplay];
}

-(void)setRadius:(CGFloat)radius{
    self.circularProgressLayer.radius = radius;
    [self.circularProgressLayer setNeedsDisplay];
}

-(CGFloat)radius{
    return self.circularProgressLayer.radius;
}

-(void)setProgressStyle:(SMCircularProgressStyle)progressStyle{
    self.circularProgressLayer.progressStyle = progressStyle;
    [self.circularProgressLayer setNeedsDisplay];
}

-(SMCircularProgressStyle)progressStyle{
    return self.circularProgressLayer.progressStyle;
}


-(void)setProgressMaskType:(SMCircularMaskType)progressMaskType{
    self.circularProgressLayer.progressMaskType = progressMaskType;
    [self.circularProgressLayer setNeedsDisplay];
}
-(SMCircularMaskType)progressMaskType{
    return self.circularProgressLayer.progressMaskType;
}
@end
