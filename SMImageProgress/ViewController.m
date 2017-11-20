//
//  ViewController.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+SMCircularProgress.h"
@interface ViewController ()

@property(nonatomic,strong) SMLabelCircularProgressView *progressView;
@property(nonatomic,strong) UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    _imageView.backgroundColor = [UIColor grayColor];
    _imageView.sm_progressView = [[SMLabelCircularProgressView alloc] init];
    _imageView.sm_progressView.radius = 40; 
    [self.view addSubview:_imageView];

}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    _imageView.sm_progressView.progress = _imageView.sm_progressView.progress + 0.1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
 
    
}


@end
