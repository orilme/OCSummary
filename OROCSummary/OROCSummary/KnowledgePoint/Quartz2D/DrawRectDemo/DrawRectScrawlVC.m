//
//  DrawRectScrawlVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/6.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "DrawRectScrawlVC.h"
#import "CZPaintView.h"
#import "CZMorePaintView.h"

@interface DrawRectScrawlVC ()

@end

@implementation DrawRectScrawlVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CZPaintView *paintView1 = [[CZPaintView alloc] initWithFrame:CGRectMake(0, 100, 400, 300)];
    paintView1.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:paintView1];
    
    CZMorePaintView *paintView2 = [[CZMorePaintView alloc] initWithFrame:CGRectMake(0, 420, 400, 300)];
    paintView2.backgroundColor = [UIColor greenColor];
    [self.view addSubview:paintView2];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    //禁用屏幕左滑返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //开启
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

@end
