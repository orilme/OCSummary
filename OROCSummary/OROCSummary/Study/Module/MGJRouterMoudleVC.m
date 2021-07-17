//
//  MGJRouterMoudleVC.m
//  OROCSummary
//
//  Created by orilme on 2021/7/11.
//  Copyright © 2021 orilme. All rights reserved.
//

#import "MGJRouterMoudleVC.h"
#import <MGJRouter/MGJRouter.h>

@interface MGJRouterMoudleVC ()

@end

@implementation MGJRouterMoudleVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *centerBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    centerBtn.frame = CGRectMake(10, 100, 300, 50);
    [centerBtn setTitle:@"跳转到UserCenter模块" forState:UIControlStateNormal];
    [centerBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    centerBtn.backgroundColor = [UIColor greenColor];
    [centerBtn addTarget:self action:@selector(toUserCenterVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:centerBtn];
    
    UIButton *homeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    homeBtn.frame = CGRectMake(10, 200, 300, 50);
    [homeBtn setTitle:@"跳转到HomePage模块" forState:UIControlStateNormal];
    [homeBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    homeBtn.backgroundColor = [UIColor greenColor];
    [homeBtn addTarget:self action:@selector(toHomePageVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:homeBtn];
}

- (void)toUserCenterVC {
    [MGJRouter openURL:@"CTB://UserCenter/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController}
            completion:nil];
}

- (void)toHomePageVC {
    [MGJRouter openURL:@"CTB://HomePage/PushMainVC"
          withUserInfo:@{@"navigationVC" : self.navigationController}
            completion:nil];
}

@end
