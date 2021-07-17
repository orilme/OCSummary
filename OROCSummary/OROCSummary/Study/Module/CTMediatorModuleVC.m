//
//  CTMediatorModuleVC.m
//  OROCSummary
//
//  Created by orilme on 2020/9/20.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CTMediatorModuleVC.h"
#import <HandyFrame/UIView+LayoutMethods.h>
#import <CTMediator/CTMediator.h>
#import <ORModules/CTMediator+A.h>
#import <ORModules/UIColor+HEX.h>
#import "orilme_oc-Swift.h"

// github 地址： https://github.com/ModulizationDemo/PrivatePods.git

@interface CTMediatorModuleVC ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation CTMediatorModuleVC

#pragma mark - life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self.tableView fill];
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.textLabel.text = self.dataSource[indexPath.row];
    cell.backgroundColor = [UIColor colorWithHex:999999];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        // Objective-C -> Category -> Objective-C
        UIViewController *viewController = [[CTMediator sharedInstance] A_Category_Objc_ViewControllerWithCallback:^(NSString *result) {
            NSLog(@"1----1----%@", result);
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (indexPath.row == 1) {
        // Objective-C -> Category -> Swift
        UIViewController *viewController = [[CTMediator sharedInstance] A_Category_Swift_ViewControllerWithCallback:^(NSString *result) {
            NSLog(@"1----2----%@", result);
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (indexPath.row == 2) {
        // Objective-C -> Extension -> Objective-C
        UIViewController *viewController = [[CTMediator sharedInstance] C_showObjcWithCallback:^(NSString * _Nonnull result) {
            NSLog(@"1----3----%@", result);
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }
    if (indexPath.row == 3) {
        // Objective-C -> Extension -> Swift
        UIViewController *viewController = [[CTMediator sharedInstance] C_showSwiftWithCallback:^(NSString * _Nonnull result) {
            NSLog(@"1----4----%@", result);
        }];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

#pragma mark - getters and setters
- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    return _tableView;
}

- (NSArray *)dataSource {
    if (_dataSource == nil) {
        _dataSource = @[
                        @"Objective-C -> Category -> Objective-C",
                        @"Objective-C -> Category -> Swift",
                        @"Objective-C -> Extension -> Objective-C",
                        @"Objective-C -> Extension -> Swift",
                        ];
    }
    return _dataSource;
}

@end
