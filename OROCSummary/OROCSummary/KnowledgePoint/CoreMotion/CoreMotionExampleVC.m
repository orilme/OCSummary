//
//  CoreMotionExampleVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/10.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "CoreMotionExampleVC.h"
#import <CoreMotion/CoreMotion.h>
#import "ORMotionManager.h"

@interface CoreMotionExampleVC ()

@property (nonatomic, weak) UIImageView *ballIv; // 小球
@property (nonatomic, assign) CGPoint ballVelocity; // 保存x y方向加速度
@property (nonatomic, strong) CMMotionManager *motionM; // 运动管理器
@property (nonatomic, strong) NSOperationQueue *queue;
@property (nonatomic, strong) CADisplayLink *link;

@end

@implementation CoreMotionExampleVC

/**
 运动管理器的属性
 
 1> accelerometerUpdateInterval     加速计更新间隔
 2> isAccelerometerAvailable        是否可用
 3> accelerometerActive             是否正在采集数据
 4> accelerometerData               加速计数据（通过Pull方式获得）
 5> startAccelerometerUpdatesToQueue    开始加速计更新（通过Push方式实时获得采样数据）
 6> stopAccelerometerUpdates        停止数据采样
 
 */

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    // 1.添加小球
    UIImage *image = [UIImage imageNamed:@"black"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:image];
    [self.view addSubview:iv];
    self.ballIv = iv;
    
    self.queue = [[NSOperationQueue alloc] init];
    
    
    // 2.实例化运动管理器
    //    CMMotionManager *montionM = [[CMMotionManager alloc] init];
    
    //    self.motionM = [[CMMotionManager alloc] init];
    self.motionM = [ORMotionManager shareMotionManager];
    
    // 3.判断加速计是否可用
    if (self.motionM.isAccelerometerAvailable) {
        // 3.1设置采样时间间隔
        self.motionM.accelerometerUpdateInterval = 1 / 30.0;
        /*
         // 3.2 开始采样数据
         //        [self.motionM startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *
         
         [self.motionM startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
         
         // NSLog(@"%@", [NSThread currentThread]);
         
         // 处理采样数据，修改小球速度
         _ballVelocity.x += accelerometerData.acceleration.x;
         _ballVelocity.y -= accelerometerData.acceleration.y;
         
         // 更改小球位置
         // [self updateLocation];
         }];
         */
        // 3.2 开始采样数据
        [self startAccelerometerUpdates];
    }else
    {
        NSLog(@"摔坏了");
    }
    
    // 4.实例化CADisplayLink
    /*
     在真机实际运行中，小球的显示并是不非常的清晰，会有一些发虚。
     */
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateLocation)];
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    self.link = link;
}

#pragma mark - 私有方法
#pragma mark 开始采样数据
- (void)startAccelerometerUpdates {
    [self.motionM startAccelerometerUpdatesToQueue:self.queue withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        // 处理采样数据，修改小球速度
        _ballVelocity.x += accelerometerData.acceleration.x;
        _ballVelocity.y -= accelerometerData.acceleration.y;
    }];
}

- (void)updateLocation {
    // 设置小球的位置
    CGPoint center = self.ballIv.center;
    CGSize size = self.view.bounds.size;
    
    // 解决小球出界问题，碰撞检测
    // 水平方向：左边，右边
    if (CGRectGetMinX(self.ballIv.frame) <= 0 || CGRectGetMaxX(self.ballIv.frame) >= size.width) {
        // 修改小球的速度方向
        _ballVelocity.x *= -1;
        
        // 修复位置 < 0
        if (CGRectGetMinX(self.ballIv.frame) <= 0) {
            center.x = self.ballIv.bounds.size.width / 2.0;
        } else {
            center.x = size.width - self.ballIv.bounds.size.width / 2.0;
        }
    }
    
    // 垂直方向
    if (CGRectGetMinY(self.ballIv.frame) <= 0 || CGRectGetMaxY(self.ballIv.frame) >= size.height) {
        // 修改小球的速度方向
        _ballVelocity.y *= -1;
        
        // 修复位置 < 0
        if (CGRectGetMinY(self.ballIv.frame) <= 0) {
            center.y = self.ballIv.bounds.size.height / 2.0;
        } else {
            center.y = size.height - self.ballIv.bounds.size.height / 2.0;
        }
    }
    
    center.x += _ballVelocity.x;
    center.y += _ballVelocity.y;
    
    // NSLog(@"%@", [NSThread currentThread]);
    
    // 在主线程队列上更新小球位置
    [[NSOperationQueue mainQueue] addOperationWithBlock:^{
        
        self.ballIv.center = center;
    }];
    
}

// 游戏“暂停”——用户点击屏幕，暂停小球运动
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if (self.motionM.isAccelerometerActive) {
        // 停止
        [self.motionM stopAccelerometerUpdates];
        
        /*
         invalidate停止时钟
         1> 将时钟从主运行循环中撤销
         2> 将时钟销毁
         [_gameTimer invalidate];
         */
        
        // 直接从主运行循环中将游戏时钟删除，而不会销毁时钟，等到需要时再次添加即可。
        [self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    } else {
        // 开始采样数据
        [self startAccelerometerUpdates];
        
        // 开启时钟
        [self.link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    }
}

@end



/*
 * PPT讲解CoreMontion
 * 新建工程导入CoreMontion框架, 拷贝常规使用添加小球代码
 * 导入CoreMontion框架主头文件, 查看头文件讲解相关属性含义
 * 实例化运动管理器,—>判断加速计是否可用—>设置采样数据的时间间隔—>开始采样数据 —>更改小球位置
 * 从运行没有反应引出CoreMontionManage是局部变量
 * 新建队列替换主队列, 从运行程序没有任何反应引出修改更新方法在主队列中修改UI
 * 从系统提供的CoreMontionManage不是单例,引出定义子类实现单例(讲解如何实现单例)
 * 画图讲解从采样时间和刷帧时间不一样小球现实会不清晰引出采样和刷帧单独进行
 * 从加速计常用于游戏引出实现点击频幕后暂停游戏, 注意不需要每次都销毁CADisplayLink
 */
