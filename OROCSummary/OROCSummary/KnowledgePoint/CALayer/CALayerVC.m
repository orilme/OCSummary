//
//  CALayerVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/1.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CALayerVC.h"
#import "UIImage+CornerRadius.h"

@interface CALayerVC ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CALayerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"aimage"];
    [self.view addSubview:self.imageView];
    
    // 圆角和阴影
    [self shadowAndCornerRadius];
    
    [self basicUse1];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    self.imageView.layer.bounds = CGRectMake(0, 0, 300, 300);
    //缩放
    self.imageView.layer.transform = CATransform3DMakeScale(0.5, 0.5, 1);
    
    //旋转
    //x轴旋转
    self.imageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 0, 0);
    
    //y轴旋转
    self.imageView.layer.transform = CATransform3DMakeRotation(M_PI_4, 0, 1, 0);

    //z轴旋转
    self.imageView.layer.transform = CATransform3DMakeRotation(-M_PI_4, 0, 0, 1);
    
    //平移
    self.imageView.layer.transform = CATransform3DMakeTranslation(-10, -10, 0);
    
    //=============KVC================
    
    //缩放
    //xy方向拉伸
    [self.imageView.layer setValue:@(1.5) forKeyPath:@"transform.scale"];
    //只有x方向拉伸
    [self.imageView.layer setValue:@(1.5) forKeyPath:@"transform.scale.x"];
    //只有y方向拉伸
    [self.imageView.layer setValue:@(1.5) forKeyPath:@"transform.scale.y"];

    //旋转
    [self.imageView.layer setValue:[NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI_4, 0, 1, 0)] forKeyPath:@"transform"];
    
    [self.imageView.layer setValue:@(M_PI_4) forKeyPath:@"transform.rotation.x"];
    [self.imageView.layer setValue:@(-M_PI_4) forKeyPath:@"transform.rotation.z"];
    
    //平移
    [self.imageView.layer setValue:[NSValue valueWithCGPoint:CGPointMake(10, 10)] forKeyPath:@"transform.translation"];
    [self.imageView.layer setValue:@10  forKeyPath:@"transform.translation.x"];
}


- (void)shadowAndCornerRadius {
    // 如果又想图片有圆角效果，又想有阴影，那图片只能是本来就有圆角效果的，不用代码设置
    self.imageView.image = [UIImage cornerImageWithImageName:@"aimage" cornerRadius:15 borderColor:[UIColor blueColor] borderWithd:2];
   
    // 设置阴影
    self.imageView.layer.shadowColor = [UIColor greenColor].CGColor;
    self.imageView.layer.shadowOpacity = 0.9;
    // 设置阴影起始位置
    self.imageView.layer.shadowOffset =  CGSizeMake(50, 50);
    
    // 如果图片添加了圆角并设置了剪切掉多余的部分，阴影效果不会出现
    //self.imageView.layer.cornerRadius = 15;
    //self.imageView.layer.masksToBounds = YES;
}

- (void)basicUse1 {
    CALayer *redLayer = [CALayer layer];
    
    //设置大小
    redLayer.bounds = CGRectMake(0, 0, 100, 100);
    
    //设置颜色
    redLayer.backgroundColor = [UIColor redColor].CGColor;
    
    //设置位置
    redLayer.position = CGPointMake(150, 550);
    
    //边框颜色
    redLayer.borderColor = [UIColor grayColor].CGColor;
    redLayer.borderWidth = 2;
    
    //设置圆角
    redLayer.cornerRadius = 15;
    
    //设置内容
    redLayer.contents = (id)[UIImage imageNamed:@"aimage"].CGImage;
    redLayer.masksToBounds = YES;
    
    //添加到控制器view的图片上
    [self.view.layer addSublayer:redLayer];
}

@end
