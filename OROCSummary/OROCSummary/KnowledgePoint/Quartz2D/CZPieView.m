//
//  CZPieView.m
//  A01.画饼状
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CZPieView.h"

@implementation CZPieView


//@[@20,30,@20,30] 0.2,0.3,0.2,03
//3.在drawrect里面去画不同的扇形

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 需求：根据sections的数据，绘制多个扇形

    // 1.获取上下文(Layer Graphics Context)
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    
    // 2.根据sections的个数，计算扇形的起始和结束位置来画扇形
    NSInteger count = self.sections.count;

    // 如果没有数据，直接返回，不用画
    if(count == 0) return;
    
    
    // 圆心
    CGFloat centerX = rect.size.width * 0.5;
    CGFloat centerY = rect.size.height * 0.5;

    //半径就是x的中心点
    CGFloat radius = centerX;
    
    // 计算所有组的总数
    NSInteger sum = 0;
    for (NSInteger i = 0; i < count; i++) {
        sum += [self.sections[i] integerValue];
    }
    
    
    // 默认设置扇形的起始位置为 0
    CGFloat startAngle = 0;
    
    for (NSInteger i = 0; i < count; i++) {
        // 计算每组占用的比例
#warning 计算float的值，一要除以一个float类型值
        CGFloat scale = [self.sections[i] integerValue] / (sum * 1.0);
        
        // 指定颜色
        UIColor *sectionColor = self.sectionColors[i];
        [sectionColor set];
        
        // 计算结束的位置
#warning 计算结束的位置　＝　起始位置　＋　需要的画的弧度
        CGFloat endAngle = startAngle + scale * 2 * M_PI;
        
#warning 指定 "弧" 的中心点路径
        CGContextMoveToPoint(ctx, centerX, centerY);
        // 画弧
        CGContextAddArc(ctx, centerX, centerY, radius, startAngle, endAngle, 0);
        
        // 渲染
        CGContextFillPath(ctx);
        
        NSLog(@"scale:%f startAngle:%f endAngle:%f",scale, startAngle,endAngle);
        
        // 重新设置起始的位置，供一次循环使用
        startAngle = endAngle;
        
    }
  
    
}


@end
