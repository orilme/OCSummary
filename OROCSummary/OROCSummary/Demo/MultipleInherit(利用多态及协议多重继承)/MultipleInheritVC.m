//
//  MultipleInheritVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/2/29.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "MultipleInheritVC.h"
#import "MyDetialViewController.h"

static NSString *const kUITableViewCellIdentifier = @"UITableViewCell";

@interface MultipleInheritVC ()

/** data list */
@property (strong, nonatomic) NSArray <NSDictionary *> *dataArr;

@end

@implementation MultipleInheritVC

- (NSArray<NSDictionary *> *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@{@"projectTag" : @"A"},
                     @{@"projectTag" : @"B"}];
    }
    return _dataArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:kUITableViewCellIdentifier];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kUITableViewCellIdentifier forIndexPath:indexPath];
    cell.textLabel.text = self.dataArr[indexPath.row][@"projectTag"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    MyDetialViewController *detialVC = [[MyDetialViewController alloc] initWithNibName:@"MyDetialViewController" bundle:nil];
    NSLog(@"%@", self.dataArr);
    detialVC.projectTag = self.dataArr[indexPath.row][@"projectTag"];
    [self.navigationController pushViewController:detialVC animated:YES];
}

@end
