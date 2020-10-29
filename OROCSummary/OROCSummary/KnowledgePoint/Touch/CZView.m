//
//  CZView.m
//  A04.触摸事件
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZView.h"

@implementation CZView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
    // 获取当前触摸点的UITouch对象
    UITouch *touch = [touches anyObject];
    NSLog(@"触摸点所在的view---%@", touch.view);
    NSLog(@"tapCount点击的次数 ---%ld",touch.tapCount);
    
    // 获取当前 触摸的位置
    CGPoint touchPosition = [touch locationInView:touch.view];
    NSLog(@" 获取的触摸点的位置---%@", NSStringFromCGPoint(touchPosition));
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    //NSLog(@"%s",__func__);
    // 获取当前触摸点的UITouch对象
    UITouch *touch = [touches anyObject];
    
    //获取 当前触摸的位置
    CGPoint current = [touch locationInView:touch.view];
    
    //获取 触摸前的位置
    CGPoint previous = [touch previousLocationInView:touch.view];

    NSLog(@"触摸前的点: %@ 当前触摸点:%@",NSStringFromCGPoint(previous),    NSStringFromCGPoint(current));
    
    // 改变位置
    CGPoint center = self.center;
    center.x += current.x - previous.x;
    center.y += current.y - previous.y;
    
    self.center = center;
    
}

@end
