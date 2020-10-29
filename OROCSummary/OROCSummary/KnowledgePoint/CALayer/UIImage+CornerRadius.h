//
//  UIImage+CornerRadius.h
//  ORIOSSummary
//
//  Created by orilme on 2019/12/2.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (CornerRadius)

/**
 * 圆角图片
 */
+ (UIImage *)cornerImageWithImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWithd:(CGFloat)borderWidth;

@end
