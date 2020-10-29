//
//  CircleView.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/2.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CircleView.h"

@implementation CircleView

// 圆形
- (void)drawRect:(CGRect)rect {
    UIColor *color = [UIColor redColor];
    [color set];

    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(100, 100) radius:90 startAngle:0 endAngle:300 clockwise:YES];

    path.lineWidth = 5.0;
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineJoinRound;
    [path stroke];
}

@end
