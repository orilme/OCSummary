//
//  CircleProgressVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/7.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CircleProgressVC.h"
#import "ZMProgressView.h"

@interface CircleProgressVC ()

/**
 *  通过代码创建的进度视图
 */
@property (nonatomic,strong)ZMProgressView *myProgressView;

/**
 *  storyBorad创建的进度视图
 */
@property (weak, nonatomic) IBOutlet ZMProgressView *otherProgressView;

@end

@implementation CircleProgressVC

- (void)viewDidLoad {
    [super viewDidLoad];

    
    ZMProgressView* progressView = [[ZMProgressView alloc] initWithLineColor:[UIColor orangeColor] loopColor:[UIColor lightGrayColor]];
    
    
    //引用
    self.myProgressView = progressView;
    //设置frame
    progressView.frame = CGRectMake(50, 150, 300, 300);
    
    
    //开启动画（可选,建议在百分比前面设置，否则一开始没有动画）
    progressView.animatable = YES;
    //百分比，超过100，按照100算
    self.myProgressView.percent = 50;
    
    
    //属性可选的，可以不设置，设置透明就是圆环
    progressView.backgroundColor = [UIColor clearColor];
    //设置标题
    self.myProgressView.title = @"本次得分";
    //设置单位
    self.myProgressView.percentUnit = @"分";
    
    [self.view addSubview:self.myProgressView];
    
    
    
}



- (IBAction)random {
    
    self.myProgressView.percent = arc4random_uniform(101);
    
    self.otherProgressView.percent = arc4random_uniform(101);
}


@end

