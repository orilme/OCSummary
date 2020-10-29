//
//  CAKeyframeAnimationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/7.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CAKeyframeAnimationVC.h"

@interface CAKeyframeAnimationVC ()
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation CAKeyframeAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(150, 250, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"aimage"];
    [self.view addSubview:self.imageView];
    
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 650, 100, 30)];
    startBtn.backgroundColor = [UIColor greenColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(250, 650, 100, 30)];
    stopBtn.backgroundColor = [UIColor redColor];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
    
    
    //添加一个圆
    UIView *circleView = [[UIView alloc] initWithFrame:CGRectMake(100, 300, 200, 200)];
    circleView.backgroundColor = [UIColor yellowColor];
    circleView.layer.cornerRadius = 100;
    [self.view addSubview:circleView];
    
    //把图片移到顶部
    [self.view bringSubviewToFront:self.imageView];
}

- (void)startAction {
    //抖动图片 使用帧动画 设置 旋转的 路径
    CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
    rotationAni.keyPath = @"transform.rotation";
    CGFloat angle = M_PI_4; //计算好旋转的弧度
    rotationAni.values = @[@(-angle),@(angle),@(-angle)]; //设置 旋转的路径
    rotationAni.repeatCount = MAXFLOAT; //设置动画执行的次数
    rotationAni.duration = 3.0;
    [self.imageView.layer addAnimation:rotationAni forKey:@"shake"];
}

- (void)stopAction {
    //通过key把动画移除,也就是把动画停止
    [self.imageView.layer removeAnimationForKey:@"shake"];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //学习帧动画
    //创建一个帧动画
    CAKeyframeAnimation *animaiton = [CAKeyframeAnimation animation];
    animaiton.keyPath = @"position";
    
#warning 注释掉和放开好像没啥区别呀，待研究
//    //设置动画执行的路径 指定四个点
//    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(200, 300)];
//    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(300, 400)];
//    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(200, 500)];
//    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(100, 400)];
//
//    //数组第一个是 “开始状态” 最后一个是 "结束状态"
//    animaiton.values = @[value1, value2, value3, value4, value1];
    
    //设置时间
    animaiton.duration = 5;
    
    //设置动画节奏
    //kCAMediaTimingFunctionEaseIn 先慢后快
    //kCAMediaTimingFunctionEaseOut 先快后慢
    //kCAMediaTimingFunctionLinear 线性匀速
    //kCAMediaTimingFunctionEaseInEaseOut 中间快两边慢
    animaiton.timingFunction =[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
#warning 内部的path的优级大小values优先级
    //设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddEllipseInRect(path, NULL, CGRectMake(100, 300, 200, 200));
    
    animaiton.path = path;
    //c语言的数据类型 如果create/copy/retain创建要释放
    CFRelease(path);
    
    //保存动画最后效果 (动画执行完成后是否回到原来的位置)
    animaiton.removedOnCompletion = NO;
    animaiton.fillMode=kCAFillModeForwards;
    
    //添加动画
    [self.imageView.layer addAnimation:animaiton forKey:nil];
    
}

@end
