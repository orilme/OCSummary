//
//  BlockVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/6.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "BlockVC.h"
#import "BlockPerson.h"
#import "BlockTwoVC.h"

@interface BlockVC ()

@end

@implementation BlockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //什么是block 就一个代码块，是iOS中一种比较特殊的数据类型
    
    /**应用
     * 1. 动画
     * 2. 多线程
     * 3. 集合遍历
     * 4. 网络请求回调
     */
    /**作用
    * 1. 用来保存某一段代码，可以在d恰当的时间再取出来调用
    * 2. 功能有点类似于函数和方法
    */
    
    //block和函数有什么区别
    // 1.函数只能在方法外面定义
    // 2.block可以定义在方法内 也可定义在方法外面
    // 3.block和函数共同点：都有返回值和参数
    
    // 1.如果没有对block进行copy操作，block就存储于栈空间
    // 2.如果对block进行copy操作，block就存储于堆空间
        
    // 3.如果block存储于栈空间，不会对block内部所用到的对象产生强引用
    // 4.如果block存储于堆空间，就会对block内部所用到的对象产生强引用
    
    /**
    1.默认情况下, block的内存是在栈中
       * 它不会对所引用的对象进行任何操作
    
    2.如果对block做一次copy操作, block的内存就会在堆中
       * 它会对所引用的对象做一次retain操作
       * 非ARC : 如果所引用的对象用了__block修饰, 就不会做retain操作
       * ARC : 如果所引用的对象用了__unsafe_unretained\__weak修饰, 就不会做retain操作
    */
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, Screen_Width - 40, 80)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"跳转" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(testBlockValue) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    [self block1];
    [self blockChainingMethod];
}

- (void)testBlockValue {
    BlockTwoVC *twoVC = [[BlockTwoVC alloc]init];
    // 执行用于反向传值的block
    twoVC.certainBlock = ^(NSString *userName, NSString *password) {
        NSLog(@"userName: %@, password:%@", userName, password);
    };
    [self.navigationController pushViewController:twoVC animated:true];
}

- (void)block1 {
    __block int age = 10;
    void (^block)() = ^{ // 值捕获
        NSLog(@"age=%d", age);
    };
    age = 20;
    block();
}

// block链式调用
- (void)blockChainingMethod {
    BlockPerson *p = [[BlockPerson alloc] init];
    p.study(@"xx宝典").run().study(@"xx剪发");
}

// block的定义
- (void)defineBlock {
    //无返回值，无参数的block
    void (^testBlock)() = ^{
        NSLog(@"无返回值，无参数的block");
    };
    testBlock();
    
    //无返回值，有参数的block
    void (^test2Block)(int) = ^(int a){
        NSLog(@"你传入的是%d",a);
    };
    test2Block(2);
    
    //有返回值，有参数的block
    int (^sumBlock)(int,int) = ^(int a,int b){
        return a + b;
    };
    int result = sumBlock(2,3);
    NSLog(@"通过block的计算，结果是:%d",result);
    
    //有返回值，无参数
    //block可重定义 typedef
    typedef void (^MTestBlock)();
    // 给无返回值，无参数的block进行一自定义
    MTestBlock mTestBlock = ^(){
        NSLog(@"重定义的block");
    };
    mTestBlock();
    
    //定义一个特殊操作的block
    typedef void (^OperationBlock)();
    OperationBlock operationBlock = ^(){
        NSLog(@"正在检查的版本更新");
    };
    operationBlock();
    
    // 定义一个叫做MyBlock的类型
    // 利用MyBlock类型可以定义block变量
    // 利用MyBlock类型定义出来的变量， 存储的代码必须返回int， 必须接受2个int类型的参数
    typedef int (^MyBlock)(int, int);
    MyBlock minusBlock = ^(int num1, int num2) {
        return num1 - num2;
    };
    MyBlock multiBlock = ^(int num1, int num2) {
        return num1 * num2;
    };
    multiBlock(10, 1);
}

typedef void (^WorkBlock)();

void goToWork(WorkBlock workBlock)
{
    NSLog(@"起床");
    NSLog(@"刷牙");
    NSLog(@"穿衣服穿鞋");
    
    NSLog(@"出门");
    NSLog(@"搭公交");
    
    NSLog(@"抵达公司");
    
    // 实事
    // 调用block之前一定要做判断
    if (workBlock != nil) {
        workBlock();
    }
    // 实事
    
    NSLog(@"叮咚叮咚 下班了");
    NSLog(@"搭公交");
    NSLog(@"回家");
    NSLog(@"睡觉");
}

/**
 模拟星期一上班的具体情况
 */
void goToWorkInDay1()
{
    goToWork(^{
        NSLog(@"了解项目的需求");
    });
}

void goToWorkInDay2()
{
    // 实事
    goToWork(^{
        NSLog(@"熟悉公司以前的代码");
    });
    // 实事
}

void goToWorkInDay3()
{
    // 实事
    goToWork(^{
        NSLog(@"开始编写代码");
    });
    // 实事
}


@end
