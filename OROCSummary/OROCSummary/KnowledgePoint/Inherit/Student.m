//
//  Student.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "Student.h"

@implementation Student

//子类中实现了一个和父类名字，参数，返回值类型完全相同的方法叫做重写父类的方法
- (void)saySelf {
    //_secretary;//因为是私有类型的，所以这里（子类）不能访问
    NSLog(@"我是学生,年龄:%d,体重:%d,有%d钱",_age,_weight,_money);
}

- (void)study {
    NSLog(@"学生在学习");
}


@end
