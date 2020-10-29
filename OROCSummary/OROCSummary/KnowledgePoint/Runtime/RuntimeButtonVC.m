//
//  RuntimeButtonVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/8.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "RuntimeButtonVC.h"
#import "UIButton+touch.h"

@interface RuntimeButtonVC ()

@end

@implementation RuntimeButtonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self fixUIButtonClickIssue];
}

#pragma mark - 使用Runtime解决UIButton重复点击问题
- (void)fixUIButtonClickIssue {
    NSLog(@"%s", __func__);
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 300, self.view.frame.size.width, 50)];
    [btn setTitle:@"Button Multi Click Issue" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
    btn.layer.borderColor = [UIColor redColor].CGColor;
    btn.layer.borderWidth = 2.0f;
    btn.timeInterval = 5;
    [btn addTarget:self action:@selector(btnClickedOperations) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}


- (void)btnClickedOperations {
    self.view.backgroundColor = [UIColor colorWithRed:((arc4random() % 255) / 255.0)
                                                green:((arc4random() % 255) / 255.0)
                                                 blue:((arc4random() % 255) / 255.0)
                                                alpha:1.0f];
    NSLog(@"btnClickedOperations---");
}


@end
