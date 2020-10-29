//
//  GradientProgressVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/7.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "GradientProgressVC.h"
#import "LXGradientProcessView.h"

@interface GradientProgressVC ()

@property (nonatomic, strong) LXGradientProcessView *processView;
@property (nonatomic, strong) CALayer *colorLayer;

@end

@implementation GradientProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.colorLayer = [CALayer layer];
    [self.colorLayer setFrame:self.view.frame];
    [self.colorLayer setBackgroundColor:[UIColor purpleColor].CGColor];
//    [self.view.layer addSublayer:self.colorLayer];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTapClick)];
    [self.view addGestureRecognizer:tap];
    
    // 渐变进度条
    self.processView = [[LXGradientProcessView alloc] initWithFrame:CGRectMake(20.f, 100.f, Screen_Width - 40.f, 45.f)];
    self.processView.percent = 0;
    [self.view addSubview:self.processView];
    
    UIButton *stareButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [stareButton setFrame:CGRectMake(20.f, 300.f, Screen_Width - 40.f, 38.f)];
    [stareButton addTarget:self action:@selector(onStareButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [stareButton setTitle:@"Stare" forState:UIControlStateNormal];
    stareButton.layer.cornerRadius = 4.f;
    stareButton.layer.borderWidth = 0.5;
    stareButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    [self.view addSubview:stareButton];
}

- (void)onStareButtonClick {
    
    self.processView.percent = 100.f;
}

- (void)onTapClick {
    
    [CATransaction begin];
    [CATransaction setDisableActions:YES];
    [CATransaction setAnimationDuration:2.0];
//    [self.colorLayer setBackgroundColor:[UIColor purpleColor].CGColor];
    [self.view setBackgroundColor:[UIColor purpleColor]];
    [CATransaction commit];
    
//    [self.view.layer setPosition:CGPointMake(100, 100)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

