//
//  ResponderChainVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/9.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ResponderChainVC.h"
#import "UIResponder+Router.h"
#import "NSObject+PerformSelector.h"
#import "MJRefresh.h"
#import "TestTableViewCell.h"

@interface ResponderChainVC ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tvDemo;
@property (strong, nonatomic) NSArray <NSDictionary *> *data;
@end

@implementation ResponderChainVC

- (NSArray<NSDictionary *> *)data {
    if (!_data) {
        NSMutableArray *mArr = [NSMutableArray array];
        for (int i = 0; i < 10; i++) {
            NSMutableDictionary *mDict = [NSMutableDictionary dictionary];
            [mDict setValue:[NSString stringWithFormat:@"cell - %d",i] forKey:@"test"];
            [mDict setValue:@[@"绿色按钮1",@"绿色按钮2",@"绿色按钮3"] forKey:@"arr"];
            [mArr addObject:mDict];
        }
        _data = [mArr copy];
    }
    return _data;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.tvDemo.rowHeight = UITableViewAutomaticDimension;
    self.tvDemo.estimatedRowHeight = 99.0f;
    self.tvDemo.delegate = self;
    self.tvDemo.dataSource = self;
    
    [self.tvDemo registerNib:[UINib nibWithNibName:TestTableViewCellIdentifier bundle:nil] forCellReuseIdentifier:TestTableViewCellIdentifier];
    
    
    __weak typeof(self) weakSelf = self;
    self.tvDemo.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        __strong typeof(weakSelf) strongSelf = weakSelf;
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [strongSelf.tvDemo.mj_header endRefreshing];
        });
    }];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:TestTableViewCellIdentifier forIndexPath:indexPath];
    cell.dict = self.data[indexPath.row];
    return cell;
}

#pragma 按钮事件回调

- (void)routerEventWithSelectorName:(NSString *)selectorName
                     object:(id)object
                   userInfo:(NSDictionary *)userInfo {
        
    SEL action = NSSelectorFromString(selectorName);
    
    NSMutableArray *arr = [NSMutableArray array];
    if(object) {[arr addObject:object];};
    if(userInfo) {[arr addObject:userInfo];};
    
    [self performSelector:action withObjects:arr];

}


- (void)btnClick1:(UIButton *)btn userInfo:(NSDictionary *)userInfo {
    NSLog(@"btnClick1---%@  %@  %@", btn.titleLabel.text, userInfo[@"test"], userInfo[@"key"]);
}

- (void)btnClick2:(UIButton *)btn userInfo:(NSDictionary *)userInfo {
    NSLog(@"btnClick2---%@  %@  %@", btn.titleLabel.text, userInfo[@"test"], userInfo[@"key"]);
    [self.tvDemo.mj_header beginRefreshing];
}

- (void)cell:(UITableViewCell *)cell userInfo:(NSDictionary *)userInfo {
    
    NSIndexPath *path = userInfo[@"key"];
    
    
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:[NSString stringWithFormat:@"点击了 cell 第 %@ 行",@(path.row)] preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertVC addAction:action];
    
    [self presentViewController:alertVC animated:YES completion:nil];
    
}

@end
