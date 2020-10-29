//
//  ThreadLockVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/4.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "ThreadLockVC.h"

@interface ThreadLockVC (){
    int _n;
    NSCondition *_condition; //专门用来做线程同步的
}

@end

@implementation ThreadLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(100, 100, 180, 50);
    [btn setTitle:@"NSCondition" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    [self testNSLock];
    sleep(8);
    [self testSynchronized];
    [self testNSCondition];
}

- (void)testNSLock {
    NSLock *lock = [[NSLock alloc] init];
    /// 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [lock lock];
        [self method1];
        sleep(3);
        [lock unlock];
    });

    /// 线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(3); // 以保证让线程2的代码后执行
        [lock lock];
        [self method2];
        [lock unlock];
    });
}

- (void)testSynchronized {
    /// 线程1
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            [self method1];
            sleep(3);
        }
    });

    /// 线程2
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        @synchronized(self) {
            sleep(3); // 以保证让线程2的代码后执行
            [self method2];
        }
    });
}

- (void)testNSCondition {
    _n = 0;
    _condition = [[NSCondition alloc]init];
    [NSThread detachNewThreadSelector:@selector(thread) toTarget:self withObject:nil];
}

- (void)method1 {
    NSLog(@"method1---%@", NSStringFromSelector(_cmd));
    NSLog(@"method1---Current thread = %@", [NSThread currentThread]);
    NSLog(@"method1---Main thread = %@", [NSThread mainThread]);
}

- (void)method2{
    NSLog(@"method2---%@", NSStringFromSelector(_cmd));
    NSLog(@"method2---Current thread = %@", [NSThread currentThread]);
    NSLog(@"method2---Main thread = %@", [NSThread mainThread]);
}

- (void)onBtnClicked {
    [_condition lock];
    _n ++;
    [_condition signal]; // 发信号，如果有线程在等这个信号，那个线程会被唤醒进入就绪状态
    [_condition unlock];
}

- (void)thread {
    //每当_n加1之后就打印
    while (1) {
        //等待_n备好
        //打印_n
        [_condition lock];
        [_condition wait];//等信号，线程进入阻塞状态，直到有人在_condition上发信号（调用signal）。有的时候没有人发信号,wait也可返回（有人叫假唤醒）。
        NSLog(@"%d", _n);
        [_condition unlock];
    }
}

@end
