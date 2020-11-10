//
//  NSCacheVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NSCacheVC.h"

@interface NSCacheVC ()<NSCacheDelegate>
@property (nonatomic, strong) NSCache *myCache;
@end

@implementation NSCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
    self.myCache = [[NSCache alloc]init];
    self.myCache.delegate = self;
    
    for (int i = 0; i<10; i++) {
        [self.myCache setObject:[NSString stringWithFormat:@"%d", i] forKey:@(i) cost: 1];
    }
    
    for (int i = 0; i<10; i++) {
        NSLog(@"NSCache取出---%@", [self.myCache objectForKey:@(i)]);
    }
    
    /// 清除缓存
    [self.myCache removeAllObjects];
    /// 设置缓存限制
    self.myCache.totalCostLimit = 5;
    
    NSLog(@"设置缓存限制后=================");
    
    for (int i = 0; i<10; i++) {
        // 设置成本数为1
        [self.myCache setObject:[NSString stringWithFormat:@"%d", i] forKey:@(i) cost: 1];
    }
    
    for (int i = 0; i<10; i++) {
        NSLog(@"NSCache取出---%@", [self.myCache objectForKey:@(i)]);
    }
    
    /// 清除缓存
    [self.myCache removeAllObjects];
    NSLog(@"设置缓存限制后但未设置成本数cost=================");
    
    for (int i = 0; i<10; i++) {
        [self.myCache setObject:[NSString stringWithFormat:@"%d", i] forKey:@(i)];
    }
    
    for (int i = 0; i<10; i++) {
        NSLog(@"NSCache取出---%@", [self.myCache objectForKey:@(i)]);
    }
    
    /// 清除缓存
    [self.myCache removeAllObjects];
    
}

// 即将回收对象的时候进行调用，实现代理方法之前要遵守NSCacheDelegate协议。
- (void)cache:(NSCache *)cache willEvictObject:(id)obj{
    NSLog(@"NSCache回收---%@", obj);
}

@end
