//
//  UIImage+CZ.h
//  B06.图片水印
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CZ)

/**
 *
 *  @param bgImageName    背景图片
 *  @param waterImageName 水印图片
 *  @param scale 图片生成的比例
 *  @return 添加了水印的背景图片
 */
+(UIImage *)waterImageWithBgImageName:(NSString *)bgImageName waterImageName:(NSString *)waterImageName scale:(CGFloat)scale;


/**
 *
 *  @param imageName    需要裁剪的图片
 *  @param borderColor 边框的颜色
 *  @param borderWidth 边框的宽度
 *  @return 一个裁剪 带有边框的圆形图片
 */
+(UIImage *)circleImageWithImageName:(NSString *)imageName borderColor:(UIColor *)borderColor borderWidth:(CGFloat)borderWidth;


/**
 *
 *  @param captureView    需要截图View
 *  @return 返回view的图片
 */
+(UIImage *)captureImage:(UIView *)captureView;
@end
