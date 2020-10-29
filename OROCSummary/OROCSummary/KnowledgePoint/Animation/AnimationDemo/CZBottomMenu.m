//
//  CZBottomMenu.m
//  B01.底部旋转菜单
//
//  Created by apple on 15-1-5.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZBottomMenu.h"

#define AnimiationDuration 5
#define delta 90 //按钮间的间距

@interface CZBottomMenu()
/**
 *  Items存放三个隐藏按钮
 */
@property(nonatomic,strong)NSMutableArray *items;
@property (weak, nonatomic) IBOutlet UIButton *mainBtn;
- (IBAction)mainBtnClick:(id)sender;

@end

@implementation CZBottomMenu

-(NSMutableArray *)items{
    if (!_items) {
        _items = [NSMutableArray array];
    }
    
    return _items;
}

+(instancetype)buttomMenu{

    return [[[NSBundle mainBundle] loadNibNamed:@"CZBottomMenu" owner:nil options:nil] lastObject];
}


#pragma mark 对象是从xib/storybard加载的时候，就会调用这个方法
-(id)initWithCoder:(NSCoder *)aDecoder{
    NSLog(@"%s",__func__);
    if(self = [super initWithCoder:aDecoder ]){
        [self initItems];
    }
    
    return self;
}

#pragma mark 初始化三个隐藏的按钮
-(void)initItems{
    [self addBtnWithBgImage:@"menu_btn_call" tag:0];
    [self addBtnWithBgImage:@"menu_btn_cheyou" tag:1];
    [self addBtnWithBgImage:@"menu_btn_tixing" tag:2];
    
}
/**
 *  通过一张图片来添加按钮
 *
 */
-(void)addBtnWithBgImage:(NSString *)bgImage tag:(NSInteger)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:bgImage] forState:UIControlStateNormal];
    btn.tag = tag;
    [self.items addObject:btn];
    [self addSubview:btn];
    
    
}

#pragma mark 设置三个隐藏按钮的尺寸和位置
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    //所有隐藏按钮的大小是一样
    CGRect btnBounds = CGRectMake(0, 0, 43, 43);
    
    //遍历三个隐藏的按钮
    for (UIButton *btn in self.items) {
        btn.bounds = btnBounds;
        btn.center = self.mainBtn.center;
    }
    
    //把 "红色按钮" 置顶
    [self bringSubviewToFront:self.mainBtn];

}



- (IBAction)mainBtnClick:(id)sender {
    BOOL show = CGAffineTransformIsIdentity(self.mainBtn.transform);
    
    // 1.实现 主按钮 动画效果
    [UIView animateWithDuration:AnimiationDuration animations:^{
        if (show) {//代表transform未被改变
            self.mainBtn.transform = CGAffineTransformMakeRotation(M_PI_4);
        }else{//恢复
            self.mainBtn.transform = CGAffineTransformIdentity;
        }
        
    }];
    
    // 显示 items
    [self showItems:show];
    
}

-(void)showItems:(BOOL)show{
    
#warning 默认情况 按钮的中心与按钮的图层的position是一样
    NSLog(@"主按钮中心点 %@",NSStringFromCGPoint(self.mainBtn.center));
    NSLog(@"主按钮的图层的position %@",NSStringFromCGPoint(self.mainBtn.layer.position));
    
    // 实现 items 的 显示位置
    for (UIButton *btn in self.items) {
#warning 一个按钮对应一个组动画
        // 2.创建动画
        // 2.1创建组组动画
        CAAnimationGroup *group = [CAAnimationGroup animation];
        group.duration = AnimiationDuration;
        
        // 2.2 添加一个 ”平移动画“
        CAKeyframeAnimation *positionAni = [CAKeyframeAnimation animation];
        positionAni.keyPath = @"position";
        
        
        // 2.3 添加一个 ”旋转的动画“
        CAKeyframeAnimation *rotationAni = [CAKeyframeAnimation animation];
        rotationAni.keyPath = @"transform.rotation";
        
        //重新设置每个按钮的x值
        CGFloat btnCenterX = self.mainBtn.center.x + (btn.tag + 1) * delta;
        CGFloat btnCenterY = self.mainBtn.center.y;
        
        // 最终显示的位置
        CGPoint showPosition = CGPointMake(btnCenterX, btnCenterY);

        //设置 "平移动画: 的 路径
        NSValue *value1 = [NSValue valueWithCGPoint:self.mainBtn.center];
        NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX * 0.5, btnCenterY)];
        NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(btnCenterX * 1.1, btnCenterY)];
        NSValue *value4 = [NSValue valueWithCGPoint:showPosition];
        positionAni.values = @[value1,value2,value3,value4];
        
        //显示
        if (show) {
            

            
            //设置 旋转的路径
            rotationAni.values = @[@0,@(M_PI * 2),@(M_PI * 4),@(M_PI * 2)];
            
            btn.center = showPosition;
        }else{
            //隐藏
            
            //设置 "平移动画: 的 路径
            positionAni.values = @[value4,value3,value2,value1];
            
            btn.center = self.mainBtn.center;
            rotationAni.values = @[@0,@(M_PI * 2),@(0),@(-M_PI * 2)];
        }
        
        
        //添加子动画
        group.animations = @[positionAni,rotationAni];
        
        //执行组动画
        [btn.layer addAnimation:group forKey:nil];
        
        
    }
    
    
    
    
}
@end
