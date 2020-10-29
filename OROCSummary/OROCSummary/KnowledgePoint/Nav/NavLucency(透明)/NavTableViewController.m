//
//  NavTableViewController.m
//  ORIOSSummary
//
//  Created by orilme on 2020/2/25.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "NavTableViewController.h"
#import "GradientTableViewController.h"
#import "TranslateTableViewController.h"
#import "MutationTableViewController.h"

static NSString *const menuCellIdentifer = @"menuCellIdentifer";

@interface NavTableViewController ()
@property (nonatomic, strong) NSArray *titles;
@property (nonatomic, strong) NSArray *viewControllers;
@end

@implementation NavTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Menu";
    _titles = @[@"全透明导航栏",
                @"渐变导航栏",
                @"突变导航栏"];
    _viewControllers = @[[TranslateTableViewController class],
                         [GradientTableViewController class],
                         [MutationTableViewController class]];
    
    [self.tableView registerClass:[UITableViewCell class]
           forCellReuseIdentifier:menuCellIdentifer];
    
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _titles.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:menuCellIdentifer
                                                            forIndexPath:indexPath];
    cell.textLabel.text = _titles[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.navigationController pushViewController:[_viewControllers[indexPath.row] new] animated:YES];
}

@end
