//
//  HMDataTool.m
//  03-单例模式-Singleton（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMDataTool.h"

@implementation HMDataTool
// 用来保存唯一的单例对象
static id _instace;

+ (instancetype)sharedDataTool {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [[self alloc] init];
    });
    return _instace;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instace = [super allocWithZone:zone];
    });
    return _instace;
}

- (id)copyWithZone:(NSZone *)zone {
    return _instace;
}

@end
