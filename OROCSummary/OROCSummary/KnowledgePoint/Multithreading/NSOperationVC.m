//
//  NSOperationVC.m
//  GCD
//
//  Created by orilme on 2018/7/28.
//  Copyright © 2018年 orilme. All rights reserved.
//

#import "NSOperationVC.h"

@interface NSOperationVC ()
/**负责调度所有的操作*/
@property(nonatomic,strong) NSOperationQueue *opQueue;
@end

@implementation NSOperationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

// 懒加载的方式，初始化NSOperationQueue对象
- (NSOperationQueue *)opQueue {
    if (_opQueue == nil) {
        _opQueue = [[NSOperationQueue alloc] init];
    }
    return _opQueue;
}

#pragma mark - 基本使用
// MARK: 单个NSInvocationOperation使用
- (void)opDemo1 {
    // 1. 创建操作
    NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
    
    // 2. 启动-- 直接在当前线程执行任务
    //    [op start];  // operation直接调用start，是同步执行（在当前线程执行操作）
    //    [self downloadImage:@""];
    
    // 2. 放到队列
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    [q addOperation:op]; // 只要把操作添加到队列， ---会自动异步执行调度方法
}

- (void)opDemo {
    
    NSBlockOperation *operation = [[NSBlockOperation alloc] init];
    
    [operation addExecutionBlock:^{
        NSLog(@"---下载图片----1---%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"---下载图片----2---%@", [NSThread currentThread]);
    }];
    
    [operation addExecutionBlock:^{
        NSLog(@"---下载图片----3---%@", [NSThread currentThread]);
    }];
    
    [operation start];
    
    // 任务数量 > 1，才会开始异步执行
}

// MARK: 多个NSInvocationOperation使用
- (void)opDemo2 {
    // 队列 (GCD里面的并发（全局）队列使用最多。所以NSOperation技术直接把GCD里面的并发队列封装起来)
    // NSOperationQueue队列，本质就是GCD里面的并发队列
    // 操作就是GCD里面异步执行的任务
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    
    // 把多个操作放到队列
    for (int i = 0 ; i < 10; i++) {
        NSOperation *op = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
        // 把block操作放到队列
        [q addOperation:op];
    }
}

// MARK: NSBlockOperation使用
- (void)opDemo3 {
    // 相当于GCD的并发队列
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    
    // 主队列(跟GCD里的主队列一样)
    //    NSOperationQueue *q = [NSOperationQueue mainQueue];
    
    // 多个操作
    for (int i = 0; i < 10; i++) {
        NSBlockOperation * op = [NSBlockOperation blockOperationWithBlock:^{
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
        
        // 把block操作放到队列
        [q addOperation:op];
    }
    
    NSLog(@"完成");
}

// MARK: NSBlockOperation更简单的使用
- (void)opDemo4 {
    // 队列
    NSOperationQueue *q = [[NSOperationQueue alloc] init];
    
    for (int i = 0; i < 10; i++) {
        // 不创建操作对象，使用addOperationWithBlock:直接添加操作到队列
        [q addOperationWithBlock:^{
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
    }
    
    // 创建并添加一个 NSBlockOperation
    NSBlockOperation * op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"op1 --- %@", [NSThread currentThread]);
        
    }];
    [op1 addExecutionBlock:^{
        NSLog(@"op1-1");
    }];
    [q addOperation:op1];
    
    // 创建并添加一个 NSInvocationOperation
    NSOperation *op2 = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(downloadImage:) object:@"Invocation"];
    [q addOperation:op2];
}

// MARK: 线程间通信(最重要的代码)
- (void)opDemo5 {
    NSOperationQueue *q = [[NSOperationQueue alloc]init];
    
    [q addOperationWithBlock:^{
        NSLog(@"耗时操作....%@", [NSThread currentThread]);
        
        // 在主线程更新UI
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            NSLog(@"更新UI....%@", [NSThread currentThread]);
        }];
    }];
}

