//
//  CustomLayer.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/2.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CustomLayer.h"

@implementation CustomLayer

- (void)drawInContext:(CGContextRef)ctx {
    //上下文
    // 画一个半径为40的圆
    CGContextFillEllipseInRect(ctx, CGRectMake(60, 60, 80, 80));
}

@end
