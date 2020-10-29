//
//  CZRedView.m
//  A02.触摸事件的传递
//
//  Created by apple on 15-1-4.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZRedView.h"

@implementation CZRedView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

/*
 * 不实现touchesBegan方法，默认把事件传给上一个响应者
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s %p",__func__,event);
    
    //调用了super方法，相当于把事件传给上一个响应者
    [super touchesBegan:touches withEvent:event];
}

@end