// MARK: 最大并发数
- (void)opMaxConcurrentOperationCount {
    // 设置最大的并发数是2 (最大并发数，不是线程的数量。 而是同时执行的操作的数量)
    self.opQueue.maxConcurrentOperationCount = 2;
    
    for (int i = 0; i < 20; i++) {
        NSOperation *op = [NSBlockOperation blockOperationWithBlock:^{
            
            [NSThread sleepForTimeInterval:1.0];
            
            NSLog(@"%@---%d", [NSThread currentThread], i);
        }];
        
        [self.opQueue addOperation:op];
    }
}

#pragma mark - 耗时操作
- (void)downloadImage:(id)obj {
    NSLog(@"%@---%@", [NSThread currentThread], obj);
}

#pragma mark - 高级操作
// MARK: 暂停/继续 (对队列的暂停和继续)
- (void)pause {
    // 判断操作的数量，当前队列里面是不是有操作
    if (self.opQueue.operationCount == 0) {
        NSLog(@"没有操作");
        return;
    }
    
    // 暂停继续
    self.opQueue.suspended = !self.opQueue.suspended;
    
    if (self.opQueue.suspended) { // 队列的挂起以后，队列里面的操作还在
        NSLog(@"暂停");
    }else{
        NSLog(@"继续");
    }
}

// MARK: 取消队列里的所有操作
// “取消操作，并不会影响队列的挂起状态”
- (void)cancelAll {
    // 取消队列的所有操作
    [self.opQueue cancelAllOperations]; // 取消队列的所有操作，会把任务从队列里面全部删除
    
    NSLog(@"取消所有的操作");
    
    // 取消队列的挂起状态
    // （只要是取消了队列的操作，我们就把队列处于启动状态。以便于队列的继续）
    self.opQueue.suspended = NO;
}

// MARK: 依赖关系
- (void)dependencyBasic {
    /**
     假设有A、B、C三个操作，要求：
     1. 3个操作都异步执行
     2. 操作C依赖于操作B
     3. 操作B依赖于操作A
     */
    
    // 1.创建一个队列（非主队列）
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];
    
    // 2.创建3个操作
    NSBlockOperation *operationA = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"A1---%@", [NSThread currentThread]);
    }];
    
    //    operationA 又添加一个任务
    //    [operationA addExecutionBlock:^{
    //        NSLog(@"A2---%@", [NSThread currentThread]);
    //    }];
    
    //    operationA 执行完马上做某个操作
    //    [operationA setCompletionBlock:^{
    //        NSLog(@"AAAAA---%@", [NSThread currentThread]);
    //    }];
    
    NSBlockOperation *operationB = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"B---%@", [NSThread currentThread]);
    }];
    NSBlockOperation *operationC = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"C---%@", [NSThread currentThread]);
    }];
    
    // 设置依赖
    [operationB addDependency:operationA];
    [operationC addDependency:operationB];
    
    // 3.添加操作到队列中（自动异步执行任务）
    [queue addOperation:operationC];
    [queue addOperation:operationA];
    [queue addOperation:operationB];
}

- (void)dependency {
    /**
     例子：
     1. 下载一个小说的压缩包
     2. 解压缩，删除压缩包
     3. 更新UI
     */
    NSBlockOperation *op1 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"1. 下载一个小说的压缩包, %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op2 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"2. 解压缩，删除压缩包, %@",[NSThread currentThread]);
    }];
    NSBlockOperation *op3 = [NSBlockOperation blockOperationWithBlock:^{
        NSLog(@"3. 更新UI, %@",[NSThread currentThread]);
    }];
    
    // 指定任务之间的依赖关系 -- 依赖关系可以跨队列(可以在子线程下载完，到主线程更新UI)
    [op2 addDependency:op1];
    [op3 addDependency:op2];
    
    // 注意点：一定不要出现循环依赖关系
    //    [op1 addDependency:op3];
    
    // waitUntilFinished 类似GCD的调度组的通知
    // NO 不等待，会直接执行  NSLog(@"come here");
    // YES 等待上面的操作执行结束，再 执行  NSLog(@"come here")
    [self.opQueue addOperations:@[op1, op2] waitUntilFinished:YES];
    
    // 在主线程更新UI
    [[NSOperationQueue mainQueue] addOperation:op3];
    NSLog(@"come here");
}

@end
