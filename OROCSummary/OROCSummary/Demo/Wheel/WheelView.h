//
//  WheelView.h
//  ORIOSSummary
//
//  Created by orilme on 2019/11/13.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WheelView : UIView

+(instancetype)wheel;

/**
 *  停止自动旋转
 */
- (void)stopAutoRotate;

/**
 *  开始自动旋转
 */
- (void)startAutoRotate;

@end
