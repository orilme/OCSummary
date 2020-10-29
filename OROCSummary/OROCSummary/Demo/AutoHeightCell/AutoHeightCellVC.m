//
//  AutoHeightCellVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/1.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "AutoHeightCellVC.h"
#import "MitchellModel.h"
#import "ModelGroup.h"
#import "MitchellCell.h"
static NSString*IDD = @"AA";

@interface AutoHeightCellVC ()<UITableViewDataSource,UITableViewDelegate>
/**
 *  数据源
 */
@property(nonatomic,strong)NSMutableArray * dataArray;
/**
 *  数据源对应cell高度
 */
@property(nonatomic,strong)NSMutableArray * frameArray;
/**
 *  tableView
 */
@property(nonatomic,weak)UITableView * tab;
@end


@implementation AutoHeightCellVC

#pragma mark ------------------ 获取数据源（模型数据源、模型高度数据源） ------------------
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [ModelGroup groupWithNameOfContent:@"statuses.plist"];
        _frameArray = [MitchellFrameModel frameModelWithArray:_dataArray];
    }
    return _dataArray;
}
#pragma mark ------------------ viewDidLoad ------------------

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpTabelView];
}
#pragma mark ------------------ 创建tableView ------------------
-(void)setUpTabelView{
    UITableView*vi = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    vi.delegate = self;
    vi.dataSource = self;
    [self.view addSubview:vi];
    [vi registerClass:[MitchellCell class] forCellReuseIdentifier:IDD];
    self.tab = vi;
}


#pragma mark ------------------ tableViewDelegate ------------------

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MitchellCell*cell = [tableView dequeueReusableCellWithIdentifier:IDD ];
    cell.model = [_dataArray objectAtIndex:indexPath.row];
    cell.frameModel = [_frameArray objectAtIndex:indexPath.row];
    return cell;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    MitchellFrameModel*mo = [_frameArray objectAtIndex:indexPath.row];
    return mo.cellHeight;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

