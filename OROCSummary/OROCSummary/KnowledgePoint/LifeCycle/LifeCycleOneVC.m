//
//  LifeCycleOneVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/12.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "LifeCycleOneVC.h"

@interface LifeCycleOneVC ()

@end

@implementation LifeCycleOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"one view加载完成");
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"one  view将显示");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"one  view完成显示");
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"one  view将消失");
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"one  view已经消失");
}

-(void)viewWillUnload {
    [super viewWillUnload];
    NSLog(@"one view将卸载");
    //self.view = nil;
//    [self.image release];
    //消除资源 数组(图片)
}

-(void)viewDidUnload {
    [super viewDidUnload];
    NSLog(@"one view已经卸载");
}

//内存警告
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // 自觉清除一些不必要的内存
    //self.images = nil;
    NSLog(@"%s",__func__);
}


@end
