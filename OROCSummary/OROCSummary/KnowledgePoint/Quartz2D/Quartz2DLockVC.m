//
//  Quartz2DLockVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/13.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "Quartz2DLockVC.h"
#import "CZLockView.h"

@interface Quartz2DLockVC ()

@end

@implementation Quartz2DLockVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //添加背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    
    //分析
    
    CZLockView *lockView = [[CZLockView alloc] init];
    //设置大小和位置
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    lockView.bounds = CGRectMake(0, 0, screenW, screenW);
    lockView.backgroundColor = [UIColor clearColor];
    lockView.center = self.view.center;
    [self.view addSubview:lockView];
    
    /*
     * A.默认排版
     * 1.自定一个View
     * 2.自定View添加到控制器view
     * 3.自定View添加按钮
     
     * B.设置选中的按钮
       1.判断当前这个触摸点在不在按钮的范围内，如果存在按钮范围内，设置按钮的选取状态
     
     * C.设置按钮间连线 UIBezierPath
     * 1.记录所有选中按钮 放一个数组
     * 2.遍历选中按钮的数组 进行绘制 "线"
     * 3.手指抬开的时候，取消连线
     
     * D.添加最后一点的连线
     * 1.添加一个属性记录最后的触摸点
     * 2.在drawRect方法，画线的时候，追加一个点
     
     * E.选完密码后通知控制器
     *  1.添加代理
     *  2.拼接选中按钮的索引[touchEnd] 012345
     *  3.通知代理
     */
}


@end
