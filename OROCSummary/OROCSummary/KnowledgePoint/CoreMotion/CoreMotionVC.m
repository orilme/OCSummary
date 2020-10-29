//
//  CoreMotionVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/10.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "CoreMotionVC.h"
#import <CoreMotion/CoreMotion.h>

@interface CoreMotionVC ()
@property (nonatomic, strong) CMMotionManager *mgr;
@end

@implementation CoreMotionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 计步器
    [self setupStepCounter];
    
    // 陀螺仪
    [self pullGyro];
    //[self pushGyro];
    
    // 加速计
    [self pullAccelerometer];
    //[self pushAccelerometer];
    
}

#pragma mark - 计步器
- (void)setupStepCounter {
    // 0.判断CMStepCounter是否可用
    if (![CMStepCounter isStepCountingAvailable]) return;
    
    // 1.创建计步器对象
    CMStepCounter *stepCounter = [[CMStepCounter alloc] init];
    
    // 2.开始计步
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    [stepCounter startStepCountingUpdatesToQueue:queue updateOn:2 withHandler:^(NSInteger numberOfSteps, NSDate *timestamp, NSError *error) {
        NSLog(@"StepCounter---您已经走了%ld步", numberOfSteps);
    }];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // CMAcceleration acceleration = self.mgr.accelerometerData.acceleration;
    CMRotationRate rate = self.mgr.gyroData.rotationRate;
    NSLog(@"touchesBegan---x:%f y:%f z:%f", rate.x, rate.y, rate.z);
}

#pragma mark - 获取陀螺仪信息
- (void)pullGyro {
    // 1.陀螺仪是否可用
    if (!self.mgr.isGyroAvailable) return;
    
    // 2.开始采样
    [self.mgr startGyroUpdates];
}

- (void)pushGyro {
    // 1.陀螺仪是否可用
    if (!self.mgr.isGyroAvailable) return;
    
    // 2.设置采样间隔
    self.mgr.gyroUpdateInterval = 1.0;
    
    // 3.开始采样
    [self.mgr startGyroUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMGyroData *gyroData, NSError *error) {
        if (error) return;
        
        CMRotationRate rotationRate = gyroData.rotationRate;
        NSLog(@"pushGyro---x:%f y:%f z:%f", rotationRate.x, rotationRate.y, rotationRate.z);
    }];
}

#pragma mark - 获取加速计信息
- (void)pullAccelerometer {
    // 1.判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable) return;
    
    // 2.开始采样
    [self.mgr startAccelerometerUpdates];
}

- (void)pushAccelerometer {
    /*
     // 1.创建运行管理者
     CMMotionManager *mgr =
     */
    // 2.判断加速计是否可用
    if (!self.mgr.isAccelerometerAvailable) return;
    
    // 3.设置采样间隔
    self.mgr.accelerometerUpdateInterval = 1/30.0;
    
    // 4.开始采样
    [self.mgr startAccelerometerUpdatesToQueue:[NSOperationQueue mainQueue] withHandler:^(CMAccelerometerData *accelerometerData, NSError *error) {
        if (error) return ;
        // 获取到加速计信息
        CMAcceleration acceleration = accelerometerData.acceleration;
        NSLog(@"pushAccelerometer---x:%f y:%f z:%f", acceleration.x, acceleration.y, acceleration.z);
    }];
}

#pragma mark - Getter
- (CMMotionManager *)mgr {
    if (!_mgr) {
        _mgr = [[CMMotionManager alloc] init];
    }
    return _mgr;
}
@end
