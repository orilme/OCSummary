//
//  NavPageScrollVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/14.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "NavPageScrollVC.h"
#import "LLSegmentBarVC.h"

@interface NavPageScrollVC ()

@property (nonatomic, weak) LLSegmentBarVC * segmentVC;

@end

@implementation NavPageScrollVC

- (LLSegmentBarVC *)segmentVC {
    if (!_segmentVC) {
        LLSegmentBarVC *vc = [[LLSegmentBarVC alloc]init];
        // 添加到到控制器
        [self addChildViewController:vc];
        _segmentVC = vc;
    }
    return _segmentVC;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1 设置segmentBar的frame
    self.segmentVC.segmentBar.frame = CGRectMake(0, 0, 320, 35);
    self.navigationItem.titleView = self.segmentVC.segmentBar;
    
    // 2 添加控制器的View
    self.segmentVC.view.frame = self.view.bounds;
    [self.view addSubview:self.segmentVC.view];
    
    
    NSArray *items = @[@"item-one", @"item-two", @"item-three",@"item-four"];
    UIViewController *vc1 = [UIViewController new];
    vc1.view.backgroundColor = [UIColor redColor];
    UIViewController *vc2 = [UIViewController new];
    vc2.view.backgroundColor = [UIColor greenColor];
    UIViewController *vc3 = [UIViewController new];
    vc3.view.backgroundColor = [UIColor yellowColor];
    UIViewController *vc4 = [UIViewController new];
    vc4.view.backgroundColor = [UIColor blueColor];
    
    // 3 添加标题数组和控住器数组
    [self.segmentVC setUpWithItems:items childVCs:@[vc1,vc2,vc3,vc4]];
    
    // 4  配置基本设置  可采用链式编程模式进行设置
    [self.segmentVC.segmentBar updateWithConfig:^(LLSegmentBarConfig *config) {
        config.itemNormalColor([UIColor blackColor]).itemSelectColor([UIColor redColor]).indicatorColor([UIColor greenColor]);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

