//
//  CarouselOneVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CarouselOneVC.h"
#import "CollectionImageView.h" // demo1
#define ScreenSize      [UIScreen mainScreen].bounds.size // demo1

#import "ScrollImageView.h" // demo2
@interface CarouselOneVC ()<UIScrollViewDelegate>// demo2
@property (nonatomic, strong)ScrollImageView *scrollImageView;// demo2
@end

@implementation CarouselOneVC
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor greenColor];
    
    // demo1
    NSArray *images = @[@"icon_1",@"icon_2",@"icon_3",@"icon_4",@"icon_5"];
    CollectionImageView *view = [[CollectionImageView alloc]initWithFrame:CGRectMake(0, 100, ScreenSize.width, 250) imageArray:images selectImageBlock:^(NSInteger index) {
        NSLog(@"点击的是第%ld个", (long)index);
    }];
    [self.view addSubview:view];
    self.navigationItem.title = @"Collection实现轮播图";
    
    // demo2
    [self.view addSubview:self.scrollImageView];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.scrollImageView stopScroll];
}

// demo2
- (ScrollImageView *)scrollImageView {
    if (!_scrollImageView) {
        // 定义好宽高即可，这里用的屏幕宽高
        _scrollImageView = [[ScrollImageView alloc] initWithFrame:CGRectMake(0, 370, ScrollWidth, ScrollHeight)];
    }
    return _scrollImageView;
}

@end
