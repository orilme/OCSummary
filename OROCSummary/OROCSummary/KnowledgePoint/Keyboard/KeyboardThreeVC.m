//
//  KeyboardThreeVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/03/07.
//  Copyright © 2020 orilme. All rights reserved.
//


#import "KeyboardThreeVC.h"

#import "KeyboardNotificationCenter.h"

@interface KeyboardThreeVC () <UITextFieldDelegate,KeyboardNotificationCenterDelegate>
{
    UITextField * _textField;
}

@end

@implementation KeyboardThreeVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // 设置代理
    [KeyboardNotificationCenter defineCenter].delegate = self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton * btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 30)];
    [btn1 setTitle:@"上一页" forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(previousPage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    
    
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, [UIScreen mainScreen].bounds.size.height -60, [UIScreen mainScreen].bounds.size.width -20, 30)];
    _textField.placeholder       = @"这是一个输入框";
    _textField.layer.borderColor = [UIColor blackColor].CGColor;
    _textField.layer.borderWidth = 1.f;
    _textField.delegate          = self;
    [self.view addSubview:_textField];
}

- (void)previousPage{
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void)previousPage{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

#pragma mark - KeyboardNotificationCenter Delegate

- (void)showOrHiddenKeyboardWithHeight:(CGFloat)height withDuration:(CGFloat)animationDuration isShow:(BOOL)isShow{
    
    NSLog(@"ViewController3 接收到%@通知\n高度值：%f\n时间：%f",isShow ? @"弹出":@"隐藏", height,animationDuration);
    
    [UIView animateWithDuration:animationDuration animations:^{
        [_textField setFrame:CGRectMake(_textField.frame.origin.x, [UIScreen mainScreen].bounds.size.height -30 -height, _textField.frame.size.width, _textField.frame.size.height)];
    }];
}

#pragma mark - UITextField Delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}


@end
