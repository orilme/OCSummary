//
//  CircleImageView.h
//  A04.裁剪圆角图片
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CircleImageView : UIView

/**
 *  图片名称
 */
@property (nonatomic,copy) NSString *imageName;

/**
 *  边框的颜色
 */
@property (nonatomic,strong) UIColor *borderColor;

/**
 *  边框的宽度
 */
@property (nonatomic,assign) CGFloat borderWidth;

@end
