//
//  CZGreenView.m
//  A02.触摸事件的传递
//
//  Created by apple on 15-1-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZGreenView.h"

@implementation CZGreenView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}


#pragma mark 判断当前的触摸点在不在自己的身上
-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{

//    // 绿色左边的可以 "响应事件" ,右边不可以响应事件
//    if(point.x <= self.bounds.size.width * 0.5){
//        return YES;
//    }
    
//    BOOL pointInside = [super pointInside:point withEvent:event];
//    
//    NSLog(@"%s %d",__func__,pointInside);
    //return pointInside;
    
    return NO;
}

@end
