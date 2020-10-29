//
//  UIViewAnimationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/8.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "UIViewAnimationVC.h"
#define k_FontSize         (arc4random() % 15) + 12

@interface UIViewAnimationVC ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation UIViewAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    self.imgView.image = [UIImage imageNamed:@"aimage"];
    [self.view addSubview:self.imgView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 650, 100, 30)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"UIView动画" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(uiViewAnimation1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 650, 130, 30)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"UIView的block动画" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(uiViewAnimation2) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(160, 650, 130, 30)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"UIView的转场动画" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(uiViewAnimation3) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 700, 150, 30)];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"UIView的转场动画2" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(uiViewAnimation4) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
#warning 默认情况，"图层的position" 就是 "控件的中心点"
    NSLog(@"中心点 %@", NSStringFromCGPoint(self.imgView.center));
    NSLog(@"position %@", NSStringFromCGPoint(self.imgView.layer.position));
    NSLog(@"anchorPoint %@", NSStringFromCGPoint(self.imgView.layer.anchorPoint));
    
    [self uiViewAnimation5];
}

/// UIView动画
- (void)uiViewAnimation1 {
    [UIView beginAnimations:nil context:nil];
    //设置时间
    [UIView setAnimationDuration:3];
    
    //监听动画的完成
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(stop)];
    
    //实现动画代码
    self.imgView.center = CGPointMake(200, 280);
    [UIView commitAnimations];
}

- (void)stop {
    NSLog(@"监听动画的完成---%s", __func__);
}

/// UIView的block动画
- (void)uiViewAnimation2 {
    [UIView animateWithDuration:3 animations:^{
        self.imgView.center = CGPointMake(200, 280);
    } completion:^(BOOL finished) {
        NSLog(@"动画完成");
    }];
}

/// UIView的转场动画
- (void)uiViewAnimation3 {
//    UIViewAnimationOptionTransitionFlipFromLeft    = 1 << 20,
//    UIViewAnimationOptionTransitionFlipFromRight   = 2 << 20,
//    UIViewAnimationOptionTransitionCurlUp          = 3 << 20,
//    UIViewAnimationOptionTransitionCurlDown        = 4 << 20,
//    UIViewAnimationOptionTransitionCrossDissolve   = 5 << 20,
//    UIViewAnimationOptionTransitionFlipFromTop     = 6 << 20,
//    UIViewAnimationOptionTransitionFlipFromBottom  = 7 << 20,
    [UIView transitionWithView:self.imgView duration:3 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
        //更改image的图片
        self.imgView.image = [UIImage imageNamed:@"icon_2.jpg"];
    } completion:^(BOOL finished) {
        NSLog(@"动画执行完成");
    }];
}


- (void)uiViewAnimation4 {
    [UIView animateWithDuration:1 animations:^{
        
        // 缩放
//        _imageView.layer.transform = CATransform3DMakeRotation(M_PI, 1, 1, 0);
        // 平移
//        _imageView.layer.transform = CATransform3DMakeTranslation(200, 200, 0);
        
        // 缩放
//        _imageView.layer.transform = CATransform3DMakeScale(1, 0.5, 1);
        
    // 利用KVC改变形变
        
//     NSValue *rotation = [NSValue valueWithCATransform3D:CATransform3DMakeRotation(M_PI, 1, 1, 0)];
        
//        [_imageView.layer setValue:rotation forKeyPath:@"transform"];
        
        [self.imgView.layer setValue:@M_PI forKeyPath:@"transform.rotation"];
        
//        [_imageView.layer setValue:@0.5 forKeyPath:@"transform.scale"];
        
        // 平移x轴
//        [_imageView.layer setValue:@200 forKeyPath:@"transform.translation.x"];
        
        
    }];
}

- (void)uiViewAnimation5 {
    NSArray *colorArray = @[[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor],[UIColor redColor],[UIColor grayColor],[UIColor magentaColor],[UIColor brownColor]];
    NSMutableArray *titlesArray = [[NSMutableArray alloc] initWithObjects:@"灯具",@"地面",@"管材",@"石料",@"阀门",@"金属材料",@"家具",@"油漆",@"涂料", nil];
    NSMutableArray *frameArray = [[NSMutableArray alloc] initWithObjects:@"{{54, 92}, {120, 30}}",@"{{26, 228}, {120, 30}}",@"{{132, 124}, {120, 30}}",@"{{64, 146}, {120, 30}}",@"{{180, 175}, {120, 30}}",@"{{54, 190}, {120, 30}}",@"{{132, 238}, {120, 30}}",@"{{170, 269}, {120, 30}}",@"{{47, 290}, {120, 30}}", nil];
    
    for (int i =0; i< 9; i++) {
        UILabel *label = [[UILabel alloc]init];
        label.text = titlesArray[i];
        label.textColor = colorArray[arc4random()%[colorArray count]];
        label.font = [UIFont systemFontOfSize:k_FontSize];
        label.frame = CGRectZero;
        label.center = self.view.center;
        label.tag = i+1;
        [self.view addSubview:label];
    }
    
    for (int i =0; i< 9; i++) {
        for (UIView *view in [self.view subviews]) {
            if (view.tag == i+1) {
                [UIView animateWithDuration:2 animations:^{
                    view.frame = CGRectFromString(frameArray[i]);
                } completion:nil];
            }
        }
    }

}

@end
