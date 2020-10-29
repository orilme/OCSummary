//
//  GCDVC.m
//  GCD
//
//  Created by orilme on 2018/7/28.
//  Copyright © 2018年 orilme. All rights reserved.
//

#import "GCDVC.h"

/* GCD
 * 自动管理线程的生命周期（创建线程、调度任务、销毁任务等），程序员只需要告诉GCD如何执行什么任务，不需要编写线程管理的d代码
 */

@interface GCDVC ()
@property (nonatomic, strong)UIImageView *imageView;
@end

@implementation GCDVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 300, 500)];
    self.imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:self.imageView];
    
    [self gcdOne];
}

/**------华丽的分割线----GCD基本使用-----------------------------------------------------------------------**/
- (void)gcdOne {
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加 全局队列 中去 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    });
}

#pragma mark - 全局队列
/**
 全局队列，异步执行
 */
- (void)gcdDemo8 {
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

#pragma mark - 同步任务的应用场景
-(void)gcdDemo7 {
    // 并发队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 添加任务，要求必须先执行完登录才能够下载
    dispatch_sync(queue, ^{
        NSLog(@"用户登录 %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载小说A %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载小数B %@", [NSThread currentThread]);
    });
}

#pragma mark - 主队列
/**
 同步：不开线程，需要等待前一个任务执行完成，才会调度后面的任务！
 */
- (void)gcdDemo6 {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 同步执行
    dispatch_sync(queue, ^{
        NSLog(@"执行----");
        NSLog(@"%@", [NSThread currentThread]);
    });
}

/**
 主队列，异步执行
 */
- (void)gcdDemo5 {
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 异步执行
    for (int i = 0; i < 10; i++) {
        NSLog(@"调度前-----");
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    [NSThread sleepForTimeInterval:2.0];
    NSLog(@"完成-----");
}

#pragma mark - GCD演练
/**
 并发队列，同步执行
 */
- (void)gcdDemo4 {
    // 1. 队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 同步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

/**
 并发队列，异步执行
 */
- (void)gcdDemo3 {
    // 1. 队列
    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 异步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    
}

/**
 串行队列，异步执行
 */
- (void)gcdDemo2 {
    // 1. 队列
    dispatch_queue_t queue = dispatch_queue_create("test", NULL);
    
    // 2. 异步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

/**
 串行队列，同步执行(开发中非常少用)
 */
- (void)gcdDemo1 {
    
    // 1. 队列
    //    dispatch_queue_t queue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("test", NULL);
    NSLog(@"执行前----");
    
    // 执行任务
    for (int i = 0; i < 10; i++) {
        NSLog(@"调度----");
        // 在队列中"同步"执行任务，串行对列添加同步执行任务，会立即被执行
        dispatch_sync(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    NSLog(@"for 后面");
}
/**
 全局队列跟并发队列的区别
 1. 全局队列没有名称 并发队列有名称
 2. 全局队列，是供所有的应用程序共享。
 3. 在MRC开发，并发队列，创建完了，需要释放。 全局队列不需要我们管理
 */
#pragma CGD - 全局队列
- (void)gcdTest8 {
    // 获得全局队列
    /**
     参数：第一个参数，一般 写 0（可以适配 iOS 7 & 8）
     iOS 7
     DISPATCH_QUEUE_PRIORITY_HIGH 2  高优先级
     DISPATCH_QUEUE_PRIORITY_DEFAULT 0  默认优先级
     DISPATCH_QUEUE_PRIORITY_LOW (-2) 低优先级
     DISPATCH_QUEUE_PRIORITY_BACKGROUND INT16_MIN 后台优先级
     
     iOS 8
     QOS_CLASS_DEFAULT  0
     
     第二个参数：保留参数 0
     */
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 添加异步任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    
}

#pragma GCD- 同步任务的作用
- (void)gcdTest7 {
    // 并发队列
    dispatch_queue_t  queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
    
    /**
     例子：有一个小说网站
     - 必须登录，才能下载小说
     
     有三个任务：
     1. 用户登录
     2. 下载小说A
     3. 下载小说B
     */
    // 添加任务
    // 同步任务，需要马上执行。 不开新线程
    dispatch_sync(queue, ^{
        NSLog(@"用户登录 %@", [NSThread currentThread]);
    });
    //
    dispatch_async(queue, ^{
        NSLog(@"下载小说A %@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载小说B %@", [NSThread currentThread]);
    });
}


#pragma GCD-主队列
/**
 主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
 同步执行：要马上执行
 结果：死锁
 */
- (void)gcdTest6 {
    // 1. 获得主队列-> 程序启动，--> 至少有一个主线程-> 一开始就会创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"1----");
    
    // 2. 同步执行任务
    for (int i = 0; i < 10; i++) {
        NSLog(@"调度前---");
        // 同步：把任务放到主队列里，但需是马上执行
        dispatch_sync(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:2.0];
    }
    NSLog(@"完成----");
    
}

/**
 主队列：专门负责在主线程上调度任务，不会在子线程调度任务，在主队列不允许开新线程.
 异步执行： 会开新线程，在新线程执行
 结果: 不开线程， 只能在主线程上面，顺序执行!
 */
- (void)gcdTest5 {
    // 1. 获得主队列-> 程序启动，--> 至少有一个主线程-> 一开始就会创建主队列
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    NSLog(@"1----");
    
    // 2. 异步执行任务
    for (int i = 0; i < 10; i++) {
        NSLog(@"调度前---");
        // 异步：把任务放到主队列里，但是不需要马上执行
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
        NSLog(@"睡会");
        [NSThread sleepForTimeInterval:2.0];
    }
    NSLog(@"完成----");
}

#pragma GCDG演练
/**
 并发队列：可以同时执行多个任务
 同步任务：不会开辟新线程，是在当前线程执行
 结果：不开新线程，顺序一个一个执行。
 */
- (void)gcdTest4 {
    NSLog(@"----1");
    //1. 并行队列
    dispatch_queue_t queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 同步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_sync(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
    NSLog(@"----2");
}

/**
 并发队列：可以同时执行多个任务
 异步执行：会开新线程，在新线程执行
 结果：会开很多个线程，同时执行
 */
- (void)gcdTest3 {
    //1. 并行队列
    dispatch_queue_t queue = dispatch_queue_create("cz", DISPATCH_QUEUE_CONCURRENT);
    
    // 2. 异步执行任务
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}

/**
 串行队列：一个一个执行
 异步执行：肯定会开新线程，在新线程执行
 结果：只会开一个线程，而且所有任务都在这个新的线程里面执行
 */
- (void)gcdTest2 {
    // 1. 串行队列
    // 下面两种写法是一样的
    //    dispatch_queue_t queue = dispatch_queue_create("itcast", DISPATCH_QUEUE_SERIAL);
    dispatch_queue_t queue = dispatch_queue_create("itcast", NULL);
    
    
    // 2. 异步执行
    for (int i = 0; i < 10; i++) {
        dispatch_async(queue, ^{
            NSLog(@"%@ %d", [NSThread currentThread], i);
        });
    }
}


/**
 串行队列：顺序，一个一个执行
 同步任务：不会开辟新线程，是在当前线程执行
 结果：不开新线程，在当前线程顺序执行
 
 dispatch : 调度，GCD里面函数，都是以dispatch开头的
 */
- (void)gcdTest1 {
    // 1. 创建一个串行队列
    //参数：1. 队列标签 2. 队列的属性
    dispatch_queue_t queue = dispatch_queue_create("itcast", DISPATCH_QUEUE_SERIAL);
    
    NSLog(@"开始!!");
    
    // 2. 同步执行任务
    // 一般只要使用”同步“执行，串行队列对添加的同步任务，会立马执行
    dispatch_sync(queue, ^{
        NSLog(@"%@", [NSThread currentThread]);
    });
    
    NSLog(@"完成!!");
}


/**------华丽的分割线----GCD队列-----------------------------------------------------------------------**/

/**
 *  async -- 并发队列（最常用）
 *  会不会创建线程：会，一般同时开多条
 *  任务的执行方式：并发执行
 */
- (void)asyncGlobalQueue {
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加 全局队列 中去 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  async -- 串行队列（有时候用）
 *  会不会创建线程：会，一般只开1条线程
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 */
- (void)asyncSerialQueue {
    // 1.创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("cn.heima.queue", NULL);
    
    // 2.将任务添加到串行队列中 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    });
    
    // 3.非ARC，需要释放创建的队列
    //    dispatch_release(queue);
}

/**
 *  async -- 主队列(很常用)
 *  特殊：主队列中的异步不会开线程，会在主队列中异步执行
 */
- (void)asyncMainQueue {
    // 1.主队列(添加到主队列中的任务，都会自动放到主线程中去执行)
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加 任务 到主队列中 异步 执行
    dispatch_async(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  sync -- 主队列(不能用---会卡死)
 */
- (void)syncMainQueue {
    NSLog(@"syncMainQueue----begin--");
    
    // 1.主队列(添加到主队列中的任务，都会自动放到主线程中去执行)
    dispatch_queue_t queue = dispatch_get_main_queue();
    
    // 2.添加 任务 到主队列中 异步 执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    
    NSLog(@"syncMainQueue----end--");
}

/**-------------------------------------华丽的分割线-----------------------------------------------------**/

/**
 *  sync -- 并发队列
 *  会不会创建线程：不会
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 *  并发队列失去了并发的功能
 */
- (void)syncGlobalQueue {
    // 获得全局的并发队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    // 将 任务 添加到 全局并发队列 中 同步 执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    });
}

/**
 *  sync -- 串行队列
 *  会不会创建线程：不会
 *  任务的执行方式：串行执行（一个任务执行完毕后再执行下一个任务）
 */
- (void)syncSerialQueue {
    // 创建一个串行队列
    dispatch_queue_t queue = dispatch_queue_create("cn.heima.queue", NULL);
    
    // 将 任务 添加到 串行队列 中 同步 执行
    dispatch_sync(queue, ^{
        NSLog(@"下载图片1---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片2---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片3---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片4---%@", [NSThread currentThread]);
    });
    dispatch_sync(queue, ^{
        NSLog(@"下载图片5---%@", [NSThread currentThread]);
    });
}

/**------华丽的分割线----GCD其他使用-----------------------------------------------------------------------**/

#pragma mark - 一次性执行，dispatch_once是线程安全的
- (void)once {
    static dispatch_once_t onceToken;
    NSLog(@"%ld", onceToken);
    
    dispatch_once(&onceToken, ^{
        NSLog(@"%----ld", onceToken);
        
        NSLog(@"真的执行一次么？");
    });
    NSLog(@"完成");
}


#pragma mark - 调度组(分组)
- (void)group {
    /**
     应用场景：
     开发的时候，有的时候出现多个网络请求都完成以后（每一个网络请求的事件长短不一定），再统一通知用户
     
     
     比如： 下载小说：三国演义， 红楼梦， 金X梅
     */
    // 实例化一个调度组
    dispatch_group_t group = dispatch_group_create();
    
    // 队列
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    // 任务添加到队列queue
    dispatch_group_async(group, queue, ^{
        NSLog(@"下载小说A---%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"下载小说B---%@", [NSThread currentThread]);
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"下载小说X---%@", [NSThread currentThread]);
    });
    
    // 获得所有调度组里面的异步任务完成的通知
    //    dispatch_group_notify(group, queue, ^{
    //        NSLog(@"下载完成，请观看%@", [NSThread currentThread]); // 异步的
    //    });
    
    //注意点： 在调度组完成通知里，可以跨队列通信
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 更新UI，在主线程
        NSLog(@"下载完成，请观看%@", [NSThread currentThread]); // 异步的
    });
}

#pragma mark - dispatch_group_enter、dispatch_group_leve
- (void)gcdGroupEnterAndLeave {
    dispatch_group_t group = dispatch_group_create();
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 请求1
//        [网络请求:{
//            成功：dispatch_group_leave(group);
//            失败：dispatch_group_leave(group);
//        }];
    });
    dispatch_group_enter;
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 请求2
//        [网络请求:{
//            成功：dispatch_group_leave;
//            失败：dispatch_group_leave;
//        }];
    });
    dispatch_group_enter(group);
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 请求3
//        [网络请求:{
//            成功：dispatch_group_leave(group);
//            失败：dispatch_group_leave(group);
//        }];
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 界面刷新
        NSLog(@"任务均完成，刷新界面");
    });
}

#pragma mark - 延时操作
- (void)delay {
    /**
     参数:
     now 0
     NSEC_PER_SEC: 很大的数字
     
     */
    dispatch_time_t when = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC));
    
    // 参数： when : 表示从现在开始，经过多少纳秒以后
    // queue ：  在哪一个队列里面执行后面的任务
    //    dispatch_after(when, dispatch_get_main_queue(), ^{
    //        NSLog(@"点我了-- %@", [NSThread currentThread]);
    //    });
    //
    dispatch_after(when, dispatch_get_global_queue(0, 0), ^{
        NSLog(@"点我了--- %@", [NSThread currentThread]);
    });
}
- (void)delay1 {
    // 延迟执行不要用sleep，坏处：卡住当前线程
    [NSThread sleepForTimeInterval:3];
    NSLog(@"下载图片-----");
}
- (void)delay2 {
    // 一旦定制好延迟任务后，不会卡主当前线程
    [self performSelector:@selector(downloadImageGCD) withObject:@"http://6666.jpg" afterDelay:3];
}


