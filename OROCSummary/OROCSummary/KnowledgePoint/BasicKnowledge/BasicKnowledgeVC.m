//
//  BasicKnowledgeVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/1.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "BasicKnowledgeVC.h"

@interface BasicKnowledgeVC ()

@end

@implementation BasicKnowledgeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self dateType];
}

- (void)dateType {
    // Foundation: OC
    // Core Foundation: C语言
    // Foundation 和 Core Foundation 框架的数据类型可以互相转换的
    
    // CFArrayRef -- NSArray
    // CFDictionaryRef -- NSDictionary
    // CFNumberRef -- NSNumber
    
    NSString *str = @"123";
    CFStringRef str2 = (__bridge CFStringRef)str;
    NSString *str3 = (__bridge NSString *)str2;
    NSLog(@"%@---%@---%@", str, str2, str3);
    
    /**
     * 凡是函数名中带有 create\copy\new\retain 等字眼，都应该在不需要使用这个数据的时候进行release
     * GCD的数据类型在ARC环境下不需要再做release
     * Core Foundation 的数据类型在ARC\MRC 环境下都需要再做release
     */
    CFArrayRef array = CFArrayCreate(NULL, NULL, 10, NULL);
    CFRelease(array);
    
    CGPathRef path = CGPathCreateMutable();
    CGPathRelease(path);
}

@end
