//
//  HLShareView.m
//  HLShareView
//
//  Created by 杜海龙 on 16/9/2.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import "HLShareView.h"
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
@implementation HLShareView

-(instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        
        [self addUI];
    }
    return self;
}

- (void)addUI{

    UIView *shareBodyView            = [[UIView alloc]initWithFrame:CGRectMake(20,
                                                                            (ScreenHeight-200)/2,
                                                                            ScreenWidth-40,
                                                                            200)];
    shareBodyView.backgroundColor     =[UIColor whiteColor];
    shareBodyView.layer.cornerRadius  = 5;
    shareBodyView.layer.masksToBounds = YES;
    [self addSubview:shareBodyView];
    
    UIButton * noOneButton      = [self creatBtnWithFrame:CGRectMake(20+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10, 49, 49)
                                                    image:[UIImage imageNamed:@"aimage2"]
                                           animationFrame:CGRectMake(20+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10+10, 49, 49)
                                                    delay:0];
    noOneButton.tag                = 1;
    noOneButton.layer.cornerRadius = 49/2;
    noOneButton.layer.masksToBounds= YES;
    noOneButton.backgroundColor    = [UIColor orangeColor];
    [noOneButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * noTwoButton      = [self creatBtnWithFrame:CGRectMake(20+(ScreenWidth-40)/4+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10, 49, 49)
                                                    image:[UIImage imageNamed:@"aimage2"]
                                           animationFrame:CGRectMake(20+(ScreenWidth-40)/4+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10+10, 49, 49)
                                                    delay:0];
    noTwoButton.tag                = 2;
    noTwoButton.layer.cornerRadius = 49/2;
    noTwoButton.layer.masksToBounds= YES;
    noTwoButton.backgroundColor    = [UIColor orangeColor];
    [noTwoButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * noThreeButton      = [self creatBtnWithFrame:CGRectMake(20+(ScreenWidth-40)/4*2+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10, 49, 49)
                                                    image:[UIImage imageNamed:@"aimage2"]
                                           animationFrame:CGRectMake(20+(ScreenWidth-40)/4*2+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10+10, 49, 49)
                                                    delay:0];
    noThreeButton.tag                = 3;
    noThreeButton.layer.cornerRadius = 49/2;
    noThreeButton.layer.masksToBounds= YES;
    noThreeButton.backgroundColor    = [UIColor orangeColor];
    [noThreeButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton * noFourButton      = [self creatBtnWithFrame:CGRectMake(20+(ScreenWidth-40)/4*3+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10, 49, 49)
                                                    image:[UIImage imageNamed:@"aimage2"]
                                           animationFrame:CGRectMake(20+(ScreenWidth-40)/4*3+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+10+10, 49, 49)
                                                    delay:0];
    noFourButton.tag                = 4;
    noFourButton.layer.cornerRadius = 49/2;
    noFourButton.layer.masksToBounds= YES;
    noFourButton.backgroundColor    = [UIColor orangeColor];
    [noFourButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    UIButton * noFiveButton         = [self creatBtnWithFrame:CGRectMake(20+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+100+10, 49, 49)
                                                        image:[UIImage imageNamed:@"aimage2"]
                                               animationFrame:CGRectMake(20+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+100+10+10, 49, 49)
                                                        delay:0];
    noFiveButton.tag                = 5;
    noFiveButton.layer.cornerRadius = 49/2;
    noFiveButton.layer.masksToBounds= YES;
    noFiveButton.backgroundColor    = [UIColor orangeColor];
    [noFiveButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton * noSixButton          = [self creatBtnWithFrame:CGRectMake(20+(ScreenWidth-40)/4+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+100+10, 49, 49)
                                                        image:[UIImage imageNamed:@"aimage2"]
                                               animationFrame:CGRectMake(20+(ScreenWidth-40)/4+((ScreenWidth-40)/4-49)/2, (ScreenHeight-200)/2+100+10+10, 49, 49)
                                                        delay:0];
    noSixButton.tag                = 6;
    noSixButton.layer.cornerRadius = 49/2;
    noSixButton.layer.masksToBounds= YES;
    noSixButton.backgroundColor    = [UIColor orangeColor];
    [noSixButton addTarget:self action:@selector(shareButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
}


-(void)shareShow{

    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [UIView animateWithDuration:0.38 animations:^{
       [keyWindow addSubview:self];
    }];
    
}

-(void)shareButtonClick:(UIButton*)sender{
    
    for (NSInteger i = 0; i<self.subviews.count; i++){
        UIView *view = self.subviews[i];
        if ([view isKindOfClass:[UIButton class]]){
            [UIView animateWithDuration:0.3 delay:0.1*i options:UIViewAnimationOptionTransitionCurlDown animations:^{
                view.frame = CGRectMake(view.frame.origin.x,
                                        (ScreenHeight-200)/2+10,
                                        49,
                                        49);
            } completion:^(BOOL finished) {
            }];
        }
    }
    
    [self performSelector:@selector(removeView:) withObject:sender afterDelay:0.38];
}




-(void)removeView:(UIButton *)sender{
    
    [UIView animateWithDuration:0.38 animations:^{
        [self removeFromSuperview];
    }];
    
    [self.delegate shareView:sender didSelectButWithBtnTag:sender.tag];
}

//touch
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch *touch            = [touches anyObject];
    CGPoint currentPosition   = [touch locationInView:self];
    CGFloat currentY          = currentPosition.y;
    if (currentY<(ScreenHeight-200)/2||currentY>(ScreenHeight-200)/2+200){
        
        for (NSInteger i = 0; i<self.subviews.count; i++){
            UIView *view = self.subviews[i];
            if ([view isKindOfClass:[UIButton class]]){
                [UIView animateWithDuration:0.3 delay:0.1*i options:UIViewAnimationOptionTransitionCurlDown animations:^{
                    view.frame = CGRectMake(view.frame.origin.x,
                                            (ScreenHeight-200)/2+10,
                                            49,
                                            49);
                } completion:^(BOOL finished) {
                    [UIView animateWithDuration:0.38 animations:^{
                       
                        [self removeFromSuperview];
                    }];
                    
                }];
            }
        }
        
    }
}


//creat share btn
-(UIButton *)creatBtnWithFrame:(CGRect)frame
                         image:(UIImage *)image
                animationFrame:(CGRect)animationFrame
                         delay:(CGFloat)afterDelay{
    
    UIButton *shareButton      = [[UIButton alloc]init];
    shareButton.frame          = frame;
    [shareButton setBackgroundImage:image
                           forState:UIControlStateNormal];
    [self  addSubview:shareButton];
    
    [UIView animateWithDuration:1.0 delay:afterDelay usingSpringWithDamping:0.2 initialSpringVelocity:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        shareButton.frame      = animationFrame;
    } completion:^(BOOL finished) {
        
    }];
    return shareButton;
    
    //usingSpringWithDamping :弹簧动画的阻尼值，也就是相当于摩擦力的大小，该属性的值从0.0到1.0之间，越靠近0，阻尼越小，弹动的幅度越大，反之阻尼越大，弹动的幅度越小，如果大道一定程度，会出现弹不动的情况。
    
    //initialSpringVelocity  :弹簧动画的速率，或者说是动力。值越小弹簧的动力越小，弹簧拉伸的幅度越小，反之动力越大，弹簧拉伸的幅度越大。这里需要注意的是，如果设置为0，表示忽略该属性，由动画持续时间和阻尼计算动画的效果。
}


@end
