//
//  ProximityMonitorVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/10.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "ProximityMonitorVC.h"

@interface ProximityMonitorVC ()

@end

@implementation ProximityMonitorVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor grayColor];
    
    // 距离传感器
    [self setupProximit];
}

#pragma mark - 距离传感器
- (void)setupProximit {
    // 距离传感器默认是关闭(实时的检测是否有物品靠近,所有非常耗电)
    [UIDevice currentDevice].proximityMonitoringEnabled = YES;
    
    // 通过通知(一旦有物品靠近或者离开的时候,都会发出通知)
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(proximityStateDidChange) name:UIDeviceProximityStateDidChangeNotification object:nil];
}
/**  当有物品靠近或者离开的时候会调用该方法 */
- (void)proximityStateDidChange {
    if ([UIDevice currentDevice].proximityState) {
        NSLog(@"有物品靠近---");
    } else {
        NSLog(@"有物品离开---");
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - 摇一摇
/** 开始摇一摇 */
- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionBegan---");
}

/** 摇一摇结束（需要在这里处理结束后的代码） */
- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    // 不是摇一摇运动事件
    if (motion != UIEventSubtypeMotionShake) return;
    NSLog(@"motionEnded---");
}

/** 摇一摇取消（被中断，比如突然来电） */
- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    NSLog(@"motionCancelled---");
}

@end
