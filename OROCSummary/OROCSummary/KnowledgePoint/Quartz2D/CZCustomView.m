//
//  CZCustomView.m
//  A02.图形上下文栈
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZCustomView.h"

@implementation CZCustomView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 需求： 先画一个矩形，颜色为红色，线宽为3
    //       再画一个矩形，颜色为黑色，线宽为默认
    
    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 保存一个当前上下文的绘图状态到一个栈里面
    // G代理Graphics[绘图]
    CGContextSaveGState(ctx);
    CGContextSaveGState(ctx);
    
    // 画红色，线宽为3的矩形
    [[UIColor redColor] set];
    CGContextSetLineWidth(ctx, 3);
    CGContextAddRect(ctx, CGRectMake(10, 10, 100, 100));
    CGContextStrokePath(ctx);// 渲染
    
    // 画黑色，线宽为默认的矩形
//    [[UIColor blackColor] set];
//    CGContextSetLineWidth(ctx, 1);
    
    // 恢复 当前上下文的状态
    CGContextRestoreGState(ctx);
    
    [[UIColor yellowColor] set];
    CGContextSetLineWidth(ctx, 3);
    CGContextAddRect(ctx, CGRectMake(10, 120, 50, 50));
    CGContextStrokePath(ctx);// 渲染
    
    //再恢复
#warning 恢复状态不能随便调用，保存了多少次绘图状态，就可以调用多少
    CGContextRestoreGState(ctx);
    
    
    
}


@end
