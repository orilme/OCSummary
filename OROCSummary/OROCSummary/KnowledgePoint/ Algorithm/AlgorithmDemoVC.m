//
//  AlgorithmDemoVC.m
//  OROCSummary
//
//  Created by orilme on 2020/11/12.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "AlgorithmDemoVC.h"

@interface AlgorithmDemoVC ()

@end

@implementation AlgorithmDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 合并两个有序数组，同时去重
    NSArray *a = @[@1, @3, @5, @7, @9];
    NSArray *b = @[@2, @4, @5, @6, @8, @10];
    NSArray *c = [self mergeSortedArray:a and:b];
    NSLog(@"合并两个有序数组，同时去重---%@", c);
    
    // 递归实现一个数的N次方
    NSLog(@"平方--1--%ld", (long)[self myPow:2 and:3]);
    NSLog(@"平方--2--%ld", (long)[self myPow:2 and:4]);
    NSLog(@"平方--3--%ld", (long)[self myPow:3 and:3]);
}

// 合并两个有序数组，同时去重
- (NSArray *)mergeSortedArray:(NSArray *)a and:(NSArray *) b {
    
    NSInteger i = 0;
    NSInteger j = 0;
    NSMutableArray *ans = [[NSMutableArray alloc]init];
    
    // 合并数组
    while (i < a.count && j < b.count) {
        if ([a[i] intValue] > [b[j] intValue]) {
            [ans addObject:b[j]];
            j += 1;
        }else if ([a[i] intValue] == [b[j] intValue]) {
            [ans addObject:b[j]];
            j += 1;
            i += 1;
        }else {
            [ans addObject:a[i]];
            i += 1;
        }
    }
    
    // 数组a有未合并元素
    while (i < a.count) {
        [ans addObject:a[i]];
        i += 1;
    }
    
    // 数组b有未合并元素
    while (j < b.count) {
        [ans addObject:b[j]];
        j += 1;
    }
    
    return ans;
}

// 递归实现一个数的N次方
- (NSInteger )myPow:(NSInteger)base and:(NSInteger) n {
    if (n <= 0) {
        return 1;
    }
    return [self myPow:base and:n - 1] * base;
}

@end
