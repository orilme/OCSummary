//
//  WheelButton.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/13.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "WheelButton.h"

@implementation WheelButton

-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    //固定图片的大小
    CGFloat imgW = 40;
    CGFloat imgH = 48;
    CGFloat imgX = ( contentRect.size.width - imgW) * 0.5;
    return CGRectMake(imgX, 20, imgW, imgH);
}


-(void)setHighlighted:(BOOL)highlighted{
    
}

@end
