//
//  ScrollImageView.h
//  轮播图
//
//  Created by xiaoshi on 16/2/17.
//  Copyright © 2016年 kamy. All rights reserved.
//

#import <UIKit/UIKit.h>
#define ScreenSize      [UIScreen mainScreen].bounds.size
#define ScrollWidth     ScreenSize.width
#define ScrollHeight    300
@interface ScrollImageView : UIView

- (void)stopScroll;

@end