/**------华丽的分割线----GCD线程间的通信----------------------------------------------------------------------**/
- (void)downloadImageGCD {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSLog(@"%@", [NSThread currentThread]);
        // 耗时操作: 放在全局队列，异步执行
        // 1. url, 确定一个网络上的资源路径
        NSURL *url = [NSURL URLWithString:@"http://fe.topit.me/e/d1/12/1170068721aa112d1el.jpg"];
        
        // 2. 通过url可以下载对应的网络资源, 网络资源传输的都是二进制
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 3. 二进制转成图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 4. 更新UI，在主线程-》 直接把任务添加到主队列，就会在主队列执行
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
            NSLog(@"-----%@", [NSThread currentThread]);
            
        });
    });
}


#pragma mark- 下载图片
- (void)downloadImage {
    // 子线程里面的runloop默认不开启， 也就意味不会自动创建自动释放池, 子线程里面autorelease的对象 就会没有池子可放。 也就意味后面没办法进行释放。 造成内存泄露
    // 所以需要手动创建
    @autoreleasepool {
        
        NSLog(@"%@", [NSThread currentThread]);
        
        // 1. url, 确定一个网络上的资源路径
        NSURL *url = [NSURL URLWithString:@"http://h.hiphotos.baidu.com/image/pic/item/5366d0160924ab1828b7c95336fae6cd7b890b34.jpg"];
        
        // 2. 通过url可以下载对应的网络资源, 网络资源传输的都是二进制
        NSData *data = [NSData dataWithContentsOfURL:url];
        
        // 3. 二进制转成图片
        UIImage *image = [UIImage imageWithData:data];
        
        // 4. 把图片显示到iconView
        //    self.iconView.image = image;
        // 在这里需要把数据传到主线程，在主线程更新UI
        //    1.
        [self performSelectorOnMainThread:@selector(downloadFinish:) withObject:image waitUntilDone:NO];
        //2. [self performSelector:@selector(downloadFinish:) onThread:[NSThread mainThread] withObject:image waitUntilDone:NO];
        //3.
        //    [self.iconView performSelectorOnMainThread:@selector(setImage:) withObject:image waitUntilDone:YES];
        
        // waitUntilDone：表示是否等待@selector(setImage:) 方法执行完成
        // 如果是YES，就等待setImage在其他线程执行结束，再往下执行
        NSLog(@"完成！！");
    }
}

- (void)downloadFinish:(UIImage *)image {
    NSLog(@"%s---%@", __func__, [NSThread currentThread]);
    self.imageView.image = image;
}


@end
