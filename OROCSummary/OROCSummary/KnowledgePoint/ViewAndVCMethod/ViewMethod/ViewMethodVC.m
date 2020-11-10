//
//  ViewMethodVC.m
//  OROCSummary
//
//  Created by orilme on 2020/11/9.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "ViewMethodVC.h"

@interface ViewMethodVC ()

@property (weak, nonatomic) IBOutlet UIImageView *testImgView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftContrain;

@property (weak, nonatomic) IBOutlet UIView *aView;
@property (weak, nonatomic) IBOutlet UIView *bView;

@end

@implementation ViewMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self convertRectTest];
}

// 转换像素点
// 将像素point由point所在视图转换到目标视图view中，返回在目标视图view中的像素值
// - (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
// 将像素point从view中转换到当前视图中，返回在当前视图中的像素值
// - (CGPoint)convertPoint:(CGPoint)point fromView:(UIView *)view;

// 转换Rect
// 将rect由rect所在视图转换到目标视图view中，返回在目标视图view中的rect
// - (CGRect)convertRect:(CGRect)rect toView:(UIView *)view;
// 将rect从view中转换到当前视图中，返回在当前视图中的rect
// - (CGRect)convertRect:(CGRect)rect fromView:(UIView *)view;

- (void)convertRectTest {
    NSLog(@"1---%f，%f，%f，%f", self.aView.frame.origin.x, self.aView.frame.origin.y, self.aView.frame.size.width, self.aView.frame.size.height);
    NSLog(@"2---%f，%f，%f，%f", self.bView.frame.origin.x, self.bView.frame.origin.y, self.bView.frame.size.width, self.bView.frame.size.height);
    
    NSLog(@"3---%f，%f", self.bView.center.x, self.bView.center.y);
    CGPoint point1 = [self.bView convertPoint:self.bView.center toView:self.view];
    CGPoint point2 = [self.aView convertPoint:self.bView.center fromView:self.bView];
    NSLog(@"4---%f，%f", point1.x, point1.y);
    NSLog(@"5---%f，%f", point2.x, point2.y);
    
    CGRect rect = [self.bView convertRect:self.bView.frame toView:self.view];
    CGRect rect2 = [self.aView convertRect:self.bView.frame fromView:self.bView];
    NSLog(@"6---%f，%f，%f，%f", rect.origin.x, rect.origin.y, rect.size.width, rect.size.height);
    NSLog(@"7---%f，%f，%f，%f", rect2.origin.x, rect2.origin.y, rect2.size.width, rect2.size.height);
}

- (IBAction)btnCLick:(id)sender {
    if (self.leftContrain.constant == 100) {
        self.leftContrain.constant = 30;
    }else {
        self.leftContrain.constant = 100;
    }
    
//    if (self.leftContrain.constant == 100) {
//        [UIView animateWithDuration:0.5 animations:^{
//            [self.view layoutIfNeeded];
//        } completion:nil];
//    }else {
//        [UIView animateWithDuration:0.5 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.5 options:UIViewAnimationOptionAllowAnimatedContent animations:^{
//            [self.view layoutIfNeeded];
//        } completion:nil];
//    }
}

@end
