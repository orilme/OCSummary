//
//  ProtocolNurse.m
//  03-利用protocol实现代理设计模式
//
//  Created by MLJ on 14-5-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import "ProtocolNurse.h"
#import "ProtocolBaby.h"

@implementation ProtocolNurse

- (void)babyWantEat:(ProtocolBaby *)baby {
    baby.food += 30;
    NSLog(@"ProtocolNurse喂婴儿吃东西--现在的食量是%d", baby.food);
}

- (void)babyWantSleep:(ProtocolBaby *)baby {
    baby.sleep += 50;
    NSLog(@"ProtocolNurse哄婴儿睡觉--现在的睡意是%d", baby.sleep);
}

@end
