//
//  ShapeImageView.m
//  ORIOSSummary
//
//  Created by orilme on 2020/9/2.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "ShapeImageView.h"

@implementation ShapeImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup: frame];
    }
    return self;
}


- (void)setup:(CGRect)frame {
    // 第一个图片----
    UIBezierPath* path1 = [UIBezierPath bezierPath];
    path1.lineWidth = 5.0;
    path1.lineCapStyle = kCGLineCapRound; //线条拐角
    path1.lineJoinStyle = kCGLineJoinRound; //终点处理
    [path1 moveToPoint:CGPointMake(0, 0)];
    [path1 addLineToPoint:CGPointMake(Screen_Width * 0.4, 0)];
    [path1 addLineToPoint:CGPointMake(Screen_Width * 0.5, Screen_Width * 0.5)];
    [path1 addLineToPoint:CGPointMake(0, Screen_Width * 0.6)];
    [path1 closePath];
    [path1 stroke];

    CAShapeLayer *shapLayer1 = [CAShapeLayer layer];
    shapLayer1.path = path1.CGPath;
    
    UIImageView *imageView1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width * 0.5, Screen_Width * 0.6)];
    imageView1.image = [UIImage imageNamed:@"aimage"];
    imageView1.layer.mask = shapLayer1;
    [self addSubview:imageView1];
    
    // 第二个图片----
    UIBezierPath* path2 = [UIBezierPath bezierPath];
    path2.lineWidth = 5.0;
    path2.lineCapStyle = kCGLineCapRound;
    path2.lineJoinStyle = kCGLineJoinRound;
    [path2 moveToPoint:CGPointMake(0, 0)];
    [path2 addLineToPoint:CGPointMake(Screen_Width * 0.6, 0)];
    [path2 addLineToPoint:CGPointMake(Screen_Width * 0.6, Screen_Width * 0.4)];
    [path2 addLineToPoint:CGPointMake(Screen_Width * 0.1, Screen_Width * 0.5)];
    [path2 closePath];
    [path2 stroke];

    CAShapeLayer *shapLayer2 = [CAShapeLayer layer];
    shapLayer2.path = path2.CGPath;
    
    UIImageView *imageView2 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width * 0.4, 0, Screen_Width * 0.6, Screen_Width * 0.5)];
    imageView2.image = [UIImage imageNamed:@"aimage2"];
    imageView2.layer.mask = shapLayer2;
    [self addSubview:imageView2];
    
    // 第三个图片----
    UIBezierPath* path3 = [UIBezierPath bezierPath];
    path3.lineWidth = 5.0;
    path3.lineCapStyle = kCGLineCapRound;
    path3.lineJoinStyle = kCGLineJoinRound;
    [path3 moveToPoint:CGPointMake(0, Screen_Width * 0.1)];
    [path3 addLineToPoint:CGPointMake(Screen_Width * 0.5, 0)];
    [path3 addLineToPoint:CGPointMake(Screen_Width * 0.6, Screen_Width * 0.5)];
    [path3 addLineToPoint:CGPointMake(0, Screen_Width * 0.5)];
    [path3 closePath];
    [path3 stroke];

    CAShapeLayer *shapLayer3 = [CAShapeLayer layer];
    shapLayer3.path = path3.CGPath;
    
    UIImageView *imageView3 = [[UIImageView alloc]initWithFrame:CGRectMake(0, Screen_Width * 0.5, Screen_Width * 0.6, Screen_Width * 0.5)];
    imageView3.image = [UIImage imageNamed:@"aimage3"];
    imageView3.layer.mask = shapLayer3;
    [self addSubview:imageView3];
    
    // 第四个图片----
    UIBezierPath* path4 = [UIBezierPath bezierPath];
    path4.lineWidth = 5.0;
    path4.lineCapStyle = kCGLineCapRound;
    path4.lineJoinStyle = kCGLineJoinRound;
    [path4 moveToPoint:CGPointMake(0, Screen_Width * 0.1)];
    [path4 addLineToPoint:CGPointMake(Screen_Width * 0.5, 0)];
    [path4 addLineToPoint:CGPointMake(Screen_Width * 0.5, Screen_Width * 0.6)];
    [path4 addLineToPoint:CGPointMake(Screen_Width * 0.1, Screen_Width * 0.6)];
    [path4 closePath];
    [path4 stroke];

    CAShapeLayer *shapLayer4 = [CAShapeLayer layer];
    shapLayer4.path = path4.CGPath;
    
    UIImageView *imageView4 = [[UIImageView alloc]initWithFrame:CGRectMake(Screen_Width * 0.5, Screen_Width * 0.4, Screen_Width * 0.5, Screen_Width * 0.6)];
    imageView4.image = [UIImage imageNamed:@"aimage4"];
    imageView4.layer.mask = shapLayer4;
    [self addSubview:imageView4];
    
}

- (void)setImage:(UIImage *)image {
//    contentLayer.contents = (id)image.CGImage;
}

@end
