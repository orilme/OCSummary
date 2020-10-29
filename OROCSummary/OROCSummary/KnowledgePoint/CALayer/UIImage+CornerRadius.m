//
//  UIImage+CornerRadius.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/2.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "UIImage+CornerRadius.h"

@implementation UIImage (CornerRadius)

+ (UIImage *)cornerImageWithImageName:(NSString *)imageName cornerRadius:(CGFloat)cornerRadius borderColor:(UIColor *)borderColor borderWithd:(CGFloat)borderWidth {

    UIImage *image = [UIImage imageNamed:imageName];
    CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
    
    CALayer *layer = [CALayer layer];
    layer.bounds = imageRect;
    layer.cornerRadius = cornerRadius;
    layer.borderColor = borderColor.CGColor;
    layer.borderWidth = borderWidth;
    layer.masksToBounds = YES;
    layer.contents = (id)image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(image.size, NO, 0.0);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *newImg = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImg;
    
}

@end
