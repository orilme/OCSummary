//
//  Baby.h
//  03-利用protocol实现代理设计模式
//
//  Created by MLJ on 14-5-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//  婴儿

#import <Foundation/Foundation.h>

@class ProtocolBaby;

// 定义一份代理协议
@protocol ProtocolBabyDelegate <NSObject>
- (void)babyWantEat:(ProtocolBaby *)baby;
- (void)babyWantSleep:(ProtocolBaby *)baby;
@end

@interface ProtocolBaby : NSObject
/** 吃了多少东西 */
@property (nonatomic, assign) int food;
/** 睡意 */
@property (nonatomic, assign) int sleep;

/** 饿了 */
- (void)wantEat;
/** 困了 */
- (void)wantSleep;

/** 代理对象 */
@property (nonatomic, strong) id<ProtocolBabyDelegate> delegate;

@end
