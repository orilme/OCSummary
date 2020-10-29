//
//  CollisionView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "CollisionView.h"

@interface CollisionView() <UICollisionBehaviorDelegate>

@end

@implementation CollisionView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //红色的UIView,来模拟障碍物
        UIView *redView = [[UIView alloc] initWithFrame:CGRectMake(0, 300, 150, 20)];
        redView.backgroundColor = [UIColor redColor];
        [self addSubview:redView];
        //蓝色的UIView,来模拟掉落重物
        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(110, 120, 100, 100)];
        blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:blueView];
        
        // 增加碰撞检测
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[blueView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;//以参照视图的边界为边界
        
        // Boundary是即参与碰撞，又不会发生位移的静态物体的边界
        CGFloat toX = redView.frame.size.width;
        CGFloat toY = redView.frame.origin.y + redView.frame.size.height;
        //红色障碍物参与碰撞但不会发生位移
        [collision addBoundaryWithIdentifier:@"lalala" fromPoint:redView.frame.origin toPoint:CGPointMake(toX, toY)];
        
        // 设置碰撞行为的代理
        collision.collisionDelegate = self;
        
        [self.animator addBehavior:collision];
        
        // 重力
        UIGravityBehavior *gravity = [[UIGravityBehavior alloc] initWithItems:@[blueView]];
        [self.animator addBehavior:gravity];
        
        // 物体属性行为
        UIDynamicItemBehavior *item = [[UIDynamicItemBehavior alloc] initWithItems:@[blueView]];
        
        // 弹力系数，0~1，0是最不弹，1是最弹,不可超过1(违反物理规律了)
        item.elasticity = 0.6;
        
        [self.animator addBehavior:item];
        
//         此方法可以用于碰撞实际情况的跟踪
        collision.action = ^ {
            NSLog(@"%@", NSStringFromCGRect(self.box.frame));
        };
    }
    
    return self;
}

#pragma mark - 碰撞时系统自动调用的的代理方法
- (void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    NSLog(@"%@", identifier);
    NSString *ID = [NSString stringWithFormat:@"%@", identifier];
    UIView *blue = (UIView *)item;//
    
    // 与板子相撞，变换颜色
    if ([ID isEqualToString:@"lalala"]) {//@""
        blue.backgroundColor = [UIColor greenColor];
        
        // 结束后恢复颜色
        [UIView animateWithDuration:0.3f animations:^{
            blue.backgroundColor = [UIColor blueColor];
        }];
    }
}

@end
