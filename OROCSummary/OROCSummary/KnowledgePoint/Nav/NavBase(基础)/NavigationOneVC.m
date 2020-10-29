//
//  NavigationOneVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NavigationOneVC.h"
#import "NavigationTwoVC.h"

@interface NavigationOneVC ()

@end

@implementation NavigationOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    self.title = @"第一个控制器";
    UINavigationItem *navItem = self.navigationItem;

    
    UIBarButtonItem *addBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    UIBarButtonItem *cameraBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:nil action:nil];
    
    //导航栏左边按钮
    //navItem.leftBarButtonItem = addBtn;
    navItem.leftBarButtonItems = @[addBtn,cameraBtn];
    
    //导航栏右边按钮
    UIBarButtonItem *composeBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:nil action:nil];
    navItem.rightBarButtonItem = composeBtn;
    
    
    // 当前控制器的navgationItem设置的返回按钮是在下一个控制器中显示的
    //设置下一个控制器的返回按钮
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    navItem.backBarButtonItem = backItem;
    
}

/**
 * 跳到第二个控制器
 */
- (IBAction)toSecondVc:(id)sender {

    NavigationTwoVC *twoVc = [[NavigationTwoVC alloc] init];
    
    [self.navigationController pushViewController:twoVc animated:YES];
}

@end
