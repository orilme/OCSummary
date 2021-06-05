//
//  StaticLibVC.m
//  OROCSummary
//
//  Created by orilme on 2021/6/2.
//  Copyright © 2021 orilme. All rights reserved.
//

#import "StaticLibVC.h"
#import "StaticLibTool.h"
#import "StaticLibTestTool.h"

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


/*
 1.添加静态库文件:项目->General->左下角+->添加静态库(StaticLib)
 2.在StaticLib文件夹内就可以就行开发静态库
 3.项目引入静态库:项目->General->Linked Frameworks and Libraries->添加静态库
 4.导出静态库:选择左上角房子->同之前导出方式
 */

// 库的资源文件一般方法bundle中

@interface StaticLibVC ()

@end

@implementation StaticLibVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    NSLog(@"StaticLibTool---%ld", [StaticLibTool sumNum1:10 withNum2:20]);
    NSLog(@"StaticLibTestTool---%ld", [StaticLibTestTool sumNum1:1 withNum2:2]);
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    imageView.image = [StaticLibTestTool loadImage];
    imageView.backgroundColor = [UIColor redColor];
    [self.view addSubview:imageView];
}

@end
