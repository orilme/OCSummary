//
//  SpringView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SpringView.h"

@implementation SpringView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 振幅数值越小，震动越大
        self.attachment.damping = 0.1;
        self.attachment.frequency = 1.0f;
        
        // KVO健值监听（观察者）-> 观察者模式
        // 如果没有观察者，需要我们自己定时去查看状态，轮询，观察者是替代我们解决轮询的问题
        // 观察者模式的性能并不好！在实际开发中，要慎用！
        /**
         参数说明：
         
         1> 观察者，谁来负责“对象”的“键值”变化的观察
         2> 观察的键值
         3> 数值发生变化时，通知哪一个数值变化
         4> 通常是nil，要传可以传一个字符串
         */
        [self.box addObserver:self forKeyPath:@"center" options:NSKeyValueObservingOptionNew context:nil];
        
        // 增加碰撞检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.box]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        [self.animator addBehavior:collision];
        
        // 重力
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[self.box]];
        [self.animator addBehavior:gravity];
    }
    
    return self;
}

/**
 1> 观察的健值
 2> 观察的对象
 3> 数值的新旧内容，取决于定义观察者时的选项
 4> 定义观察者时设置的上下文
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
//    NSLog(@"%@", change);
    // 小方块的位置发生变化，重绘视图
    [self setNeedsDisplay];
}

- (void)dealloc
{
    // 释放掉观察者
    // 千万千万千万！！！用完观察者要释放！
    [self.box removeObserver:self forKeyPath:@"center"];
}

@end
