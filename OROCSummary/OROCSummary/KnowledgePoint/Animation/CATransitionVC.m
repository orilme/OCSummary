//
//  CATransitionVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/8.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CATransitionVC.h"

#define AnimationDuration 2

@interface CATransitionVC ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, weak) CALayer *layer; // 非根层

@property (nonatomic, strong) UIImageView *imgView;
@property(nonatomic, strong) NSMutableArray *imgs;
@property(nonatomic, assign) NSInteger currentImgIndex;//当前图片的索引
@end

@implementation CATransitionVC

- (NSMutableArray *)imgs {
    if (!_imgs) {
        _imgs = [NSMutableArray array];
        for (NSInteger i = 1; i < 10; i++) {
            NSString *imgName = [NSString stringWithFormat:@"icon_%ld.jpg", i];
            [_imgs addObject:imgName];
        }
    }
    
    return _imgs;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imgView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 300, 500)];
    self.imgView.image = [UIImage imageNamed:@"icon_1.jpg"];
    [self.view addSubview:self.imgView];
    
    UIButton *previousBtn = [[UIButton alloc]initWithFrame:CGRectMake(50, 650, 100, 30)];
    previousBtn.backgroundColor = [UIColor redColor];
    [previousBtn setTitle:@"上一个" forState:UIControlStateNormal];
    [previousBtn addTarget:self action:@selector(previous) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:previousBtn];
    
    UIButton *nextBtn = [[UIButton alloc]initWithFrame:CGRectMake(200, 650, 100, 30)];
    nextBtn.backgroundColor = [UIColor greenColor];
    [nextBtn setTitle:@"下一个" forState:UIControlStateNormal];
    [nextBtn addTarget:self action:@selector(next) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
    [self testCATransaction];

}

- (void)previous {
    //判断当前图片是不是第一张
    if(self.currentImgIndex == 0){
        NSLog(@"已经是第一张");
        return;
    }
    
    //减索引 改图片
    self.currentImgIndex --;
    
    self.imgView.image = [UIImage imageNamed:self.imgs[self.currentImgIndex]];
    
    //转场动画
    CATransition *animation = [CATransition animation];
    animation.type = @"push";
    //默认就是fromLeft
    animation.subtype = @"fromLeft";
    
    animation.duration = AnimationDuration;
    
    [self.imgView.layer addAnimation:animation forKey:nil];


}

/**
 * 提示:转场的动画的类型（type）和子头型(subtype) 能用字符串常量就用字符常量
 */


/**
 *******************************************************
 type:动画类型(比如：滴水效果，翻转效果...)
 -------------------------------------------------------
 fade kCATransitionFade 交叉淡化过渡
 moveIn kCATransitionMoveIn 新视图移到旧视图上面
 push kCATransitionPush 新视图把旧视图推出去
 reveal kCATransitionReveal 将旧视图移开,显示下面的新视图
 pageCurl               向上翻一页
 pageUnCurl             向下翻一页
 rippleEffect             滴水效果
 suckEffect 收缩效果，如一块布被抽走
 cube                   立方体效果
 oglFlip              上下左右翻转效果
 rotate     旋转效果
 cameraIrisHollowClose 相机镜头关上效果(不支持过渡方向)
 cameraIrisHollowOpen 相机镜头打开效果(不支持过渡方向)
 
 *******************************************************
 subtype: 动画方向(比如说是从左边进入，还是从右边进入...)
 ------------------------------------------------------
 kCATransitionFromRight;
 kCATransitionFromLeft;
 kCATransitionFromTop;
 kCATransitionFromBottom;
 
 当 type 为@"rotate"(旋转)的时候,它也有几个对应的 subtype,分别为:
 90cw 逆时针旋转 90°
 90ccw 顺时针旋转 90°
 180cw 逆时针旋转 180°
 180ccw  顺时针旋转 180°
 **/
-(void)next{
    
    //判断当前图片是不是最后一张
    if (self.currentImgIndex == self.imgs.count - 1) {
        NSLog(@"已经是最后一张");
        return;
    }
    
    //加索引 改图片
    self.currentImgIndex ++;
    
    self.imgView.image = [UIImage imageNamed:self.imgs[self.currentImgIndex]];
    
    //切换图片的时候，使用转场动画
    CATransition *annimation = [CATransition animation];
    
    //设置转场动画的类型
    //`fade', 渐变
    //`moveIn', `push' and `reveal'
    annimation.type = @"rotate";
    
    //设置转卖动画的子类型
//    fromLeft', 动画由左边开始
//    `fromRight', 动画由右边开始
//    `fromTop' and
//    * `fromBottom'
    annimation.subtype = @"90cw";
    
    annimation.duration = 3;
    
    [self.imgView.layer addAnimation:annimation forKey:nil];
    
    
    
}

- (void)testCATransaction {
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 750, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"aimage"];
    [self.view addSubview:self.imageView];
    
    /*
     * weak 与 strong 使用
     * 只要这个对象被强引用一次，就无须再次强引用
     */
    // 创建一个 非根层
    CALayer *layer = [CALayer layer];
    layer.contents = (id)[UIImage imageNamed:@"aimage"].CGImage; // 设置内容
    layer.bounds = CGRectMake(0, 0, 100, 100); // 设置大小
    layer.position = CGPointMake(350, 750); // 设置位置
    layer.anchorPoint = CGPointMake(0.5, 0.5); // 设置锚点
    [self.view.layer addSublayer:layer];

    self.layer = layer;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 隐藏动画
    
    //self.imageView.layer 它是根层
#warning 根层改变属性是没有动画，只有非根层改变属性就有默认的动画
    //设置根层的大小
    self.imageView.layer.bounds = CGRectMake(20, 750, 150, 150);
    
    // 设置非根层的大小
    // 想默认动画时间设置长一点
    [CATransaction begin];
    //[CATransaction setDisableActions:YES]; // 关闭隐藏动画
    [CATransaction setAnimationDuration:5];
    // 看到transform旋转的动画效果
    self.layer.bounds = CGRectMake(0, 0, 150, 150);
    self.layer.transform = CATransform3DMakeRotation(M_PI_4, 1, 1, 1);
    [CATransaction commit];
}


@end
