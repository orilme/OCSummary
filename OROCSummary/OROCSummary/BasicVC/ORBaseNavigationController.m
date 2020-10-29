//
//  ORBaseNavigationController.m
//  ProjectDemo
//
//  Created by orilme on 2017/4/5.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import "ORBaseNavigationController.h"

@implementation ORBaseNavigationController

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (self.viewControllers.count > 0) {
        //第二级则隐藏底部Tab
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

@end
