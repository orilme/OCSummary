//
//  ORLineView.m
//  ORIOSSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORLineView.h"

@implementation ORLineView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 设置颜色
    CGContextSetRGBStrokeColor(ctx, 1, 0, 0, 1);
    
    // 设置线宽
    CGContextSetLineWidth(ctx, 35);
    
    // 设置线的首尾样式
    CGContextSetLineCap(ctx, kCGLineCapRound);
    
    //设置线的连接样式
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    
    CGContextMoveToPoint(ctx, 30, 30);
    CGContextAddLineToPoint(ctx, 130, 30);
    CGContextAddLineToPoint(ctx, 130, 130);
    //    CGContextAddLineToPoint(ctx, 10, 110);
    
    
    //渲染
    CGContextStrokePath(ctx);
}

@end
