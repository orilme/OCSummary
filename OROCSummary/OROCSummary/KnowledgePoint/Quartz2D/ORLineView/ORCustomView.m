//
//  ORCustomView.m
//  OROCSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORCustomView.h"

@implementation ORCustomView

- (void)drawRect:(CGRect)rect {

    // 上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 保存一个当前上下文的绘图状态到一个栈里面
    // G代理Graphics[绘图]
    CGContextSaveGState(ctx);
    
    // 画红色，线宽为3的矩形
    [[UIColor redColor] set];
    CGContextSetLineWidth(ctx, 3);
    CGContextAddRect(ctx, CGRectMake(10, 10, 100, 100));
    CGContextStrokePath(ctx);// 渲染

    
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
