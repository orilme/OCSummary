//
//  Baby.m
//  03-利用protocol实现代理设计模式
//
//  Created by MLJ on 14-5-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ProtocolBaby.h"

@implementation ProtocolBaby

- (void)wantEat {
    NSLog(@"婴儿想吃东西");
    // 通知保姆喂婴儿
    [self.delegate babyWantEat:self];
}

- (void)wantSleep {
    NSLog(@"婴儿想睡觉");
    // 通知保姆哄婴儿睡觉
    [self.delegate babyWantSleep:self];
}

@end
