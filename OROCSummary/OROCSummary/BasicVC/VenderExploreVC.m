//
//  VenderExploreVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/12.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "VenderExploreVC.h"

@interface VenderExploreVC ()
@property (nonatomic, copy) NSArray *meunArr;
@end

@implementation VenderExploreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.navigationItem.title = @"学习分析三方库~~";
    self.meunArr = @[
    @{@"menuName": @"SDWebImage探索", @"className": @"SDWebImageVC"},
    @{@"menuName": @"模拟SDWebImage", @"className": @"SDWebImageSimulateVC"},
    ];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.meunArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =  self.meunArr[indexPath.row][@"menuName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.meunArr[indexPath.row];
    UIViewController *vc = [[NSClassFromString(dict[@"className"]) alloc]init];
    vc.title = dict[@"menuName"];
    [self.navigationController pushViewController:vc animated:YES];
}

@end

