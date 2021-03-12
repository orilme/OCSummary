//
//  ORLineViewVC.m
//  OROCSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORLineViewVC.h"
#import "ORLineView.h"
#import "ORCustomView.h"
#import "ORCustomTwoView.h"
#import "ORUIKitCustomView.h"

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
    ORCustomView *customView = [[ORCustomView alloc] initWithFrame:CGRectMake(10, 320, 200, 200)];
    customView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView];
    
    //
    ORCustomTwoView *customView4 = [[ORCustomTwoView alloc] initWithFrame:CGRectMake(220, 320, 200, 200)];
    customView4.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView4];
    
    
    // UIKit绘图方法
    ORUIKitCustomView *customView3 = [[ORUIKitCustomView alloc] initWithFrame:CGRectMake(10, 530, 200, 200)];
    customView3.backgroundColor = [UIColor grayColor];
    [self.view addSubview:customView3];
}

@end
