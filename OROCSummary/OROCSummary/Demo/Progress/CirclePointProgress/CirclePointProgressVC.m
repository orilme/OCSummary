//
//  CirclePointProgressVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/7.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CirclePointProgressVC.h"
#import "CircularProgressBar.h"

@interface CirclePointProgressVC () {
    CircularProgressBar *bar;
    CircularProgressBar *bar2;
}

@end

@implementation CirclePointProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    CGSize size = self.view.frame.size;
    bar = [[CircularProgressBar alloc]initWithFrame:CGRectMake(0, 100, size.width, size.width)];
    [bar strokeChart];
    [self.view addSubview:bar];
    
    bar2 = [[CircularProgressBar alloc]initWithFrame:CGRectMake(0, 80 + size.width, size.width, size.width)];
    bar2.type = CircularProgressBarTypeRect;
    [bar2 strokeChart];
    [self.view addSubview:bar2];
    
    
    UISlider *sw = [[UISlider alloc]initWithFrame:CGRectMake(size.width/2 - 100, size.height - 60, 200, 50)];
    [self.view addSubview:sw];
    [sw addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventValueChanged];
}

- (void)changeValue:(UISlider *)slider {
    bar.progress = slider.value;
    bar2.progress = slider.value;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
