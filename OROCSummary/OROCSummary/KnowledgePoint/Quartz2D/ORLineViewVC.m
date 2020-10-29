//
//  ORLineViewVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORLineViewVC.h"
#import "ORLineView.h"
#import "CZCustomView.h"
#import "CZCustomTwoView.h"
#import "CZCustomThreeView.h"
#import "UIKitCustomView.h"

@interface ORLineViewVC ()
@end

@implementation ORLineViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
    
    ORLineView *view = [[ORLineView alloc]initWithFrame:CGRectMake(100, 100, 200, 200)];
    [self.view addSubview:view];

    
    // 图形的上下文栈
    CZCustomView *customView = [[CZCustomView alloc] initWithFrame:CGRectMake(10, 320, 200, 200)];
    customView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView];
    
    //
    CZCustomThreeView *customView4 = [[CZCustomThreeView alloc] initWithFrame:CGRectMake(220, 320, 200, 200)];
    customView4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView4];
    
    // 矩阵操作
    CZCustomTwoView *customView2 = [[CZCustomTwoView alloc] initWithFrame:CGRectMake(10, 530, 200, 200)];
    customView2.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView2];
    
    
    // UIKit绘图方法
    UIKitCustomView *customView3 = [[UIKitCustomView alloc] initWithFrame:CGRectMake(220, 530, 200, 200)];
    customView3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView3];
}

@end
