//
//  ORUIKitCustomView.m
//  OROCSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORUIKitCustomView.h"

@implementation ORUIKitCustomView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
 
    // 以前一直都要获取上下文，
    // UIKit的方法，虽然不用获取上下文，但内部最终都会获取上下文进行绘制
    
    //使用UIkit绘图方法
    
    //画实心
    UIRectFill(CGRectMake(10, 10, 100, 100));
    
    //画空心
    UIRectFrame(CGRectMake(10, 110, 50, 50));
}

@end
