//
//  CZColorPaintView.h
//  A05.涂鸦
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZColorPaintView : UIView


@property(nonatomic,strong)UIColor *currentColor;//当前选中的颜色

-(void)back;

-(void)clear;

@end
