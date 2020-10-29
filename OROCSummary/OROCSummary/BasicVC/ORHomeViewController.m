//
//  ORHomeViewController.m
//  ProjectDemo
//
//  Created by orilme on 2017/4/5.
//  Copyright © 2017年 orilme. All rights reserved.
//

#import "ORHomeViewController.h"
#import "KnowledgePointVC.h"
#import "NormalDemoVC.h"
#import "VenderExploreVC.h"
#import "StudyVC.h"

@interface ORHomeViewController ()

@end

@implementation ORHomeViewController

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupTabBarController];
        
//        self.tabBar.tintColor = RGB(182, 65, 65);
        
        //显示未读
        UINavigationController  *discoverNav =(UINavigationController *)self.viewControllers[0];
        UITabBarItem *curTabBarItem=discoverNav.tabBarItem;
        [curTabBarItem setBadgeValue:@"2"];
    }
    return self;
}


- (void)setupTabBarController {
    /// 设置TabBar属性数组
    self.tabBarItemsAttributes =[self tabBarItemsAttributesForController];
    
    /// 设置控制器数组
    self.viewControllers =[self mpViewControllers];
    
    self.delegate = self;
    self.moreNavigationController.navigationBarHidden = YES;
}

// 控制器设置
- (NSArray *)mpViewControllers {
    
    UIViewController *firstViewController = [[StudyVC alloc] init];
    UINavigationController *firstNavigationController = [[ORBaseNavigationController alloc]
                                                         initWithRootViewController:firstViewController];
    
    UIViewController *secondViewController = [[KnowledgePointVC alloc] init];
    UINavigationController *secondNavigationController = [[ORBaseNavigationController alloc]
                                                         initWithRootViewController:secondViewController];
    
    UIViewController *thirdViewController = [[NormalDemoVC alloc] init];
    UINavigationController *thirdNavigationController = [[ORBaseNavigationController alloc]
                                                         initWithRootViewController:thirdViewController];
    
    UIViewController *fourthViewController = [[VenderExploreVC alloc] init];
    UINavigationController *fourthNavigationController = [[ORBaseNavigationController alloc]
                                                          initWithRootViewController:fourthViewController];
    
    
    NSArray *viewControllers = @[
                                 firstNavigationController,
                                 secondNavigationController,
                                 thirdNavigationController,
                                 fourthNavigationController
                                 ];
    return viewControllers;
}

// TabBar文字跟图标设置
- (NSArray *)tabBarItemsAttributesForController {
    NSDictionary *firstTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"学习",
                                                 CYLTabBarItemImage : @"account_normal",
                                                 CYLTabBarItemSelectedImage : @"account_highlight"
                                                 };
    NSDictionary *secondTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"知识点",
                                                  CYLTabBarItemImage : @"account_normal",
                                                  CYLTabBarItemSelectedImage : @"account_highlight"
                                                  };
    NSDictionary *thirdTabBarItemsAttributes = @{
                                                 CYLTabBarItemTitle : @"demo",
                                                 CYLTabBarItemImage : @"account_normal",
                                                 CYLTabBarItemSelectedImage : @"account_highlight"
                                                 };
    NSDictionary *fourthTabBarItemsAttributes = @{
                                                  CYLTabBarItemTitle : @"三方库",
                                                  CYLTabBarItemImage : @"account_normal",
                                                  CYLTabBarItemSelectedImage : @"account_highlight"
                                                  };
    NSArray *tabBarItemsAttributes = @[
                                       firstTabBarItemsAttributes,
                                       secondTabBarItemsAttributes,
                                       thirdTabBarItemsAttributes,
                                       fourthTabBarItemsAttributes
                                       ];
    return tabBarItemsAttributes;
}


#pragma mark - UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController*)tabBarController shouldSelectViewController:(UINavigationController*)viewController {
//    /// 特殊处理 - 是否需要登录
//    BOOL isBaiDuService = [viewController.topViewController isKindOfClass:[MPDiscoveryViewController class]];
//    if (isBaiDuService) {
//        NSLog(@"你点击了TabBar第三个");
//    }
    return YES;
}


@end
