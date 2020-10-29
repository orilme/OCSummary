//
//  GCDBarrierVC.m
//  多线程
//
//  Created by orilme on 2019/3/23.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "GCDBarrierVC.h"

@interface GCDBarrierVC ()

@end

@implementation GCDBarrierVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor greenColor];
    
    [self serialSyncBarrierSync];
    //[self serialASyncBarrierASync];
    //[self conCurrentQueueDisAsynBarriersyn];
    //[self conCurrentQueueDisAsynBarrierAsyn];
}

/*
 串行队列 ＋ 同步任务 + barrier_sync :没有开启新线程，都是逐一执行
 */
- (void)serialSyncBarrierSync {
    dispatch_queue_t queue = dispatch_queue_create("SerialSyncBarrierSync", DISPATCH_QUEUE_SERIAL);
    NSLog(@"串行队列 ＋ 同步任务 + barrier_sync----%@",[NSThread currentThread]);
    // 在队列里添加同步任务
    dispatch_sync(queue, ^{
        for(int i=0 ; i<5;i++){
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for(int i=0 ; i<5;i++){
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_sync(queue, ^{
        for(int  i=0 ; i<5;i++){
            NSLog(@"dispatch_barrier_async1----%@",[NSThread currentThread]);
        }
        for(int  i=0 ; i<5;i++){
            NSLog(@"dispatch_barrier_async2----%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"main---%@",[NSThread currentThread]);
    
    dispatch_sync(queue, ^{
        for(int i=0 ; i<5;i++){
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
}

/*
 串行队列 ＋ 同步任务 + barrier_async：都逐一执行，spatch_barrier_sync不阻碍主线程任务执行
 */
- (void)serialASyncBarrierASync {
    dispatch_queue_t queue = dispatch_queue_create("SerialASyncBarrierASync", DISPATCH_QUEUE_SERIAL);
    NSLog(@"串行队列 ＋ 同步任务 + barrier_async----%@",[NSThread currentThread]);
    // 在队列里添加同步任务
    dispatch_sync(queue, ^{
        for(int i=0 ; i<5; i++){
            NSLog(@"1---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_sync(queue, ^{
        for(int i=0 ; i<5; i++){
            NSLog(@"2---%@",[NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        for(int i=0 ; i<5; i++){
            NSLog(@"dispatch_barrier_async1----%@",[NSThread currentThread]);
        }
        for(int i=0 ; i<5; i++){
            NSLog(@"dispatch_barrier_async2----%@",[NSThread currentThread]);
        }
    });
    
    NSLog(@"main---%@",[NSThread currentThread]);
    
    dispatch_sync(queue, ^{
        for(int  i=0 ; i<5;i++){
            NSLog(@"3---%@",[NSThread currentThread]);
        }
    });
}

/*
 * 并行队列 + 异步 + barrier_sync:barrier_sync前的任务并发执行，syncbarrier后的任务必须等syncbarrier中的任务执行完成之后才会执行他们，也会阻塞主线程的任务
 */
- (void)conCurrentQueueDisAsynBarriersyn {
    dispatch_queue_t queue = dispatch_queue_create("ConCurrentQueueDisAsynBarriersyn", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"并发队列 ＋ 异步 + syncbarrier----%@", [NSThread currentThread]);
    // 队列中添加异步任务
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    });
    
    dispatch_barrier_sync(queue, ^{
        for(int i=0; i< 5; i++){
            NSLog(@"dispatch_barrier_async1----%@", [NSThread currentThread]);
        }
        
        for(int i=0 ; i<5; i++){
            NSLog(@"dispatch_barrier_async2----%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"main---%@", [NSThread currentThread]);
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    });
}

/*
 * 并行队列 + 异步 + barrier_async:barrier_async前的任务并发执行，barrier_async后的任务必须等barrier_async中的任务执行完成之后才会执行他们，但是Barrier不能阻塞主线程的任务
 */
- (void)conCurrentQueueDisAsynBarrierAsyn {
    dispatch_queue_t queue = dispatch_queue_create("ConCurrentQueueDisAsynBarrierAsyn", DISPATCH_QUEUE_CONCURRENT);
    NSLog(@"并发队列 ＋ 异步 + asyncbarrier----%@", [NSThread currentThread]);
    // 队列中添加异步任务
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"1---%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"2---%@", [NSThread currentThread]);
        }
    });
    
    dispatch_barrier_async(queue, ^{
        for(int i=0 ; i<5; i++){
            NSLog(@"dispatch_barrier_async1----%@", [NSThread currentThread]);
        }
        
        for(int i=0; i<5; i++){
            NSLog(@"dispatch_barrier_async2----%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"main---%@",[NSThread currentThread]);
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"3---%@", [NSThread currentThread]);
        }
    });
    
    dispatch_async(queue, ^{
        for (int i=0; i<5; i++) {
            NSLog(@"4---%@", [NSThread currentThread]);
        }
    });
}

@end
