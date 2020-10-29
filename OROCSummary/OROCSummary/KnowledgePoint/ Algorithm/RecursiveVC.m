//
//  RecursiveVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/26.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "RecursiveVC.h"

@interface RecursiveVC ()

@end

@implementation RecursiveVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 斐波那契数列问题
    for (int i=1; i<=20; i++) {
        NSLog(@"斐波那契数列问题: 兔子第%d个月的总数为---%ld", i, [self recursion0:i]);
    }
    // 阶乘
    NSInteger result = [self recursion1: 3];
    NSLog(@"阶乘---%ld", result);
    // 数组求和
    NSArray *arr1 = @[@1, @2, @3, @4, @5];
    result = [self recursionWithArr:arr1 start:0 end:arr1.count-1];
    NSLog(@"数组求和---%ld", result);
    // 求数组元素的最大值
    result = [self recursionForMaxWithArr:arr1 start:0 end:arr1.count-1];
    NSLog(@"求数组元素的最大值---%ld", result);
}

// 斐波那契数列问题
- (NSInteger)recursion0:(NSInteger) n {
    if (n <= 1) return n;
    return [self recursion0:n-1] + [self recursion0:n-2];
}

// 阶乘
- (NSInteger)recursion1: (NSInteger)n {
    if (n == 0) return 1;
    return n*[self recursion1:(n-1)];//递归公式
}

// 数组求和
- (NSInteger)recursionWithArr:(NSArray *)arr start:(NSInteger)start end:(NSInteger)end {
    if (start == end) {
        return [arr[start] integerValue];
    }
    return [arr[start] integerValue] + [self recursionWithArr:arr start:(start+1) end:end]; //递归公式
}

// 求数组元素的最大值
#define max(a,b) (a>b?a:b)
- (NSInteger)recursionForMaxWithArr:(NSArray *)arr start:(NSInteger)start end:(NSInteger)end {
    if (start == end) {
        return [arr[start] integerValue];
    }else if (start+1 == end) {
        return max([arr[start] integerValue], [arr[end] integerValue]);
    }
    return max([arr[start] integerValue], [self recursionForMaxWithArr:arr start:(start+1) end:end]); //递归公式!!!
}


@end
