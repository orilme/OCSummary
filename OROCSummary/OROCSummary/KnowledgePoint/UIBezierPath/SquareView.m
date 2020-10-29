//
//  SquareView.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/17.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "SquareView.h"

@implementation SquareView

// 矩形
- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor redColor];
    [color set]; //设置线条颜色

    UIBezierPath* path = [UIBezierPath bezierPathWithRect:CGRectMake(20, 20, 100, 80)];
    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound; //线条拐角
    path.lineJoinStyle = kCGLineJoinRound; //终点处理

    [path stroke];
}

@end
