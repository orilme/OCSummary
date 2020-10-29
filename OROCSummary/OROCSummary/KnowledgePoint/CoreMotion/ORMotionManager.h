//
//  ORMotionManager.h
//  ORIOSSummary
//
//  Created by orilme on 2019/3/10.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import <CoreMotion/CoreMotion.h>

@interface ORMotionManager : CMMotionManager

+ (instancetype)shareMotionManager;

@end

