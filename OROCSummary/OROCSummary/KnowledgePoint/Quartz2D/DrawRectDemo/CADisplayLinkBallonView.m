//
//  CADisplayLinkBallonView.m
//  A05.动画(气球下降)
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "CADisplayLinkBallonView.h"

@interface CADisplayLinkBallonView()

/**
 *  记录当前气球绘制的位置
 */
@property (nonatomic,assign) CGPoint position;
/**
 *  所有气球的位置
 */
@property (nonatomic,strong)NSMutableArray  *locations;

/**
 *  所有的气球
 */
@property (nonatomic,strong)NSMutableArray  *ballons;

@property (nonatomic,strong)CADisplayLink  *link;//定时器


@end

@implementation CADisplayLinkBallonView

#warning 调用  init 方法 和initWithFrame方法，最终都会调用initWithFrame
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        NSLog(@"%s",__func__);
        [self addAnimaion];
    }
    
    return self;
}

#warning 因为现在这个view的创建方法，不是在storyboard或者xib上，所以不会调用
-(void)awakeFromNib{
    [self addAnimaion];
}

-(NSMutableArray *)locations{
    if (!_locations) {
        _locations = [NSMutableArray array];
    }
    
    return _locations;
}

//通过懒加载的方式，初始化图片和位置
-(NSMutableArray *)ballons {
    if (!_ballons) {
        _ballons = [NSMutableArray array];
        //添加6个图片
        
        NSInteger count = 6;
        UIImage *ballonImage = [UIImage imageNamed:@"sandyBalloon"];
        for (NSInteger i = 0; i < count; i++) {
            
            // 初始化每一个气球的位置
            CGFloat leftMargin = 40;
            CGFloat ballonDelta = 50;//气球的间距
            CGPoint location = CGPointMake(leftMargin + ballonDelta * i, self.frame.size.height);
            
            // 2.一个数组来存储当前多个气球的位置
            [self.locations addObject:[NSValue valueWithCGPoint:location]];
            
            
#warning 当前没有上下文，所以绘制不成功,一定要在drawRect里才有这个上下文
            //[ballonImage drawAtPoint:location];
            
            // 添加image 到数组
            [_ballons addObject:ballonImage];
        }
        
    }
    
    return _ballons;
}

//drawRect会在View显示到屏幕的时候调用一次

- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    // 实现气球上升
    
    // 绘制多个图片到UIView
    NSInteger ballonCount = self.ballons.count;
    for (NSInteger i = 0; i < ballonCount; i++) {
        // 获取 "对应位置气球"
        UIImage *ballon = self.ballons[i];
        
        // 获取 "对应气球" 位置
        CGPoint location = [self.locations[i] CGPointValue];
        
        // 更改每一个气球位置
        // 遍历气球，获取当前气球的位置，y方向上减 ”10“ 距离
        location.y -= arc4random_uniform(10) * 0.5;
        
        // 如果y到顶部，从底部重新往上升
        if(location.y + [ballon size].height < 0){
            location.y = rect.size.height;
        }
        
        // 更新 "位置数组" 里的值
        [self.locations replaceObjectAtIndex:i withObject:[NSValue valueWithCGPoint:location]];
        
        // 渲染
        [ballon drawAtPoint:location];
        

    }
    
    
    NSLog(@"%s",__func__);
    
  
    
}





-(void)addAnimaion{
    //initWithFrame 和 init 调用两次，代表在主运行循环里添加两个定时器
    
    // 写一个定时器，重绘当前的View
    // 调用了setNeedsDisplay方法，内部会调用 drawRect方法进行重绘
    //[NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
    //[self setNeedsDisplay];
    
    // CADisplayLink 定时器 一秒执行60次
    CADisplayLink *link = [CADisplayLink displayLinkWithTarget:self selector:@selector(setNeedsDisplay)];
    
    // 要执行定时器，添加到主运行循环
    [link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    
    self.link = link;
    
    

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //继承了一个UIResponder对象，就有这个方法
    NSLog(@"%s",__func__);
    //停止 定时器
    //self.link.paused = YES;
    
    [self.link invalidate];
    self.link = nil;
    // 移除主运行循环，不需要手写，因为invalidate方法，内部会把主定时，从主运行循环移除
    
    //[self.link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
}

@end
