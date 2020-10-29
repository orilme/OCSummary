//
//  Quartz2DVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "Quartz2DVC.h"

@interface Quartz2DVC ()
@property (nonatomic, copy) NSArray *meunVCArr;
@property (nonatomic, copy) NSArray *meunTitleArr;
@end

@implementation Quartz2DVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.meunVCArr = @[@"ORLineViewVC", @"ORShapeViewVC", @"ORHuangViewVC", @"Quartz2DPieVC", @"Quartz2DLockVC"];
    self.meunTitleArr = @[@"Line、图形上下文栈、矩阵操作、UIKit绘图方法", @"ORShapeViewVC", @"ORHuangViewVC", @"饼状图、裁切圆角", @"手势解锁"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.meunVCArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =  self.meunTitleArr[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *vc = [[NSClassFromString(self.meunVCArr[indexPath.row]) alloc]init];
    vc.title = self.meunVCArr[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
