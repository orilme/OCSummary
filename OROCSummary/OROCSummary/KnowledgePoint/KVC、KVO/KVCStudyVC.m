//
//  KVCStudyVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/11.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "KVCStudyVC.h"
#import "KVCPerson.h"

@interface KVCStudyVC ()

@end

@implementation KVCStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    KVCPerson *p1 = [[KVCPerson alloc]init];
    //p1.nickName1 = @"狗剩";
    [p1 setValue:@"狗剩" forKey:@"nickName1"];
    NSLog(@"KVC---nickName1: %@", p1.nickName1);
    

    // 面试常问Key Value Coding(键值编码)
    // 点语法在编译就能确定给哪个属性赋值，编译器能帮我们查错，且程序执行效率高
    // KVC编译阶段不能确定给哪个属性赋值，运行时才能确定。编译器无法帮我们查错，且程序执行效率低，但使用灵活。KVC能给任何属性(私有的,公有..)赋值
    
    //用KVC给类型为C的基本类型的属性赋值时，属性值要用NSNumber类型
    [p1 setValue:@20 forKey:@"age"];
    NSLog(@"KVC---age: %d", p1.age);
    
    //用KVC取属性的值
    NSString *nickName = [p1 valueForKey:@"nickName1"];
    NSLog(@"KVC---nickName:%@", nickName);
    
    //如果某个属性为C的基本数据类型，valueForKey的返回值为会被转换为NSNumber类型
    NSNumber *age = [p1 valueForKey:@"age"];
    NSLog(@"KVC---age:%@", age);
    
    // KVC 将数据转化为model
//    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://10.0.8.8/sns/my/user_list.php?page=1&number=10"]];
//    NSArray *result = [KVCPerson snsesFromJsonData:data];
//    NSLog(@"KVC set model----%@", result);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
