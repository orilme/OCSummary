//
//  PushView.m
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "PushView.h"

@interface PushView()
{
    UIPushBehavior  *_push;
    
    // 第一次按下的点
    CGPoint         _firstPoint;
    // 移动过程中的点
    CGPoint         _movePoint;
    
    UIImageView     *_imageView;
}

@end

@implementation PushView
/*
 皮筋效果，将方块弹射出去
 */
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        // 将方块下移
        self.box.center = CGPointMake(self.center.x, 200);
        // 旋转
        self.box.transform = CGAffineTransformMakeRotation(M_PI_4);
        
        UIView *blueView = [[UIView alloc] initWithFrame:CGRectMake(110, 300, 20, 20)];
        blueView.backgroundColor = [UIColor blueColor];
        [self addSubview:blueView];
        
        // 1. 定义手势
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
        
        [self addGestureRecognizer:pan];
        
        // 2. 实例化推行为，单此推动
        _push = [[UIPushBehavior alloc] initWithItems:@[self.box] mode:UIPushBehaviorModeInstantaneous];
        
        [self.animator addBehavior:_push];
        
        // 3. 碰撞检测的行为
        UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:@[self.box, blueView]];
        collision.translatesReferenceBoundsIntoBoundary = YES;
        
        [self.animator addBehavior:collision];
        
        // 4. 添加图像视图
        UIImage *image = [UIImage imageNamed:@"AttachmentPoint_Mask"];
        _imageView = [[UIImageView alloc] initWithImage:image];
        // 先隐藏
        _imageView.hidden = YES;
        [self addSubview:_imageView];
        
        // iOS7添加的对图像颜色处理的功能，过滤颜色的功能
        _imageView.tintColor = [UIColor blueColor];
        // 重新绘图
        _imageView.image = [_imageView.image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    }
    
    return self;
}

#pragma mark - 拖动手势
- (void)pan:(UIPanGestureRecognizer *)recognizer
{
    // 取出手势所在的点
    CGPoint location = [recognizer locationInView:self];
    
    // 拖动手势是一个持续性手势，需要判断状态
    if (UIGestureRecognizerStateBegan == recognizer.state) {
        // 按下手指，皮筋起点在这里，需要记录住手指的位置
        _firstPoint = location;
        
        // 添加一个图像视图标记手指按下
        _imageView.hidden = NO;
        _imageView.center = location;
        
    } else if (UIGestureRecognizerStateChanged == recognizer.state) {
        // 根据手指改变，绘制皮筋
        // 移动的点也需要记录
        _movePoint = location;
        
        [self setNeedsDisplay];
        
    } else if (UIGestureRecognizerStateEnded == recognizer.state) {
        // 放开手指，反方向弹射方块，此时给方块一个推力
        /*
         angle          推的方向
         magnitude      力量
         active         单次推需要设置为YES，才能生效
         */
        CGPoint endPoint = location;
        CGPoint offset = CGPointMake(_firstPoint.x - endPoint.x, _firstPoint.y - endPoint.y);
        
        CGFloat distance = sqrtf(offset.x * offset.x + offset.y * offset.y);
        CGFloat angle = atan2f(offset.y, offset.x);
        
        // 推力的角度，方向
        _push.angle = angle;
        // 力量的大小
        _push.magnitude = distance / 10.0;
        
        // 对于单次推动，一定要设置成YES，才能够发力
        _push.active = YES;
        
        // 清理线，以及手指的图像视图
        _imageView.hidden = YES;
        _firstPoint = CGPointZero;
        _movePoint = CGPointZero;
        
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    // 1. 上下文
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 2. 设置路径
    CGContextMoveToPoint(context, _firstPoint.x, _firstPoint.y);
    CGContextAddLineToPoint(context, _movePoint.x, _movePoint.y);
    
    // 3. 设置绘制属性
    CGContextSetLineWidth(context, 5.0);
    // 颜色
    [[UIColor darkGrayColor] set];
    // 虚线
    CGFloat lengths[] = {20.0, 5.0};
    CGContextSetLineDash(context, 0.0, lengths, 2);
    
    // 4. 绘图
    CGContextDrawPath(context, kCGPathStroke);
}

@end
