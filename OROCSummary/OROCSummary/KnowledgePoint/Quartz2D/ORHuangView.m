//
//  ORHuangView.m
//  ORIOSSummary
//
//  Created by orilme on 2019/9/8.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORHuangView.h"

#define topMargin 50 //头距离控制器view顶部的距离
#define middleH 150 //头部中间的高度
#define radius 80 //圆的半径
#define glassesH 30 //眼镜框的高度

@implementation ORHuangView

- (void)drawRect:(CGRect)rect {
    
    // 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    //画头部
    [self drawHead:rect context:context];
    
    CGFloat viewCenterX = rect.size.width * 0.5;
    CGFloat topCenterY = topMargin + radius;
    // 2.眼镜
    // 2.1镜框
    [[UIColor blackColor] set];
    CGFloat padding = 5;//间距
    CGContextAddRect(context, CGRectMake(viewCenterX - radius - padding, topCenterY, (radius + padding) * 2, glassesH));
    CGContextFillPath(context);
    
    // 画左边白色圆
    [[UIColor whiteColor] set];
    CGFloat whiteRadius = radius * 0.4;
    CGContextAddArc(context, viewCenterX - whiteRadius, topCenterY + glassesH * 0.5, whiteRadius, 0, 2*M_PI, 0);
    CGContextFillPath(context);
    
    //画右边白色圆
    CGContextAddArc(context, viewCenterX + whiteRadius, topCenterY + glassesH * 0.5, whiteRadius, 0, 2*M_PI, 0);
    CGContextFillPath(context);
    
    
    //画左边黑色空心圆
    [[UIColor blackColor] set];
    CGContextSetLineWidth(context, 10);
    CGContextAddArc(context, viewCenterX - whiteRadius, topCenterY + glassesH * 0.5, whiteRadius, 0, 2*M_PI, 0);
    CGContextStrokePath(context);
    
    
    // 2.2大眼睛
    CGContextAddArc(context, viewCenterX + whiteRadius, topCenterY + glassesH * 0.5, whiteRadius, 0, 2*M_PI, 0);
    CGContextStrokePath(context);
    
    
    // 2.3眼珠
    
    // 3.画头发
    
    // 4.画笑嘴巴
    
    
}

-(void)drawHead:(CGRect)rect context:(CGContextRef)context{
    CGFloat viewCenterX = rect.size.width * 0.5;
    CGFloat topCenterY = topMargin + radius;
    // Drawing code
    // 1.画头部
    // 1.1顶部
    //设置颜色
    [[UIColor yellowColor] set];
    CGContextAddArc(context, viewCenterX, topCenterY, radius, 0, M_PI, 1);
    CGContextFillPath(context);
    
    // 1.2中间
    
    CGContextAddRect(context, CGRectMake(viewCenterX - radius, topCenterY, radius * 2, middleH));
    CGContextFillPath(context);
    
    // 1.3尾部
    CGContextAddArc(context, viewCenterX, topCenterY + middleH, radius, 0, M_PI, 0);
    CGContextFillPath(context);
}

@end
