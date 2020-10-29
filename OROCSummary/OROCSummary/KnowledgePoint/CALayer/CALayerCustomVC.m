//
//  CALayerCustomVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/2.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CALayerCustomVC.h"
#import "CustomLayer.h"

@interface CALayerCustomVC ()

@end

@implementation CALayerCustomVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self testPositionAndAnchorPoint];
    [self testCustomeLayer];
}

- (void)testPositionAndAnchorPoint {
    CALayer *layer = [CALayer layer];
    layer.backgroundColor = [UIColor redColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 100, 100);
    layer.opacity = 0.5; // 图层的透明度
    
    // 设置位置
    layer.position = CGPointMake(100, 200);
    // 设置锚点 （默认CGPointMake(0.5, 0.5)）
    layer.anchorPoint = CGPointMake(0.5, 0.5);
    
    // 然后添加到控制器的view的图层
    [self.view.layer addSublayer:layer];
}

- (void)testCustomeLayer {
    //把自定义的图层 添加到 控制器view的图层上
    CustomLayer *layer = [CustomLayer layer];
    layer.backgroundColor = [UIColor greenColor].CGColor;
    layer.bounds = CGRectMake(0, 0, 200, 200);
    layer.position = CGPointMake(100, 400); // 设置位置
    layer.anchorPoint = CGPointMake(-0.5, 0.5);
    // 如果自定义的图层，在drawInContext绘制的东西，如果要显示，必须手动调用一个方法，才能显示
    [layer setNeedsDisplay];
    
    [self.view.layer addSublayer:layer];
}

@end
