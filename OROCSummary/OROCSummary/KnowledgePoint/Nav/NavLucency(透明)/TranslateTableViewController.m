//
//  TranslateTableViewController.m
//  ORIOSSummary
//
//  Created by orilme on 2020/2/25.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "TranslateTableViewController.h"

#define SCREEN_RECT [UIScreen mainScreen].bounds
static NSString *const kMXCellIdentifer = @"kMXCellIdentifer";
static const CGFloat headerImageHeight = 260.0f;

@interface TranslateTableViewController ()

@end

@implementation TranslateTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置导航栏背景图片为一个空的image，这样就透明了
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    //去掉透明后导航栏下边的黑边
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    //    如果不想让其他页面的导航栏变为透明 需要重置
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initBaseData];
}

- (void)initBaseData {
    self.title = @"导航栏全透明";
    
    if (@available(iOS 11.0, *)) {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        // 用下面这句返回值后会上移
        //[[UIScrollView appearance] setContentInsetAdjustmentBehavior:UIScrollViewContentInsetAdjustmentNever];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:kMXCellIdentifer];
    self.tableView.showsVerticalScrollIndicator = NO;
    
    UIImageView *headerImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,
                                                                                 0,
                                                                                 CGRectGetWidth(SCREEN_RECT), headerImageHeight)];
    headerImageView.image = [UIImage imageNamed:@"aimage"];
    self.tableView.tableHeaderView = headerImageView;
    
    UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_map_locate"]  style:UIBarButtonItemStylePlain target:self action:@selector(pushToBackView)];
    
    self.navigationItem.rightBarButtonItem = barButtonItem;
}

- (void)pushToBackView {
    
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kMXCellIdentifer forIndexPath:indexPath];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    
    return cell;
}

@end
