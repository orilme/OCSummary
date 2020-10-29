//
//  CategoryVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//  分类和类扩展

#import "CategoryVC.h"
#import "Person.h"
#import "Programmer.h"
#import "Programmer+Category.h" // 只要包含了类别的头文件,就可以调用类别中新加的方法,而且和调用原有类中的方法一模一样

@interface CategoryVC ()

@end

@implementation CategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    Person *p = [[Person alloc]init];
    p.personPublicName = @"Person的publicName";

    Programmer *programmer = [[Programmer alloc]init];
    
    // 通过runtime实现了setter/getter
    programmer.nameWithSetterGetter = @"有setter/getter";     //调用setter，成功
    NSLog(@"%@", programmer.nameWithSetterGetter);            //调用getter，成功
    
    //NSLog(@"%@",_nameWithSetterGetter); //这是调用_成员变量，错误提示为：（Use of undeclared identifier '_nameWithSetterGetter'）

    //普通声明，无setter/getter
    //programmer.nameWithoutSetterGetter = @"无setter/getter"; //调用setter，编译成功，运行报错为：（-[Programmer setNameWithSetterGetter:]: unrecognized selector sent to instance 0x7f9de358fd70'）
    //NSLog(@"%@",programmer.nameWithoutSetterGetter);   //调用getter，编译成功，运行报错为-[Programmer setNameWithSetterGetter:]: unrecognized selector sent to instance 0x7fe22be11ea0'
    
    // 分类的方法实现
    [programmer programCategoryMethod];
}

@end
