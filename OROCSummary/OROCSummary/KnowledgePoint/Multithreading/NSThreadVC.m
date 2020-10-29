//
//  NSThreadVC.m
//  GCD
//
//  Created by orilme on 2018/7/28.
//  Copyright © 2018年 orilme. All rights reserved.
//

#import "NSThreadVC.h"
#import <pthread.h>

@interface NSThreadVC ()
@property (nonatomic, strong) NSThread *thread;

/**
 *  线程安全
 */
@property (nonatomic, strong) NSThread *thread1;
@property (nonatomic, strong) NSThread *thread2;
@property (nonatomic, strong) NSThread *thread3;
@property (nonatomic, assign) int leftTicketCount; // 剩余票数

@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation NSThreadVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // [self blockMainThread]; // 阻塞主线程
    // [self threadCBasicUse]; // thread c基本使用
    // [self threadBasicUse]; // NSThread 基本使用
    [self threadState]; // 线程状态
    // [self threadSafe]; // 线程安全
}

// 阻塞主线程
-(void)blockMainThread {
    for (int i = 0; i<10000; i++) {
        NSLog(@"---------%d", i);
    }
}

/*
 * thread c基本使用
 * 使用前引入 #import <pthread.h>
 */
- (void)threadCBasicUse {
    // 创建线程
    pthread_t myRestrict;
    pthread_create(&myRestrict, NULL, run, NULL);
}

void *run(void *data) {
    for (int i = 0; i<10000; i++) {
        NSLog(@"threadOne----%d-----%@", i, [NSThread currentThread]);
    }
    return NULL;
}

/*
 * NSThread 基本使用
 */
- (void)threadBasicUse {
    [self createThread1];
    [self createThread2];
    [self createThread3];
}
// 创建线程的方式1
- (void)createThread1 {
    // 创建线程
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(download:) object:@"http://a.png"];
    thread.name = @"下载线程";
    
    // 启动线程（调用self的download方法）
    [thread start];
}
// 创建线程的方式2
- (void)createThread2 {
    [NSThread detachNewThreadSelector:@selector(download:) toTarget:self withObject:@"http://b.jpg"];
}
// 创建线程的方式3
- (void)createThread3 {
    // 这2个不会创建线程，在当前线程中执行
    //    [self performSelector:@selector(download:) withObject:@"http://c.gif"];
    //    [self download:@"http://c.gif"];
    
    [self performSelectorInBackground:@selector(download:) withObject:@"http://c.gif"];
}
// 下载图片, 线程间的通信
- (void)download:(NSString *)url1 {
    NSLog(@"download---%@", [NSThread currentThread]);
    // 1.图片地址
    NSString *urlStr = url1;
    NSURL *url = [NSURL URLWithString:urlStr];
    
    // 2.根据地址下载图片的二进制数据(这句代码最耗时)
    NSLog(@"begin---");
    NSData *data = [NSData dataWithContentsOfURL:url];
    NSLog(@"end---");
    
    // 3.设置图片
    UIImage *image = [UIImage imageWithData:data];
    
    // 4.回到主线程，刷新UI界面(为了线程安全)
    [self performSelectorOnMainThread:@selector(downloadFinished:) withObject:image waitUntilDone:NO];
    //    [self performSelector:@selector(downloadFinished:) onThread:[NSThread mainThread] withObject:image waitUntilDone:YES];
    //    [self.imageView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
    
    NSLog(@"-----done----");
}

- (void)downloadFinished:(UIImage *)image {
    self.imageView.image = image;
    NSLog(@"downloadFinished---%@", [NSThread currentThread]);
}

/*
 * NSThread 线程状态
 */
- (void)threadState {
    //    self.thread = [[NSThread alloc] initWithTarget:self selector:@selector(download) object:nil];
    //    [self.thread start];
    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(download) object:nil];
    [thread start];
}
- (void)download {
    NSLog(@"begin---");
    
    // 睡眠5秒钟
    //    [NSThread sleepForTimeInterval:5];
    
    // 3秒后的时间
    //    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:3];
    //    [NSThread sleepUntilDate:date];
    
    for (int i = 0; i<100; i++) {
        NSLog(@"%d---", i);
        //        return;
        
        //        if (i == 49) {
        //            [NSThread exit];
        //        }
    }
    NSLog(@"-----end----");
}

/*
 * 线程安全
 */
-(void)threadSafe {
    self.leftTicketCount = 50;
    
    self.thread1 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread1.name = @"1号窗口";
    
    self.thread2 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread2.name = @"2号窗口";
    
    self.thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(saleTicket) object:nil];
    self.thread3.name = @"3号窗口";
    
    [self threadSafeStart];
}
- (void)threadSafeStart {
    [self.thread1 start];
    [self.thread2 start];
    [self.thread3 start];
}
// 卖票
- (void)saleTicket {
    while (1) {
        // ()小括号里面放的是锁对象
        @synchronized(self) { // 开始加锁
            int count = self.leftTicketCount;
            if (count > 0) {
                [NSThread sleepForTimeInterval:0.05];
                
                self.leftTicketCount = count - 1;
                
                NSLog(@"%@卖了一张票, 剩余%d张票", [NSThread currentThread].name, self.leftTicketCount);
            } else {
                return; // 退出循环
            }
        } // 解锁
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
