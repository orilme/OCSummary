//
//  BallonView.m
//  A05.动画(气球下降)
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "BallonView.h"

@interface BallonView()

/**
 *  记录当前气球绘制的位置
 */
@property (nonatomic,assign) CGPoint position;

@end

@implementation BallonView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // 写一个定时器，重绘当前的View
        // 调用了setNeedsDisplay方法，内部会调用 drawRect方法进行重绘
        [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
        //[self setNeedsDisplay];
    }
    return self;
}

#warning 因为现在这个view的创建方法，不是在storyboard或者xib上，所以不会调用
- (void)awakeFromNib {

    // 写一个定时器，重绘当前的View
    // 调用了setNeedsDisplay方法，内部会调用 drawRect方法进行重绘
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    //[self setNeedsDisplay];
}

//drawRect会在View显示到屏幕的时候调用一次
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 实现气球下降
    
    // 每次刷新更改位置的y值（每次增加10）
#warning 结构体不能直接赋值
    CGPoint newPosition = self.position;
    newPosition.y += 10;
    
    //判断y到达底部，从新开始下降
    if (newPosition.y > rect.size.height) {
        newPosition.y = 0;
    }
    
    //重新赋值position
    self.position = newPosition;
    
    // 绘制图片
    UIImage *image = [UIImage imageNamed:@"sandyBalloon"];
    
    [image drawAtPoint:self.position];
    NSLog(@"=====");
}

@end
