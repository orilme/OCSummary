//
//  CABasicAnimationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/7.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CABasicAnimationVC.h"

@interface CABasicAnimationVC ()
@property (nonatomic, strong) UIImageView *imgView;
@end

@implementation CABasicAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 100, 100)];
    self.imgView.image = [UIImage imageNamed:@"aimage"];
    [self.view addSubview:self.imgView];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 650, 100, 30)];
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"缩放动画" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(testTransformScaleAnnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 650, 130, 30)];
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"旋转动画" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(testTransformRoationAnnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(260, 650, 130, 30)];
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"平移动画" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(testTransformTranslationAnnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 700, 100, 30)];
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"位置动画" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(testPositionAnnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(120, 700, 130, 30)];
    btn5.backgroundColor = [UIColor redColor];
    [btn5 setTitle:@"尺寸动画" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(testBoundsAnnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
}

#pragma mark 测试形变的 "缩放" 的动画
- (void)testTransformScaleAnnimation {
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //设置动画类型 -》 keyPath设置图层的属性 bounds/position/transform。。。。
    animation.keyPath = @"transform.scale.x";
    
    // 设置动画的时间
    animation.duration = 3;
    
    //动画执行的 "初始状态"
    
    //动画执行的 "最终状态"
    
    //每次动画执行的  "增加值"
    //byValue的数据类型 由 keyPath 决定
    animation.byValue = @1.5;
    
    //保存动画执行状态
    //解决方案2：使动画保存执行之后的状态，只要设置动画的两个属性
    animation.removedOnCompletion = NO;//动画对象不要移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    //animation.repeatCount = MAXFLOAT; // 重复的次数
    animation.repeatCount = 2; // 重复的次数
    
    // 取消反弹
    // 动画执行完毕之后不要把动画移除
    animation.removedOnCompletion = NO;
    
    //2.往控件的图层添加动画
    [self.imgView.layer addAnimation:animation forKey:nil];
}

#pragma mark 测试形变的 "旋转" 的动画
- (void)testTransformRoationAnnimation {
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //设置动画类型
    animation.keyPath = @"transform.rotation.x";
    
    //动画执行的 "初始状态"
    
    
    //动画执行的 "最终状态"
    
    //每次动画执行的  "增加值"
    //byValue的数据类型 由 keyPath 决定
    animation.byValue = @(M_PI_4);
    
    
    //保存动画执行状态
    //解决方案2：使动画保存执行之后的状态，只要设置动画的两个属性
    animation.removedOnCompletion = NO;//动画对象不要移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    
    
    //2.往控件的图层添加动画
    [self.imgView.layer addAnimation:animation forKey:nil];
}

#pragma mark 测试形变的 "平移" 的动画
- (void)testTransformTranslationAnnimation {
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //设置动画类型
    //animation.keyPath = @"transform.translation";
    animation.keyPath = @"transform.translation.x";
    
    //动画执行的 "初始状态"
   
    
    //动画执行的 "最终状态"
   
    
    
    //每次动画执行的  "增加值"
    //animation.byValue = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    //byValue的数据类型 由 keyPath 决定
    animation.byValue = @10;
   
    
    //保存动画执行状态
    //解决方案2：使动画保存执行之后的状态，只要设置动画的两个属性
    animation.removedOnCompletion = NO;//动画对象不要移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    
    
    //2.往控件的图层添加动画
    [self.imgView.layer addAnimation:animation forKey:nil];
}


#pragma mark 测试位置的动画
- (void)testPositionAnnimation {
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    
    //设置动画类型
    animation.keyPath = @"position";
    
    //动画执行的 "初始状态"
    //animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(100, 100)];
    
    //动画执行的 "最终状态"
    //animation.toValue = [NSValue valueWithCGPoint:CGPointMake(100, 250)];
    
    
    //每次动画执行的  "增加值"
    animation.byValue = [NSValue valueWithCGPoint:CGPointMake(10, 10)];
    
    //保存动画执行状态
    //解决方案2：使动画保存执行之后的状态，只要设置动画的两个属性
    animation.removedOnCompletion = NO;//动画对象不要移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    
    
    //2.往控件的图层添加动画
    [self.imgView.layer addAnimation:animation forKey:nil];
}

#pragma mark 测试尺寸的动画
- (void)testBoundsAnnimation {
    //核心动画使用步骤
    //1.创建一个动画对象
    CABasicAnimation *animation = [CABasicAnimation animation];
    
#warning 核心动画，只是一个假象，真实的大小是没有变化，
    /*
     *解决方案1：如果想控件的大小真实改变，要在动画结束之后设置控件的尺寸
     *解决方案2：使动画保存执行之后的状态，默认动画执行完后，会返回原来的状态
     */
    
    
    //设置图层的 "属性"来 决定 "动画类型"
    //bounds 图层的尺寸动画
    animation.keyPath = @"bounds";
    
    //设置bounds尺寸变化后的大小
    animation.toValue = [NSValue valueWithCGRect:CGRectMake(0, 0, 150, 150)];
    
    //解决方案1： 动画的代理
    //animation.delegate = self;
    
    //解决方案2：使动画保存执行之后的状态，只要设置动画的两个属性
    animation.removedOnCompletion = NO;//动画对象不要移除
    animation.fillMode = kCAFillModeForwards;//保存当前的状态
    
    
    //2.往控件的图层添加动画
    [self.imgView.layer addAnimation:animation forKey:nil];
}

#pragma mark 核心动画的代理
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"核心动画执行之后的positon %@", NSStringFromCGPoint(self.imgView.layer.position));
    self.imgView.bounds = CGRectMake(0, 0, 150, 150);
}

@end
