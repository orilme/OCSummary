//
//  SimulateTableViewDelegateDatasourceVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/10.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "SimulateTableViewDelegateDatasourceVC.h"
#import "DropDownListView.h"

@interface SimulateTableViewDelegateDatasourceVC (){
    NSMutableArray *chooseArray;
}

@end

@implementation SimulateTableViewDelegateDatasourceVC

- (void)viewDidLoad {
    [super viewDidLoad];
  
    chooseArray = [NSMutableArray arrayWithArray:@[@[@"超清",@"高清",@"标清",@"省流",@"自动"],]];
    
    //这个dropDownView是下拉菜单的点击视图  点击该视图可以显示下拉菜单
    DropDownListView * dropDownView = [[DropDownListView alloc] initWithFrame:CGRectMake(200,200, 60, 20) dataSource:self delegate:self];
    
    
    //因为不清楚显示下拉菜单的frame 但是我们可以借助一个视图将下拉菜单视图加载到我们想要放置的位置的视图上
    UIView *superView = [[UIView alloc] initWithFrame:CGRectMake(200, 0, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:superView];
    self.view.backgroundColor = [UIColor whiteColor];
    //下拉菜单添加到superView的frame上
  
    dropDownView.mSuperView = superView;
  
    [self.view addSubview:dropDownView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -- dropDownListDelegate
//码率切换请求方法
-(void) chooseAtSection:(NSInteger)section index:(NSInteger)index
{
    NSLog(@"童大爷选了section:%d ,index:%d",section,index);
    if (index == 0) {
        NSLog(@"切换超清");
    }
    if (index == 1) {
        NSLog(@"切换高清");
    }
    if (index == 2) {
        NSLog(@"切换标清");
    }
    if (index == 3) {
        NSLog(@"切换省流");
    }
    if (index == 4) {
        NSLog(@"切换自动");
    }
}


#pragma mark -- dropdownList DataSource
-(NSInteger)numberOfSections
{
    return [chooseArray count];
}
-(NSInteger)numberOfRowsInSection:(NSInteger)section
{
    NSArray *arry =chooseArray[section];
    return [arry count];
}
-(NSString *)titleInSection:(NSInteger)section index:(NSInteger) index
{
    return chooseArray[section][index];
}
-(NSInteger)defaultShowSection:(NSInteger)section
{
    return 0;
}

@end
