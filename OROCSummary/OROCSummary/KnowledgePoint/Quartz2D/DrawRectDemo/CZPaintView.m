//
//  CZPaintView.m
//  A05.涂鸦
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZPaintView.h"

@interface CZPaintView()
@property(nonatomic,strong)NSMutableArray *pointsOfLine;//一条线的所有点

@end

@implementation CZPaintView


-(NSMutableArray *)pointsOfLine{
    if (!_pointsOfLine) {
        _pointsOfLine = [NSMutableArray array];
    }
    
    return _pointsOfLine;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 上下文
    CGContextRef layerContext = UIGraphicsGetCurrentContext();
    
    // 遍历点进行绘制
    NSInteger count = self.pointsOfLine.count;
    for (NSInteger i = 0; i < count; i ++) {
        //获取点
       CGPoint position =  [self.pointsOfLine[i] CGPointValue];
        
        if (i == 0) {
            CGContextMoveToPoint(layerContext, position.x, position.y);
        }else{
            CGContextAddLineToPoint(layerContext, position.x, position.y);
        }
    }
    
    //渲染
    CGContextStrokePath(layerContext);
    
    
}


 
 

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    2.监听触摸的事件，记录触摸的点
//    2.1 给个属性保存 所有触摸点
    //获取当前的位置
    UITouch *touch = [touches anyObject];
    
    CGPoint touchPoint = [touch locationInView:touch.view];
    [self.pointsOfLine addObject:[NSValue valueWithCGPoint:touchPoint]];
    
    // 3.根据触摸的点进行绘制
    [self setNeedsDisplay];
    
    
    
}

@end
