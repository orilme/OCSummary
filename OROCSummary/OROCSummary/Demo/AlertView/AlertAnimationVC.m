//
//  AlertAnimationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/1.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "AlertAnimationVC.h"
#import "HLShareView.h"
#import "PresentVC.h"
#import "PresentationController.h"

@interface AlertAnimationVC ()<HLShareViewDelegate, UIPopoverPresentationControllerDelegate>

@end

@implementation AlertAnimationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(100, 100, 200, 50);
    [rightBtn setTitle:@"菜单" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    rightBtn.backgroundColor = [UIColor greenColor];
    [rightBtn addTarget:self action:@selector(popMenu) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:rightBtn];
    
}

// delegate-弹出视图代理

// 返回控制控制器弹出动画的对象
/**
 presentedViewController     将要跳转到的目标控制器
 presentingViewController    跳转前的原控制器
 */
- (UIPresentationController *)presentationControllerForPresentedViewController:(UIViewController *)presented presentingViewController:(UIViewController *)presenting sourceViewController:(UIViewController *)source{
    return [[PresentationController alloc] initWithPresentedViewController:presented presentingViewController:presenting];
}

- (void)popMenu {
//    HLShareView *hlShareView = [[HLShareView alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    hlShareView.delegate = self;
//    [hlShareView shareShow ];
    
    PresentVC *presentVC = [[PresentVC alloc] init];
    // 设置 动画样式
    presentVC.modalPresentationStyle = UIModalPresentationPopover;
    //presentVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    // 此对象要实现 UIViewControllerTransitioningDelegate 协议
    presentVC.transitioningDelegate = self;
    [self presentViewController:presentVC animated:YES completion:nil];
}

#pragma mark - HLShareViewDelegate
-(void)shareView:(UIView *)self didSelectButWithBtnTag:(NSInteger)btnTag{
    NSLog(@"%ld",btnTag);
}


@end
