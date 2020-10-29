//
//  GCDSemaphoreVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/29.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "GCDSemaphoreVC.h"

@interface GCDSemaphoreVC ()

@property (nonatomic,assign) dispatch_queue_t myQueue;
@property (nonatomic,assign) NSInteger currentLoop;

@end

@implementation GCDSemaphoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNaviBarButton];
}

- (void)addNaviBarButton{
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(clickAction)];
    self.navigationItem.rightBarButtonItem = barButton;
}


- (void)clickAction{
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
        NSLog(@"执行完毕1");
    }];
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
        NSLog(@"执行完毕2");
    }];
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
        NSLog(@"执行完毕2");
    }];
    [self showSerialQueueAlertViewCompletion:^(BOOL finished) {
        NSLog(@"执行完毕2");
    }];
}


- (void)showSerialQueueAlertViewCompletion:(void(^)(BOOL finished))completion{
    self.currentLoop++;
    self.navigationItem.title = [NSString stringWithFormat:@"点击次数%ld",self.currentLoop];
    NSLog(@"开始执行  弹框 ：%@",[NSThread currentThread]);
    NSLog(@"0---------------------");
    //异步  这里会开启新的线程
    //为保证 在同一个线程 必须确保queue 是同一个同步队列
    dispatch_async(self.myQueue, ^{
        //创建一个初始为0的信号量
        NSLog(@"1---------------------1");
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        NSLog(@"1---------------------2");
        //创建第1个Alert UI的创建和显示，要在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"串行队列 主线程 执行 第一个 弹框 ：%@",[NSThread currentThread]);
            NSLog(@"1---------------------3");
            if ([self showAlertView]) {
                NSLog(@"1---------------------4");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"1111111111" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alertController animated:YES completion:^{}];
            }else{
                NSLog(@"1---------------------4");
                // 如果无需显示 直接发送信号量
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        //等待信号触发，注意，这里是在我们创建的队列中等待
        NSLog(@"2---------------------1");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        //NSLog(@"串行队列执行 第二个 弹框 ：%@",[NSThread currentThread]);
        NSLog(@"2---------------------2");
        //上面的等待到信号触发之后，再创建第二个Alert
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"串行队列 主线程 执行 第二个 弹框 ：%@",[NSThread currentThread]);
            NSLog(@"2---------------------3");
            if ([self showAlertView]) {
                NSLog(@"2--------------------4");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"2222222" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alertController animated:YES completion:^{}];
            }else{
                NSLog(@"2---------------------4");
                dispatch_semaphore_signal(sema);
            }
            
        });
       
        //同理，创建第N个Alert
        NSLog(@"3---------------------1");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"3---------------------2");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"3---------------------3");
            if ([self showAlertView]) {
                NSLog(@"3---------------------4");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"333333" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alertController animated:YES completion:^{}];
            }else{
                NSLog(@"3---------------------4");
                dispatch_semaphore_signal(sema);
            }
            
        });
        
        //同理，创建第N个Alert
        NSLog(@"4---------------------1");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"4---------------------2");
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"4---------------------3");
            if ([self showAlertView]) {
                NSLog(@"4---------------------4");
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"4444444" message:nil preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    dispatch_semaphore_signal(sema);
                }]];
                [self presentViewController:alertController animated:YES completion:^{}];
            }else{
                NSLog(@"4---------------------4");
                dispatch_semaphore_signal(sema);
            }
        });
        
        // 最终执行完毕 执行完毕回掉 同时也是为了衔接最后一个alert 和 下一轮的第一个alert 不然会出现同时弹出两个alert 的情况
        NSLog(@"5---------------------0");
        dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
        NSLog(@"5---------------------1");
        //NSLog(@"执行finished block 回掉");
        dispatch_async(dispatch_get_main_queue(), ^{
            dispatch_semaphore_signal(sema);
            if (completion) {
                NSLog(@"6---------------------");
                completion(YES);
            }
        });
    });
    NSLog(@"添加完所有提示框");
}


- (BOOL)showAlertView{
    int x = arc4random() % 10;
    NSLog(@"当前随机数 %d",x);
    if (x % 2 == 0) {
        return YES;
    }else{
        return NO;
    }
}

- (dispatch_queue_t)myQueue{
    static dispatch_queue_t queue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        queue = dispatch_queue_create("alertViewDemo", DISPATCH_QUEUE_SERIAL);
    });
    return queue;
}

@end


