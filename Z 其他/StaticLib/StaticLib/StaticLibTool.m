//
//  StaticLibTool.m
//  StaticLib
//
//  Created by orilme on 2021/6/2.
//

/*
 1.编译静态库:项目->Build Phases->Copy File->添加头文件
 2.模拟器编译时,挑选高版本(向下兼容,低版本不能在高版本运行)
 3.静态库分真机版本和模拟器版本(必须在对应的版本运行)
 4.合并真机版本和模拟器版本
 lipo -create 真机.a 模拟器.a -output 结果.a
 合并版本更大,开始时使用方便(所以可以开发时使用合并版本,发布时,使用真机版本)
 5.release版本和debug版本:
 debug版本:调试版本,没有就行任何优化,也就是说各种错误信息,都将抛出和检测,相对来说性能低一点,但是方便调试
 release版本:发布版本,就行优化,执行效率更高
 提醒:实际开发当中,项目完成后,在debug版本上没有问题了,一定要去release版本上调试一下,否则可能发生一些bug
 */

#import "StaticLibTool.h"

@implementation StaticLibTool

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
