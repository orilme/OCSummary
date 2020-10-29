//
//  CZLockView.m
//  B04.手势解锁
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZLockView.h"

@interface CZLockView ()

/**
 *选中的所有按钮
 */
@property(nonatomic,strong)NSMutableArray *selectedBtns;
@property(nonatomic,assign)CGPoint lastPoint;//最后个触摸点

@end

@implementation CZLockView


-(NSMutableArray *)selectedBtns{
    if (!_selectedBtns) {
        _selectedBtns = [NSMutableArray array];
    }
    
    return _selectedBtns;
}
- (instancetype)initWithFrame:(CGRect)frame {
    //初始化按钮
    if(self = [super initWithFrame:frame]){
        [self setupBtns];
    }
    
    return self;
}

- (void)setupBtns {
    //添加9个按钮
    for (NSInteger i = 0; i < 9; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        //绑定tag
        btn.tag = i;
        
        // 设置默认图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        
        // 设置选中的图片
        [btn setImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        
        // 设置按钮不可用
        btn.userInteractionEnabled = NO;
        
        [self addSubview:btn];
    }
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self touchesMoved:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    //1.判断当前这个触摸点在不在按钮的范围内，如果存在按钮范围内，设置按钮的选取状态
    
    //1.1获取当前触摸点
    UITouch *touch = [touches anyObject];
    CGPoint touchP = [touch locationInView:touch.view];
    
    
    //1.2判断当前这个触摸点在不在按钮的范围内
    // 遍历所有的按钮
    for (UIButton *btn in self.subviews) {
        if (CGRectContainsPoint(btn.frame, touchP)) {
            
            // 放在一个 "选中按钮" 的数组
            if (btn.selected == NO) {
                [self.selectedBtns addObject:btn];
            }
            
            // 设置选中状态
            btn.selected = YES;
            
            NSLog(@"YES....");
        }else{
            // 记录最后触摸点
            self.lastPoint = touchP;
        }
    }
    
    // 重绘
    [self setNeedsDisplay];
    
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSLog(@"选中按钮的个数 %ld",self.selectedBtns.count);
    // 拼接选中按钮的索引
    NSMutableString *password = [NSMutableString string];
    for (UIButton *seletedBtn in self.selectedBtns) {
       [password appendFormat:@"%ld",seletedBtn.tag];
    }
    
    NSLog(@"password:%@",password);
    
    // 取消连线
    // 取消所有按钮的选中状态为NO
    [self.selectedBtns makeObjectsPerformSelector:@selector(setSelected:) withObject:@NO];
    
    // 移除所有选中的按钮
    [self.selectedBtns removeAllObjects];
    
    // 重绘
    [self setNeedsDisplay];
}

#pragma mark 绘制按钮点的连线
- (void)drawRect:(CGRect)rect {

    //遍历所有有选中的按钮
    NSInteger selectedCount = self.selectedBtns.count;
    
    //没有选中按钮，直接返回
    if (selectedCount == 0) return;
    
    //创建一个路径
    UIBezierPath *path = [UIBezierPath bezierPath];
    for (NSInteger i = 0; i < selectedCount;i++ ) {
        CGPoint btnCenter = [self.selectedBtns[i] center];
        if (i == 0) {
            [path moveToPoint:btnCenter];
        }else{
            [path addLineToPoint:btnCenter];
        }
    }
    
    // 追回一个点的路径
    [path addLineToPoint:self.lastPoint];
    
    path.lineWidth = 8;
    // 连接点样式
    path.lineJoinStyle = kCGLineJoinRound;
    path.lineCapStyle = kCGLineCapRound;
    [[UIColor greenColor] set];
    // 渲染
    [path stroke];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    //重新布局9个按钮
    
    CGFloat btnW = 74;
    CGFloat btnH = 74;
    NSInteger btnCount = self.subviews.count;
    
    // 每一个按钮的间距
    CGFloat padding = (self.frame.size.width - 3 * btnW) / 4;
    
    for (NSInteger i = 0; i < btnCount; i++) {
        UIButton *btn = self.subviews[i];
        
        // 当前按钮所处的列
        NSInteger column = i % 3;
        
        // 当前按钮所处的行
        NSInteger row = i / 3;
        
        // 计算每一个按钮的位置
        // x = 间距 + （按钮的宽度 + 间距） * 列
        CGFloat btnX = padding + (btnW + padding) * column;
        
        // y = 间距 + （按钮的高度 + 间距） * 行
        CGFloat btnY = padding + (btnH + padding) * row;
        
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
