//
//  CircleImageView.m
//  A04.裁剪圆角图片
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CircleImageView.h"

@implementation CircleImageView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 1.实现裁剪图片显圆形 并显示
    
    
    // 1.1.获取上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    // 1.2.指定圆的路径，并圆外面多余的剪切掉[CGContextClip]
#warning CGContextClip方法要记住
    // 定义图片的Rect
    CGRect imageRect = CGRectMake(0, 0, rect.size.width, rect.size.height);
    CGContextAddEllipseInRect(ctx, imageRect);
    CGContextClip(ctx);
    
    
    // 1.3.就把图片显示在UIView
    UIImage *image = [UIImage imageNamed:self.imageName];
    [image drawInRect:imageRect];
    
    // 2.添加一个圆的边框
    //线宽
    CGContextSetLineWidth(ctx, self.borderWidth);
    
    //设置边框的颜色
    [self.borderColor set];
    
    CGContextAddEllipseInRect(ctx, imageRect);
    CGContextStrokePath(ctx);
    
}


-(void)setImageName:(NSString *)imageName{
    _imageName = imageName;
    //重绘
    [self setNeedsDisplay];
}

@end
