//
//  RunLoopVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/29.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "RunLoopVC.h"
#import "MyOperation.h"

#define kUrl @"https://image.baidu.com/search/detail?ct=503316480&z=0&tn=baiduimagedetail&ipn=d&cl=2&cm=1&sc=0&lm=-1&ie=gb18030&pn=3&rn=1&di=185680&ln=30&word=%B0%D9%B6%C8%CD%BC%C6%AC&os=1454830399,2300565235&cs=3190441126,995644236&objurl=http%3A%2F%2Fhbimg.b0.upaiyun.com%2Fb1cce6f996734bdbb9b3fb9ef7705deabc980e35493b-ysf8BZ_fw658&bdtype=0&simid=4177018013,777657142&pi=0&adpicid=0&timingneed=0&spn=0&is=0,0&fr=ala&ala=1&alatpl=adress&pos=1&oriquery=%E7%99%BE%E5%BA%A6%E5%9B%BE%E7%89%87&hs=2&xthttps=111111"
@interface RunLoopVC (){
    NSOperationQueue *_queue;
}
@property (nonatomic, strong) UIImageView *imageView;
@end

@implementation RunLoopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 150, 100, 100)];
    self.imageView.image = [UIImage imageNamed:@"aimage"];
    [self.view addSubview:self.imageView];
    
    [self test];
    /// 模拟运行循环
    [self simulateRunloop];
}

- (void)test {
    _queue = [[NSOperationQueue alloc]init];
    MyOperation *oper = [[MyOperation alloc]initWithUrl:kUrl target:self selector:@selector(onFinish:)];
    [_queue addOperation:oper];
}

- (void)onFinish:(NSData *)data {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.imageView.image = [UIImage imageWithData:data];
    });
}


// 模拟运行循环
// runloop会监听所有的事件
// 没有事件的时候，休眠状态。（省电）
// 当有事件发生，会立即相应事件
- (void)simulateRunloop {
    // runloop本质就是一个死循环，保证程序不会退出
    while (YES) {
        // 没有事件的时候，休眠状态。 等有事件才开始工作
        printf("请输入选项，0表示退出");
        
        int result = -1;
        //scanf()是阻塞函数，会阻塞当前的线程，如果用户输入，才会有反应
        scanf("%d", &result);
        
        if (result == 0) {
            NSLog(@"88， 相当于用户点击了退出");
            break;
        }else{
            NSLog(@"您选择了第%d项功能", result);
            click(result);
        }
    }
}

void click(int num) {
    printf("正在执行%d.....", num);
}

@end
