//
//  ORShapeView.m
//  ORIOSSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORShapeView.h"

@implementation ORShapeView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self drawSector];
}

#pragma mark 画三角形
- (void)drawTriangle {
    //获取上下文 上下文的输出目标就是self[view]
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 设置线颜色
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1);
    
    CGContextMoveToPoint(context, 10, 10);
    //设置另外三个点
    
    CGContextAddLineToPoint(context, 110, 10);
    CGContextAddLineToPoint(context, 110, 110);
    //CGContextAddLineToPoint(context, 10, 10);
    //关闭路径
    CGContextClosePath(context);
    
    // 渲染
    CGContextStrokePath(context);
}

#pragma mark 画矩形
- (void)drawRectangle {
    //绘一条

    //获取上下文 上下文的输出目标就是self[view]
    CGContextRef context = UIGraphicsGetCurrentContext();

    // 设置线颜色
    CGContextSetRGBStrokeColor(context, 1.0, 0.0, 0.0, 1);

    // 设置线宽
    CGContextSetLineWidth(context, 13);


    //画一个矩开

    // ＝＝＝＝＝＝＝第一方法＝＝＝＝＝＝＝＝＝＝＝＝
    ////设置一起点
    //CGContextMoveToPoint(context, 10, 10);
    ////设置另外三个点
    //
    //CGContextAddLineToPoint(context, 110, 10);
    //CGContextAddLineToPoint(context, 110, 110);
    //CGContextAddLineToPoint(context, 10, 110);
    //CGContextAddLineToPoint(context, 10, 10);


    // ＝＝＝＝＝＝＝第二方法＝＝＝＝＝＝＝＝＝＝＝＝
    CGContextAddRect(context, CGRectMake(10, 10, 100, 100));

    //画到view [渲染]

    //只是画一条，【空心】
    //CGContextStrokePath(context);

    //填充 【实心】
    CGContextFillPath(context);
}

#pragma mark 画扇形
- (void)drawSector {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //设置一个起点
    CGContextMoveToPoint(context, 100, 100);
    
    CGContextAddArc(context, 100, 100, 60, - M_PI_4, - 3 * M_PI_4, 1);
    
    CGContextClosePath(context);
    
    CGContextStrokePath(context);
    
}

#pragma mark 画弧
- (void)drawArc {
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    /**
     *x,y 圆心
     *radius 半径
     *startAngle 画弧的起始位置
     *endAngel 画弧的结束位置
     * clockwise 0 顺针 1 逆时针
     */
    CGContextAddArc(context, 100, 100, 60, 0, M_PI, 1);
    
    CGContextClosePath(context);
    
    //渲染
    CGContextStrokePath(context);
    //CGContextFillPath(context);
}


#pragma mark 画圆
- (void)drawCircle {
    //上下文
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    
    //画圈
    CGContextAddEllipseInRect(context, CGRectMake(10, 10, 100, 100));
    
    //渲染
    CGContextStrokePath(context);
}

//- (void)drawRect:(CGRect)rect {
//    // Drawing code
//
//    UIImage *image = [UIImage imageNamed:@"aimage"];
//
//    //[image drawAtPoint:CGPointZero];
//    //[image drawInRect:CGRectMake(10, 10, 80, 80)];
//    [image drawAsPatternInRect:CGRectMake(0, 0, 200, 200)];
//
//}
//
//-(void)drawText{
//    NSString *text = @"quartz2D入门";
//
//    //[text drawAtPoint:CGPointZero withAttributes:nil];
//
//    NSDictionary *att = @{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor redColor]};
//
//    [text drawInRect:CGRectMake(10, 10, 120, 44) withAttributes:att];
//
//}

- (void)drawTextImage:(CGRect)rect {
    
    CGFloat w = rect.size.width;
    CGFloat h = rect.size.height;
    
    
    //画图片
    UIImage *image = [UIImage imageNamed:@"aimage"];
    //[image drawAtPoint:CGPointZero];
    //[image drawInRect:CGRectMake(10, 10, 50, 50)];
    
    //平铺
    [image drawAsPatternInRect:CGRectMake(0, 0, 180, 180)];
    
    // Drawing code
    //画文字
    NSString *text = @"画文字和图片sdfasdfsdab这个方法不会换行adasdfasdfsdabadasdfa这个方法不会换行B04.画文字和图片sdfasdfsdab这个方法不会换行adasdfasdfsdabadasdfa这个方法Putranto表示，发现这些残骸的位置距离飞机最后被雷达捕获的位置大约10公里。报道称，这名官员展示了10张照片，照片中的物体类似飞机舱门、紧急滑道以及一个方形的箱子。";
    //这个方法不会换行
    //[text drawAtPoint:CGPointMake(10, 100) withAttributes:nil];
    
    // 设置字体的样式
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:13],NSForegroundColorAttributeName:[UIColor yellowColor]};
    
    //指定宽度和高度
    [text drawInRect:CGRectMake(0, 0, w, h * 0.5) withAttributes:attr];
}

@end
