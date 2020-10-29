//
//  GestureVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/9.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "GestureVC.h"

@interface GestureVC ()<UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imgView;
@property (weak, nonatomic) IBOutlet UIImageView *imgView2;
@property (weak, nonatomic) IBOutlet UIImageView *imgView3;
@end

@implementation GestureVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.imgView.userInteractionEnabled = YES;
    self.imgView2.userInteractionEnabled = YES;
    self.imgView3.userInteractionEnabled = YES;

    [self addTapGestureRecognizer];
    [self addLongPressGesture];
    [self addSwipeGesture];
    [self addPinchGesture];
    [self addRotationGesture];
    [self addRotationAndPinchGesture];
    [self addPanGesture];
}

/// 单击手势
- (void)addTapGestureRecognizer {
    UITapGestureRecognizer *tapGest = [[UITapGestureRecognizer alloc] init];
    tapGest.numberOfTapsRequired = 1; // 点击的次数
    //tapGest.numberOfTouchesRequired = 2; // 手指的数量
    tapGest.delegate = self;
    [tapGest addTarget:self action:@selector(tapView:)];
    [self.imgView addGestureRecognizer:tapGest];
}

- (void)tapView:(UITapGestureRecognizer *)tapGest{
    NSLog(@"手势---%s", __func__);
}

#pragma mark 手势的代理
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    //左边可以 点击 /右边不可以点击
//    CGPoint location = [touch locationInView:touch.view];
//    if (location.x <= touch.view.bounds.size.width * 0.5) {
//        return YES;
//    }
//    return NO;
    return YES;
}

/// 长按手势
- (void)addLongPressGesture {
    UILongPressGestureRecognizer *longGest = [[UILongPressGestureRecognizer alloc] init];
    [longGest addTarget:self action:@selector(longPressView:)];
    longGest.minimumPressDuration = 2;
    longGest.allowableMovement = 30; // 长按时，距离 "触摸点" 可移动的距离
    [self.imgView2 addGestureRecognizer:longGest];
}

- (void)longPressView:(UILongPressGestureRecognizer *)longPressGest {
    // 怎么判断 "长按" 开始和结束
    NSLog(@"长按手势---%s 手势状态 %ld",__func__,    longPressGest.state);
    if (longPressGest.state == UIGestureRecognizerStateBegan) {
        NSLog(@"长按手势开始---");
    }else{
        NSLog(@"长按手势结束---");
    }
}

/// 轻扫手势
- (void)addSwipeGesture {
    UISwipeGestureRecognizer *swipeGest = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeView:)];
    // 属性
    //UISwipeGestureRecognizerDirectionRight 向右轻扫
    //UISwipeGestureRecognizerDirectionLeft    向左轻扫
    //UISwipeGestureRecognizerDirectionUp    向上
    //UISwipeGestureRecognizerDirectionDown 向下
    swipeGest.direction = UISwipeGestureRecognizerDirectionUp;
    [self.imgView2 addGestureRecognizer:swipeGest];
}

- (void)swipeView:(UISwipeGestureRecognizer *)swipeGest {
    // 怎么判断 "长按" 开始和结束
    NSLog(@"轻扫手势---%s 手势状态 %ld",__func__, swipeGest.state);
}

/// 捏合手势
- (void)addPinchGesture {
    UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinView:)];
    [self.imgView addGestureRecognizer:pinchGest];
}

- (void)pinView:(UIPinchGestureRecognizer *)pinGest {
    // 缩放的比例是一个 "累加" 的过程
    NSLog(@"捏合手势---%s 缩放的比例 %f",__func__, pinGest.scale);
    
    // 设置图片的缩放
    
    // 10x10 / 1.0
    // 10*2.01 x 10*2.01     /1.01 + 1.0 = 2.01
    // 10*2.01 * 3.03  x  10*2.01*3.03      / 1.03 + 2.01 = 3.03
    
#warning 放大图片后， 再次缩放的时候，马上回到原先的大小
    //self.imageView.transform = CGAffineTransformMakeScale(pinGest.scale, pinGest.scale);
    
    self.imgView.transform = CGAffineTransformScale(self.imgView.transform, pinGest.scale, pinGest.scale);
    
    // 让比例还原，不要累加
    // 解决办法，重新设置scale
    pinGest.scale = 1;
}

/// 旋转手势
- (void)addRotationGesture {
    UIRotationGestureRecognizer *rotationGest = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationView:)];
    [self.imgView2 addGestureRecognizer:rotationGest];
}

- (void)rotationView:(UIRotationGestureRecognizer *)rotationGest {
    //旋转角度
    //旋转的角度也一个累加的过程
    NSLog(@"旋转手势---旋转角度 %f",rotationGest.rotation);
    // 设置图片的旋转
    self.imgView2.transform = CGAffineTransformRotate(self.imgView2.transform, rotationGest.rotation);
    // 清除 "旋转角度" 的累
    rotationGest.rotation = 0;
}

/// 旋转捏合手势
/**
* 默认情况下，控件只能 监听到一种 手势
* 如果要监听到多个手势，设置一个代理的方法，告知它允许 ”多个手势“ 并存
*/
- (void)addRotationAndPinchGesture {
    //给图片添加 "旋转手势"
    UIRotationGestureRecognizer *rotationGest = [[UIRotationGestureRecognizer alloc] initWithTarget:self action:@selector(rotationView2:)];
    rotationGest.delegate = self;
    [self.imgView3 addGestureRecognizer:rotationGest];
    //给图片添加 "捏合手势"
    UIPinchGestureRecognizer *pinchGest = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(pinchView2:)];
    [self.imgView3 addGestureRecognizer:pinchGest];
}

- (void)rotationView2:(UIRotationGestureRecognizer *)rotationGest {
    //旋转角度
    //旋转的角度也一个累加的过程
    NSLog(@"旋转角度 %f",rotationGest.rotation);
    // 设置图片的旋转
    self.imgView3.transform = CGAffineTransformRotate(self.imgView3.transform, rotationGest.rotation);
    rotationGest.rotation = 0; // 清除 "旋转角度" 的累
}

- (void)pinchView2:(UIPinchGestureRecognizer *)pinchGest {
    self.imgView3.transform = CGAffineTransformScale(self.imgView3.transform, pinchGest.scale, pinchGest.scale);
    pinchGest.scale = 1; // 还原
}

#pragma mark 手势代理
// Simultaneous 同时发生
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

/// 拖拽手势
- (void)addPanGesture {
    UIPanGestureRecognizer *panGest = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panView:)];
    [self.imgView addGestureRecognizer:panGest];
}

- (void)panView:(UIPanGestureRecognizer *)panGest {
    //panGest.view触摸的view
    //拖拽的距离 [距离是一个累加]
    CGPoint trans = [panGest translationInView:panGest.view];
    NSLog(@"%@",NSStringFromCGPoint(trans));
    
    // 设置图片移动
    CGPoint center = self.imgView.center;
    center.x += trans.x;
    center.y += trans.y;
    self.imgView.center = center;
    
    //清除 累加 的距离
    [panGest setTranslation:CGPointZero inView:panGest.view];
}
@end
