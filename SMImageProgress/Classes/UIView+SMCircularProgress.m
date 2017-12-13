//
//  UIImageView+SMCircularProgress.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "UIView+SMCircularProgress.h"
#import "SMLabelCircularProgressView.h"
#import <objc/runtime.h>

@implementation UIView (SMCircularProgress)

static const char SMCircularProgressKey = '\0';

-(void)setSm_progressView:(SMLabelCircularProgressView *)sm_progressView{
    if (sm_progressView != self.sm_progressView ) {
        [self.sm_progressView removeFromSuperview];
        // 存储新的
        [self insertSubview:sm_progressView atIndex:999];
        sm_progressView.frame = self.bounds;
        [self willChangeValueForKey:@"sm_progressView"]; // KVO
        objc_setAssociatedObject(self, &SMCircularProgressKey,
                                 sm_progressView, OBJC_ASSOCIATION_ASSIGN);
        [self didChangeValueForKey:@"sm_progressView"]; // KVO
    }
}
- (SMLabelCircularProgressView *)sm_progressView{

    
    return objc_getAssociatedObject(self, &SMCircularProgressKey);
}

@end
