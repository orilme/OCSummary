//
//  StaticLibTestTool.m
//  StaticLibTest
//
//  Created by orilme on 2021/6/5.
//  Copyright © 2021 orilme. All rights reserved.
//

#import "StaticLibTestTool.h"

@implementation StaticLibTestTool
+ (NSInteger)sumNum1:(NSInteger)num1 withNum2:(NSInteger)num2
{
    return num1 + num2;
}

+ (UIImage *)loadImage
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"lufy.png" ofType:nil inDirectory:@"StaticLibTool.bundle"];
    return [UIImage imageWithContentsOfFile:path];
}
@end
