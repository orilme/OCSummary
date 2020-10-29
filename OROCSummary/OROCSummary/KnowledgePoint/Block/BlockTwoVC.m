//
//  BlockTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/6.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "BlockTwoVC.h"

@interface BlockTwoVC ()

@end

@implementation BlockTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, Screen_Width - 40, 80)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}

- (void)onBtnClick {
    if (self.certainBlock) {//判断有没有指定block
        self.certainBlock(@"悟空", @"7399393939");//调用block反向传值
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
