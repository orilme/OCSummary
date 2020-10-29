//
//  SnapView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "SnapView.h"

@implementation SnapView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//
//    1.创建一个物理仿真器（顺便设置仿真范围）(已经在父类视图中初始化过了)
    // 把此前的行为清除掉
    [self.animator removeAllBehaviors];
    
    UITouch *touch = touches.anyObject;
    CGPoint location = [touch locationInView:self];
    
    // 2.创建相应的物理仿真行为（顺便添加物理仿真元素）
    UISnapBehavior *snap = [[UISnapBehavior alloc] initWithItem:self.box snapToPoint:location];
    
    // 振幅，一个整数,值越小震的越厉害
    snap.damping = 0;
    
    //3.将物理仿真行为添加到物理仿真器中 ->开始仿真
    [self.animator addBehavior:snap];
}

@end
