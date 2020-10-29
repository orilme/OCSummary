//
//  CZCustomThreeView.m
//  B03.UIKit绘图方法
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZCustomThreeView.h"

@implementation CZCustomThreeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    //每调用一次，往上下文添加路径
//    CGContextMoveToPoint(ctx, 10, 10);
//    CGContextAddLineToPoint(ctx, 100, 100);
    
    //先把所有的路径定义好，然后一次性往上下文中添加
    CGMutablePathRef path = CGPathCreateMutable();
    
    // 设置圆的路径
    CGPathAddEllipseInRect(path, NULL, CGRectMake(10, 10, 100, 100));
    CGPathAddEllipseInRect(path, NULL, CGRectMake(20, 20, 80, 80));
    
    //添加弧的路径
    //CGPathAddArc(<#CGMutablePathRef path#>, <#const CGAffineTransform *m#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#bool clockwise#>)
    
    //添加 "线" 路径
    //CGPathAddLines(<#CGMutablePathRef path#>, <#const CGAffineTransform *m#>, <#const CGPoint *points#>, <#size_t count#>)
    
    // 把路径添加到上下文
    CGContextAddPath(ctx, path);
    
    // 渲染
    CGContextStrokePath(ctx);
    
    //开发过程中，ARC环境 C语言的资源是不会自动释放
    // 什么情况下创建的C语言资源，需要释放 以create，retain,copy创建的数据要释放
    //CGPathRelease(path);
    // 能用
    CFRelease(path);
    
    
}


@end
