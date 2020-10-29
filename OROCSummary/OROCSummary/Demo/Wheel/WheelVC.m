//
//  WheelVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/13.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "WheelVC.h"
#import "WheelView.h"

@interface WheelVC ()
@property(nonatomic,weak)WheelView *wheel;
@end

@implementation WheelVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //创建转盘
    WheelView *wheel = [WheelView wheel];
    wheel.center = self.view.center;
    [self.view addSubview:wheel];
    self.wheel = wheel;
    
    UIButton *startBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 200, 20)];
    startBtn.backgroundColor = [UIColor redColor];
    [startBtn setTitle:@"开始" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startAutoRotate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startBtn];
    
    UIButton *stopBtn = [[UIButton alloc]initWithFrame:CGRectMake(10, 150, 200, 20)];
    stopBtn.backgroundColor = [UIColor redColor];
    [stopBtn setTitle:@"停止" forState:UIControlStateNormal];
    [stopBtn addTarget:self action:@selector(stopAutoRotate) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:stopBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)stopAutoRotate {
    //调用 转盘 的停止自动旋转的方法
    [self.wheel stopAutoRotate];
}
- (void)startAutoRotate {
    //调用 转盘 的开始自动旋转的方法
    [self.wheel startAutoRotate];
}

@end
