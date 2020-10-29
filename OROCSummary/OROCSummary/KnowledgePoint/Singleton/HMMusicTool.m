//
//  HMMusicTool.m
//  03-单例模式-Singleton（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//  懒汉式

#import "HMMusicTool.h"

@implementation HMMusicTool
static id _instance;

+ (instancetype)sharedMusicTool {
    if (_instance == nil) { // 防止频繁加锁
        @synchronized(self) {
            if (_instance == nil) { // 防止创建多次
                _instance = [[self alloc] init];
            }
        }
    }
    return _instance;
}

/**
 *  alloc方法内部会调用这个方法
 */
+ (id)allocWithZone:(struct _NSZone *)zone {
    if (_instance == nil) { // 防止频繁加锁
        @synchronized(self) {
            if (_instance == nil) { // 防止创建多次
                _instance = [super allocWithZone:zone];
            }
        }
    }
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instance;
}

@end
