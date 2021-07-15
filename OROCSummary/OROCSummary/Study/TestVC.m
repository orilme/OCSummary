//
//  TestVC.m
//  OROCSummary
//
//  Created by orilme on 2021/5/12.
//  Copyright © 2021 orilme. All rights reserved.
//

#import "TestVC.h"

@interface TestVC () {
    UITextField *totalPriceTextFiled;
}

@end

@implementation TestVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self asyncSerialQueue2];
//    [self class];
//    [self test1];
//    [self test2];
    //[self testzhizhen];
    //[self testFrame];
    
    totalPriceTextFiled = [[UITextField alloc] initWithFrame:CGRectMake(100, 100, 200, 80)];
    totalPriceTextFiled.returnKeyType = UIReturnKeyDone;
    totalPriceTextFiled.keyboardType = UIKeyboardTypeNumberPad;
    totalPriceTextFiled.textAlignment = NSTextAlignmentRight;
    [self.view addSubview:totalPriceTextFiled];
    
    UIButton *testBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 300, 100, 80)];
    testBtn.backgroundColor = [UIColor redColor];
    [self.view addSubview:testBtn];
    [testBtn addTarget:self action:@selector(testTextField) forControlEvents:UIControlEventTouchUpInside];
    
    NSString *test = nil;
    NSLog(@"test----%@---", test);
    
    [TestVC uniqueKey:^NSString *{
        return @"hhaha";
    }];
    
    [TestVC uniqueKey:^NSString *{
        return @"";
    }];
    
    [TestVC uniqueKey:^NSString *{
        return nil;
    }];
}

- (void)testTextField {
    [totalPriceTextFiled becomeFirstResponder];
}

+ (void)uniqueKey:(NSString *(^)(void))uniqueBlock {
    NSLog(@"000----%@---", uniqueBlock());
    NSLog(@"111----%@---", uniqueBlock);
    NSString *key = uniqueBlock ? uniqueBlock() : nil;
    NSString *key2 = uniqueBlock() ? uniqueBlock() : nil;
    NSLog(@"key----%@---", key);
    NSLog(@"key2----%@---", key2);
}


- (void)asyncSerialQueue1 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.dave.lan.serial", DISPATCH_QUEUE_SERIAL);
    NSLog(@"test1");
    dispatch_async(serialQueue, ^{
        sleep(2);
        NSLog(@"异步串行task1");
    });
    NSLog(@"test2");
    dispatch_async(serialQueue, ^{
        sleep(2);
        NSLog(@"异步串行task2");
    });
    NSLog(@"test3");
    dispatch_async(serialQueue, ^{
        sleep(2);
        NSLog(@"异步串行task3");
    });
    NSLog(@"test4");
}

- (void)asyncSerialQueue2 {
    dispatch_queue_t serialQueue = dispatch_queue_create("com.dave.lan.serial", DISPATCH_QUEUE_SERIAL);
    NSLog(@"test1");
    dispatch_async(serialQueue, ^{
        NSLog(@"异步串行task1");
    });
    NSLog(@"test2");
    dispatch_async(serialQueue, ^{
        NSLog(@"异步串行task2");
    });
    NSLog(@"test3");
    dispatch_sync(serialQueue, ^{
        NSLog(@"同步串行task3");
    });
    NSLog(@"test4");
}

- (void)test1 {
    dispatch_queue_t serialQueue = dispatch_queue_create("test", DISPATCH_QUEUE_SERIAL);
    dispatch_async(serialQueue, ^{
        dispatch_sync(serialQueue, ^{
            NSLog(@"1");
        });
    });
    NSLog(@"2");
    dispatch_async(serialQueue, ^{
        NSLog(@"3");
    });
    NSLog(@"4");
    dispatch_sync(serialQueue, ^{
        NSLog(@"5");
    });
    NSLog(@"6");
}

- (void)test2 {
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        [self performSelector:@selector(testFunc) withObject:nil afterDelay:0];
        NSLog(@"2");
    });
    NSLog(@"3");
}

- (void)testFunc {
    NSLog(@"4");
}

- (void)testzhizhen {
    int a[5] = {1, 2, 3, 4, 5};
    int *ptr = (int *)(&a + 1);
    printf("%d, %d \n", *(a + 1), *(ptr - 1), *(ptr + 1));
}

- (void)testFrame {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self.view addSubview:view];
    view.bounds = CGRectMake(10, 10, 150, 150);
    NSLog(@"1: %@", NSStringFromCGRect(view.frame));
    view.layer.anchorPoint = CGPointMake(0, 0);
    NSLog(@"2: %@", NSStringFromCGRect(view.frame));
    view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 2, 2);
    NSLog(@"3: %@", NSStringFromCGRect(view.frame));
}

//func removeRepeatNode(List : l) {
//    List p, q , r;
//    p = l -> next;
//    while (p) {
//        q = p;
//
//    }
//}

@end
