
![](https://github.com/iossun/bolgImage/raw/master/SMImageProgress/SmImageProgress.gif
)
 
##### 使用CocoaPods

```
pod "SMImageProgress"
```

##### 手动导入

将Classes文件夹中的所有源代码拽入项目中

导入主头文件：#import "UIView+SMCircularProgress.h"

##### 示例

###### 初始化

```
 _imageView.sm_progressView = [[SMLabelCircularProgressView alloc] init];
 _imageView.sm_progressView.progressStyle = SMCircularProgressStyleAnnular;
``` 

###### 样式设置接口

```
/* 环形进度条颜色 */
@property(nonatomic, strong) UIColor *progressTintColor;
/* 内部圆形颜色 */
@property(nonatomic, strong) UIColor *innerTintColor;
/* 环形是否圆角 */
@property(nonatomic,assign) BOOL roundedCorners;
/* 环宽所占半径的比例 */
@property(nonatomic,assign) CGFloat thicknessRatio;
/* 半径 */
@property(nonatomic,assign) CGFloat radius;
/* 进度样式 */
@property(nonatomic,assign) SMCircularProgressStyle progressStyle;
/* 模式 默认带蒙板 */
@property(nonatomic,assign) SMCircularMaskType progressMaskType;
```   

###### 绘画进度

```
- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;
```

###### 绘画原理

在drawInContext()里调用各种CoreGraphics的API,根据设置progress，不断重绘制


###### 淡出动画

![](https://github.com/iossun/bolgImage/raw/master/SMImageProgress/SMImageProgress.001.jpeg
)
mask 属性本身就是个CALayer类型，有和其他图层一样的绘制和布局属性，CALayer 蒙版图实心的部分会被保留下来，其他的则会被抛弃。

在绘制图层上加上mask层，设置mask图层，动画（mask图层以图片中为圆心，绘制遮盖所有进度图层的圆，动画mask图层半径不变，宽度不断缩短，图层重叠缩小，可见图层可见不断缩小）



如有问题：ios_sunmu@icloud.com
