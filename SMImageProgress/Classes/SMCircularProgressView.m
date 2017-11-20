//
//  SMCircularProgressView.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "SMCircularProgressView.h"
#import "SMCircularProgressLayer.h"

@interface SMCircularProgressView(){
    
}
@property (nonatomic,strong)SMCircularProgressLayer *circularProgressLayer;

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
        
//        self.circularProgressLayer = [SMCircularProgressLayer layer];
//        _circularProgressLayer.frame = frame;
//        [self.layer addSublayer:_circularProgressLayer];
        [self setTrackTintColor:[[UIColor whiteColor] colorWithAlphaComponent:0.3f]];
        [self setProgressTintColor:[UIColor whiteColor]];
        [self setInnerTintColor:nil];
        [self setBackgroundColor:[UIColor clearColor]];
        [self setThicknessRatio:0.3f];
        [self setRadius:20];
        [self setRoundedCorners:YES];
    }
    
    return self;
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



- (UIColor *)trackTintColor
{
    return self.circularProgressLayer.trackTintColor;
}

- (void)setTrackTintColor:(UIColor *)trackTintColor
{
    self.circularProgressLayer.trackTintColor = trackTintColor;
    [self.circularProgressLayer setNeedsDisplay];
}

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

-(CGFloat)radius{
    return self.radius;
}

-(void)setRadius:(CGFloat)radius{
    self.circularProgressLayer.radius = radius;
}


@end
