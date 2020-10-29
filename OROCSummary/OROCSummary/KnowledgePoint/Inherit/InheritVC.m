//
//  InheritVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "InheritVC.h"
#import "People.h"
#import "Student.h"

@interface InheritVC ()

@end

@implementation InheritVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //OC中每个类只能有一个直接父类（单继承）
        
    //子类自动拥有父类的所有成员变量和方法，但是不是父类所有的”成员变量“子类都能访问，但是父类所有的”方法“子类都能访问
    Student *s1 = [[Student alloc]init];
    s1->_weight;
    s1->_age;//_age和_weight在类的外部可以访问，因为是公有的
    //s1->_money//_money是受保护的，在类的外部不能访问
    //s1->secretary/_secretary是私有的，在类的外部不能访问
    
    //父类指针指向子类对象
//通过父类指针调用方法：一个方法能不能调用要看该方法在父类中是否声明过，如果声明过就能调用，否则就不能调用，具体调用哪个方法：从指针实际指向的对象的所属的类方法中找，如果找到就调用；如果找不到就去父类中找。。知道NSObject中也找不到，程序就crash崩溃
    People *p1 = s1;
    [p1 saySelf];
    //[p1 study];
}

@end
