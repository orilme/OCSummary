//
//  CodeOrPassWordTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/7.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CodeOrPassWordTwoVC.h"
#import "CodeOrPwdTwoDemoVC.h"

@interface CodeOrPassWordTwoVC ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *titleArrayM;
@end

@implementation CodeOrPassWordTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    _titleArrayM = [NSMutableArray arrayWithArray:@[@"每个完整方格样式", @"外围整体方格样式", @"带间距的方框样式"]];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = _titleArrayM[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CodeOrPwdTwoDemoVC *testVC = [[CodeOrPwdTwoDemoVC alloc] init];
    testVC.title = _titleArrayM[indexPath.row];
    testVC.type = indexPath.row;
    [self.navigationController pushViewController:testVC animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
