//
//  SMLabelCircularProgressView.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/17.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "SMLabelCircularProgressView.h"

@implementation SMLabelCircularProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeLabel];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initializeLabel];
    }
    return self;
}


#pragma mark - Internal methods

- (void)initializeLabel{

    self.progressLabel = [[UILabel alloc] initWithFrame:self.bounds];
//    self.progressLabel.center = self.center;
//    self.progressLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    
    self.progressLabel.adjustsFontSizeToFitWidth = YES;
    self.progressLabel.textColor = [UIColor whiteColor];
    self.progressLabel.backgroundColor = [UIColor clearColor];
    [self addSubview:self.progressLabel];
}


-(void)layoutSubviews{
    CGFloat magrin = 2;
    CGFloat labelW = 2 * self.radius * (1 - self.thicknessRatio);
    CGRect labelFrame = CGRectMake(self.center.x - (labelW  - magrin)/2, self.center.y - labelW/2 ,labelW - magrin,labelW);
    self.progressLabel.frame = labelFrame;
   
}

@end
