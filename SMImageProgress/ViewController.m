//
//  ViewController.m
//  SMImageProgress
//
//  Created by 孙慕 on 2017/11/16.
//  Copyright © 2017年 孙慕. All rights reserved.
//

#import "ViewController.h"
#import "UIView+SMCircularProgress.h"
@interface ViewController ()

@property(nonatomic,strong) SMLabelCircularProgressView *progressView;
@property(nonatomic,strong) UIImageView *imageView;
@property(nonatomic,strong) UIImageView *imageView1;
@property(nonatomic,strong) UIImageView *imageView2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 100, 100)];
    _imageView.image = [UIImage imageNamed:@"sm_400"];

    [self.view addSubview:_imageView];
    
    _imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    _imageView1.image = [UIImage imageNamed:@"sm_400"];
    [self.view addSubview:_imageView1];
    
    _imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(50, 250, 100, 100)];
    _imageView2.image = [UIImage imageNamed:@"sm_400"];
    [self.view addSubview:_imageView2];
  
    
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(200, 400, 100, 100)];
    [button addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:@"移除进度" forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:button];
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(200, 250, 100, 100)];
    [button1 addTarget:self action:@selector(btnClick1) forControlEvents:UIControlEventTouchUpInside];
    [button1 setTitle:@"添加进度" forState:UIControlStateNormal];
    [button1 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:button1];
    
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(50, 400, 100, 100)];
    [button2 addTarget:self action:@selector(btnClick2) forControlEvents:UIControlEventTouchUpInside];
    [button2 setTitle:@"点我" forState:UIControlStateNormal];
    [button2 setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:button2];
}

-(void)btnClick{
    
    [_imageView1.sm_progressView dismissProgressAnimated:YES];
    [_imageView.sm_progressView dismissProgressAnimated:YES];
    [_imageView2.sm_progressView dismissProgressAnimated:YES];
}


-(void)btnClick1{
    _imageView.sm_progressView = [[SMLabelCircularProgressView alloc] init];
    _imageView.sm_progressView.progressStyle = SMCircularProgressStyleAnnular;
    _imageView.sm_progressView.radius = 30;
    
    _imageView1.sm_progressView = [[SMLabelCircularProgressView alloc] init];
    _imageView1.sm_progressView.radius = 30;
    _imageView1.sm_progressView.progressStyle = SMCircularProgressStylePieChart;
    
    _imageView2.sm_progressView = [[SMLabelCircularProgressView alloc] init];
    _imageView2.sm_progressView.radius = 30;
    _imageView2.sm_progressView.progressMaskType = SMCircularMaskTypeNone;
    
}

-(void)btnClick2{
    
    _imageView.sm_progressView.progress = _imageView.sm_progressView.progress + 0.05;
    _imageView.sm_progressView.progressLabel.text = [NSString stringWithFormat:@"上传%.1f%%", _imageView.sm_progressView.progress * 100];
    
    _imageView1.sm_progressView.progress = _imageView1.sm_progressView.progress + 0.05;
    
    _imageView2.sm_progressView.progress = _imageView2.sm_progressView.progress + 0.05;
    _imageView2.sm_progressView.progressLabel.text = [NSString stringWithFormat:@"加载%.1f%%", _imageView.sm_progressView.progress * 100];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}


@end
