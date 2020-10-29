//
//  AnimationDemoTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/19.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "AnimationDemoTwoVC.h"
#import "AnimatiomView.h"
#import "UIColor+Hex.h"

@interface AnimationDemoTwoVC ()<AnimatiomViewDelegate>

@property (strong, nonatomic) AnimatiomView *animationView;

@end

@implementation AnimationDemoTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self _initAnimationView];
}

- (void)_initAnimationView {
    CGFloat size = 100.0;
    self.animationView = [[AnimatiomView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)];
    _animationView.delegate = self;
    _animationView.parentFrame = self.view.frame;
    [self.view addSubview:_animationView];
}

#pragma mark -
#pragma mark AnimatiomViewDelegate

- (void)completeAnimation {
    [_animationView removeFromSuperview];
    self.view.backgroundColor = [UIColor colorWithHexString:@"#40e0b0"];
    
    // 2
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Welcome";
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.4 delay:0.0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        label.transform = CGAffineTransformScale(label.transform, 4.0, 4.0);

    } completion:^(BOOL finished) {
        [self addTouchButton];
    }];
}

- (void)addTouchButton {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame));
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)btnClick {
    self.view.backgroundColor = [UIColor whiteColor];
    for (UIView *view in self.view.subviews) {
        [view removeFromSuperview];
    }
    self.animationView = nil;
    [self _initAnimationView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
