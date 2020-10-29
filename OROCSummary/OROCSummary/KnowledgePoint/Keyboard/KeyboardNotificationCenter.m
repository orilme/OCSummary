//
//  KeyboardNotificationCenter.m
//  ORIOSSummary
//
//  Created by orilme on 2020/03/07.
//  Copyright © 2020 orilme. All rights reserved.
//


#import "KeyboardNotificationCenter.h"

@implementation KeyboardNotificationCenter

+ (KeyboardNotificationCenter *)defineCenter{
    static KeyboardNotificationCenter * center = nil;
    @synchronized (self) {
        if (center == nil) {
            center = [[KeyboardNotificationCenter alloc] init];
            
            [[NSNotificationCenter defaultCenter] addObserver:center selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
            [[NSNotificationCenter defaultCenter] addObserver:center selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        }
    }
    
    return center;
}

- (void)setDelegate:(id<KeyboardNotificationCenterDelegate>)delegate{

    if ([[delegate class] isSubclassOfClass:[UIViewController class]]) {
        // 在代理对象更改前，将现有代理对象中弹出的键盘收回
        [[(UIViewController *)_delegate view] endEditing:YES];
    }else{
        NSAssert(NO, @"请将当前响应控件所在的ViewController作为代理参数传入");
    }
    
    _delegate = delegate;
}

- (void)keyboardWillShow:(NSNotification *)notification {
    
    // 获取通知的信息字典
    NSDictionary *userInfo = [notification userInfo];
    
    // 获取键盘弹出后的rect
    NSValue* aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    
    // 获取键盘弹出动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    
    // 检查代理是否为空
    if ([self isBlanceObject:self.delegate]) {
        return;
    }
    
    // 调用代理
    if ([self.delegate respondsToSelector:@selector(showOrHiddenKeyboardWithHeight:withDuration:isShow:)]) {
        [self.delegate showOrHiddenKeyboardWithHeight:keyboardRect.size.height withDuration:animationDuration isShow:YES];
    }
}


- (void)keyboardWillHide:(NSNotification *)notification {
    
    // 获取通知信息字典
    NSDictionary* userInfo = [notification userInfo];
    
    // 获取键盘隐藏动画时间
    NSValue *animationDurationValue = [userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey];
    NSTimeInterval animationDuration;
    [animationDurationValue getValue:&animationDuration];
    
    
    // 检查代理是否为空
    if ([self isBlanceObject:self.delegate]) {
        return;
    }
    
    // 调用代理
    if ([self.delegate respondsToSelector:@selector(showOrHiddenKeyboardWithHeight:withDuration:isShow:)]) {
        [self.delegate showOrHiddenKeyboardWithHeight:0.0 withDuration:animationDuration isShow:NO];
    }
    
}


// 判断对象是否为空
- (BOOL)isBlanceObject:(id)object{
    if (object == nil || object == NULL) {
        return YES;
    }
    if ([object isKindOfClass:[NSNull class]]) {
        return YES;
    }
    return NO;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
