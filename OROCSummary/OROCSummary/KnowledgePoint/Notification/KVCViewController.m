//
//  KVCViewController.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/15.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "KVCViewController.h"
#import "KVOKVCPerson.h"
#import "KVOKVCBook.h"

@interface KVCViewController ()
@property (nonatomic, strong) KVOKVCPerson *p;
@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self testKvc];
}

- (void)testKvc {
    // key value coding : 间接通过字符串类型的key取出对应的属性值
    // KVC的价值
    // 1.可以访问私有成员变量的值
    // 2.可以间接修改私有成员变量的值（替换系统自带的导航栏、tabbar）
    
    KVOKVCPerson *p = [[KVOKVCPerson alloc] init];
    p.age = 20;
    NSLog(@"年龄---%d", p.age);
    int age = [[p valueForKey:@"age"] intValue];
    NSLog(@"年龄2---%d", age);

    float h1 = [[p valueForKey:@"height"] floatValue];
    float h2 = [[p valueForKeyPath:@"height"] floatValue];
    NSLog(@"height---%f, height2---%f", h1, h2);
    
    // keyPath包含了key的功能
    // key:只能访问当前对象的属性
    // keyPath:能利用.运算符一层一层往内部访问属性
    
    KVOKVCBook *b1 = [[KVOKVCBook alloc] init];
    b1.name = @"kuihua";
    b1.price = 100.6;
    
    KVOKVCBook *b2 = [[KVOKVCBook alloc] init];
    b2.name = @"pixie";
    b2.price = 5.6;
    
    KVOKVCBook *b3 = [[KVOKVCBook alloc] init];
    b3.name = @"jiuyin";
    b3.price = 50.6;
    
    p.books = @[b1, b2, b3];
    
    NSLog(@"计算数组的长度---%@", [p valueForKeyPath:@"books.@count"]); // 计算数组的长度
    
    NSArray *names = [p valueForKeyPath:@"books.name"];
    NSArray *names2 = [p.books valueForKeyPath:@"name"];
    NSLog(@"names---%@, names2---%@", names, names2);
    
    double sumPrice = [[p valueForKeyPath:@"books.@sum.price"] doubleValue];
    NSLog(@"sumPrice---%f", sumPrice);
}

@end
