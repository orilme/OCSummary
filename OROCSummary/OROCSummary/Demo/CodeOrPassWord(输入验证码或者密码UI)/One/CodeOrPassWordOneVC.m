//
//  CodeOrPassWordOneVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/7.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CodeOrPassWordOneVC.h"
#import "MQVerCodeInputView.h"

@interface CodeOrPassWordOneVC ()

@end

@implementation CodeOrPassWordOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor greenColor];
    MQVerCodeInputView *verView = [[MQVerCodeInputView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width-50, 50)];
    verView.maxLenght = 6;//最大长度
    verView.keyBoardType = UIKeyboardTypeNumberPad;
    [verView mq_verCodeViewWithMaxLenght];
    verView.block = ^(NSString *text){
        NSLog(@"text = %@",text);
    };
    verView.center = self.view.center;
    [self.view addSubview:verView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
