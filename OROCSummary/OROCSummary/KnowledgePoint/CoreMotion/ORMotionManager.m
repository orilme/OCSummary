//
//  ORMotionManager.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/10.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "ORMotionManager.h"

static ORMotionManager *_instance;

@implementation ORMotionManager

+ (instancetype)shareMotionManager {
    if (_instance == nil) {
        _instance  = [[[self class] alloc] init];
    }
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}

- (id)copyWithZone:(NSZone *)zone {
    return self;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    return self;
}

@end
