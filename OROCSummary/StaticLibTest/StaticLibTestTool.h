//
//  StaticLibTestTool.h
//  StaticLibTest
//
//  Created by orilme on 2021/6/5.
//  Copyright © 2021 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface StaticLibTestTool : NSObject

+ (NSInteger)sumNum1:(NSInteger)num1 withNum2:(NSInteger)num2;
+ (UIImage *)loadImage;

@end

NS_ASSUME_NONNULL_END
