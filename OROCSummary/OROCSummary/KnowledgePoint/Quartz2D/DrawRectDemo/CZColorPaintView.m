//
//  CZColorPaintView.m
//  A05.涂鸦
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZColorPaintView.h"

@interface CZColorPaintView()
/**
 * 存储 "所有线" 的点，数组里面存 "一条线" 的数组
 *
 [
    [{10,10},{10,11},{10,10}] // 一条线
    [{10,10},{10,11},{10,10}]// 二条线
 ]
 */
@property(nonatomic,strong)NSMutableArray *pointsOfAllLine;

/**
 *所有线的颜色 每一条对应里面一个元素
 */
@property(nonatomic,strong)NSMutableArray *colorsOfAllLine;
@end

@implementation CZColorPaintView

-(NSMutableArray *)pointsOfAllLine{
    if (!_pointsOfAllLine) {
        _pointsOfAllLine = [NSMutableArray array];
    }
    
    return _pointsOfAllLine;
}

-(NSMutableArray *)colorsOfAllLine{
    if (!_colorsOfAllLine) {
        _colorsOfAllLine = [NSMutableArray array];
    }
    
    return _colorsOfAllLine;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 上下文
    CGContextRef layerContext = UIGraphicsGetCurrentContext();
    
    // 设置线宽
    CGContextSetLineWidth(layerContext, 5);
    // 设置首尾和连接点的样式
    CGContextSetLineCap(layerContext, kCGLineCapRound);
    CGContextSetLineJoin(layerContext, kCGLineJoinRound);
//    
    // 遍历多少条线
    NSInteger lineCount = self.pointsOfAllLine.count;
    for (NSInteger i = 0; i < lineCount; i++) {
        //取出当前 "一条线" 的数组
        NSArray *pointsOfALine = self.pointsOfAllLine[i];
        
        // 设置颜色
        UIColor *lineColor = self.colorsOfAllLine[i];
        [lineColor set];
        
        //画线
        // 取出 "线" 的 "点“ 的个数进行绘制
        NSInteger pointsCount = pointsOfALine.count;
        for (NSInteger j = 0; j < pointsCount; j++) {
            CGPoint point = [pointsOfALine[j] CGPointValue];
            if (j == 0) {
                CGContextMoveToPoint(layerContext, point.x, point.y);
            }else{
                CGContextAddLineToPoint(layerContext, point.x, point.y);
            }
        }
        
        //渲染
        CGContextStrokePath(layerContext);
    }

}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // 创建一个数组，存放当前 “一条线” 的点
    NSMutableArray *pointsOfALine = [NSMutableArray array];
    
    // 添加到pointsOfAllLine
    [self.pointsOfAllLine addObject:pointsOfALine];
    
    // 保存当前 "一条线" 的颜色
    if (!self.currentColor) {//为空，给个默认的黑色
        [self.colorsOfAllLine addObject:[UIColor blackColor]];
    }else{
        [self.colorsOfAllLine addObject:self.currentColor];
    }
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    2.监听触摸的事件，记录触摸的点
//    2.0 给一个属性 保存 所有线的点

    //获取当前的位置
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:touch.view];
    
//    2.1 获取当前 “一条线” 数组 添加 点
    NSMutableArray *pointsOfAline = [self.pointsOfAllLine lastObject];
    [pointsOfAline addObject:[NSValue valueWithCGPoint:touchPoint]];
    
    // 3.根据触摸的点进行绘制
    [self setNeedsDisplay];
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"多少条线 %ld",self.pointsOfAllLine.count);
}

-(void)back{
    
    // 1.将 数组里最后 "一条线" 删除
    [self.pointsOfAllLine removeLastObject];

    // 2.重绘
    [self setNeedsDisplay];
}

-(void)clear{
    
    // 1.将 数组里 "所有线" 删除
    [self.pointsOfAllLine removeAllObjects];
    
    // 2.重绘
    [self setNeedsDisplay];
}


@end
