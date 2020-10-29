//
//  DrawRectDemoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/5.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "DrawRectDemoVC.h"
#import "BallonView.h"
#import "CADisplayLinkBallonView.h"
#import "CADisplayLinkBallonUpView.h"

@interface DrawRectDemoVC ()

@end

@implementation DrawRectDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 添加 自定义气球的view到控制器view
    BallonView *ballonView = [[BallonView alloc] initWithFrame:CGRectMake(0, 0, 100, 900)];
    ballonView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:ballonView];
    
    
    CADisplayLinkBallonView *ballonView2 = [[CADisplayLinkBallonView alloc] initWithFrame:CGRectMake(100, 0, 100, 900)];
    ballonView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:ballonView2];
    
    
    CADisplayLinkBallonUpView *ballonView3 = [[CADisplayLinkBallonUpView alloc] initWithFrame:CGRectMake(200, 0, 400, 900)];
    ballonView3.backgroundColor = [UIColor systemPinkColor];
    [self.view addSubview:ballonView3];
    
}


@end
