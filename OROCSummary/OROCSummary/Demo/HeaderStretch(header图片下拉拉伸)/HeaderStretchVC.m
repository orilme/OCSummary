//
//  HeaderStretchVC.m
//  url:http://www.xiongcaichang.com
//
//  Created by bear on 16/4/12.
//  Copyright © 2016年 bear. All rights reserved.
//

#import "HeaderStretchVC.h"
#import "UIScrollView+ScalableCover.h"


#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

@interface HeaderStretchVC ()


@property (nonatomic, assign) BOOL refreshStatus;


@property (nonatomic, assign) NSInteger dataCount;

@end

@implementation HeaderStretchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _dataCount=5;

    self.tableView.tableHeaderView=[[UITableViewHeaderFooterView alloc]initWithFrame:CGRectMake(0, kNavBarHeight, SCREEN_WIDTH, 200)];


#warning 该行代码添加下拉缩放图
    [self.tableView addScalableCoverWithImage:[UIImage imageNamed:@"aimage"]];
}


//监听滚动
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if ( scrollView.contentOffset.y>-50) {
        [self  loadMore];
        [self.tableView reloadData];
    }
}


//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataCount;
}



//返回cell

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID=@"cellID";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]init];
    }
    cell.textLabel.text=@"1234";

    return cell;
}



//获取刷新数据
-(void)loadMore{

    self.dataCount=10;
}
@end
