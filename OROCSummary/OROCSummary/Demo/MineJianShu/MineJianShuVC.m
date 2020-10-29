//
//  MineJianShuVC.m
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MineJianShuVC.h"
#import "MCCustomBar.h"
#import "DynamicView.h"
#import "ArticleView.h"
#import "MoreView.h"
#import "UIView_extra.h"
#import "ToolMothod.h"

#define ItemTintColor RGBA(227, 116, 98, 1)
#define ItemNorTintColor RGBA(160, 160, 160, 1)

const CGFloat headW = 70;
const CGFloat navH = 64;
const CGFloat sectionBarH = 46;

@interface MineJianShuVC()<UIScrollViewDelegate,UITableViewDelegate>

@property (nonatomic, strong) UIView *headerView;
@property (nonatomic, strong) UIView *sectionView;
@property (nonatomic, strong) UIImageView *userHead;
@property (nonatomic, weak)UIScrollView *tableScrollView; //tableView滑动

@property (nonatomic, strong) DynamicView *dynamicView;
@property (nonatomic, strong) ArticleView *articleView;
@property (nonatomic, strong) MoreView *moreView;

@end

@implementation MineJianShuVC
{
    MCCustomBar *_dynamicBar;    //动态
    MCCustomBar *_articleBar; //文章
    MCCustomBar *_moreBar;     //更多
    
    UIView *_bottomLine;
    UIView *_movingLine;
    NSInteger _index;
    CGFloat _tableViewH;
    CGFloat _lastOffset;
    CGFloat _yOffset;
    CGFloat _changW;
    CGFloat _changY;
    UIImage *_headImage;
    BOOL _isUp;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent = NO;
    self.title = @"";
    
    [self createTableScrollView];
    
    [self createHeaderView];
    
    [self createUserHead];
}

#pragma mark 创建上方头视图
-(void)createHeaderView{
    CGFloat margin = 80;
    CGFloat labelW = Screen_Width - 2*margin;
    
    _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 246)];
    _headerView.backgroundColor = RGBA(252, 252, 252, 1);
    _yOffset = _headerView.centerY;
    //昵称
    UILabel *userNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, 50, labelW, 30)];
    userNameLabel.textAlignment = NSTextAlignmentCenter;
    userNameLabel.font = BOLDSYSTEMFONT(18);
    userNameLabel.text = @"昵称";
    [_headerView addSubview:userNameLabel];
    
    //简介描述
    UILabel *describeLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(userNameLabel.frame)+2, labelW, 24)];
    describeLabel.textAlignment = NSTextAlignmentCenter;
    describeLabel.font = BOLDSYSTEMFONT(13);
    [describeLabel setTextColor:[UIColor lightGrayColor]];
    describeLabel.text = @"iOS程序员";
    [_headerView addSubview:describeLabel];
    
    //详细
    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(margin, CGRectGetMaxY(describeLabel.frame)+2, labelW, 24)];
    detailLabel.textAlignment = NSTextAlignmentCenter;
    detailLabel.font = BOLDSYSTEMFONT(13);
    [detailLabel setTextColor:[UIColor lightGrayColor]];
    detailLabel.text = @"写了0字，获得0个喜欢";
    [_headerView addSubview:detailLabel];
    
    //编辑按钮
    CGFloat btnW = 96;
    CGFloat btnH = 32;
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.bounds = CGRectMake(0, 0, btnW, btnH);
    editBtn.center = CGPointMake(self.view.center.x, CGRectGetMaxY(detailLabel.frame)+26);
    editBtn.layer.cornerRadius = 4;
    editBtn.layer.borderWidth = 0.8;
    editBtn.layer.borderColor = RGBA(64, 189, 38, 1).CGColor;
    [editBtn setTitleColor:RGBA(64, 189, 38, 1) forState:UIControlStateNormal];
    editBtn.titleLabel.font = BOLDSYSTEMFONT(13);
    [editBtn setTitle:@"编辑个人资料" forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [_headerView addSubview:editBtn];
    
    [self createSectionView];
    
    [self.view addSubview:_headerView];
  
}

#pragma mark 创建下方tableview
-(void)createTableScrollView{
    CGFloat tableScrollX = 0;
    CGFloat tableScrollY = 0;
    CGFloat tableScrollWidth = Screen_Width;
    CGFloat tableScrollHeight = Screen_Height - navH;
    
    UIScrollView *tableScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(tableScrollX, tableScrollY, tableScrollWidth, tableScrollHeight)];
    tableScrollView.delegate = self;
    tableScrollView.contentSize = CGSizeMake(3*Screen_Width, tableScrollHeight);
    tableScrollView.pagingEnabled = YES;
    tableScrollView.alwaysBounceVertical = NO;
    tableScrollView.bounces = NO;
    _tableScrollView = tableScrollView;
    
    //动态
    _dynamicView = [[DynamicView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, tableScrollHeight)];
    _dynamicView.tableview.tag = 100;
    _dynamicView.tableview.delegate = self;
    [self createTableHeadView:_dynamicView.tableview];
    [_tableScrollView addSubview:_dynamicView];
    
    //文章tableView
    _articleView = [[ArticleView alloc] initWithFrame:CGRectMake(Screen_Width, 0, Screen_Width,tableScrollHeight)];
    _articleView.tableview.tag = 101;
    _articleView.tableview.delegate = self;
    [self createTableHeadView:_articleView.tableview];
    [_tableScrollView addSubview:_articleView];
    
    //更多tableView
    _moreView = [[MoreView alloc] initWithFrame:CGRectMake(Screen_Width*2, 0, Screen_Width, tableScrollHeight)];
    _moreView.tableview.tag = 102;
    _moreView.tableview.delegate = self;
    [self createTableHeadView:_moreView.tableview];
    [_tableScrollView addSubview:_moreView];
    
    [self.view addSubview:_tableScrollView];

}

-(void)createTableHeadView:(UITableView *)tableView{
    
    UIView *tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, Screen_Width, 246)];
    tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.showsVerticalScrollIndicator = NO;
    tableView.tableHeaderView = tableHeaderView;
    tableView.backgroundColor = RGBA(252, 252, 252, 1);
}


-(void)editBtnClick:(UIButton *)btn{

    [_dynamicView.tableview reloadData];
}

#pragma mark 创建段头
-(void)createSectionView{
    _sectionView = [[UIView alloc] initWithFrame:CGRectMake(0, 200, Screen_Width, sectionBarH)];
    _sectionView.backgroundColor = [UIColor whiteColor];
    
    //划线
    UIView *topLine = [ToolMothod createLineWithWidth:Screen_Width andHeight:1 andColor:RGBA(234, 234, 234, 1.0)];
    [topLine setOrigin:CGPointMake(0,0)];
    [_sectionView addSubview:topLine];
    
    CGFloat ControlBarWidth = VIEW_WEDTH/3;
    CGFloat ControlBarheight = 30;
    CGFloat ControlBarY =  CGRectGetMaxY(topLine.frame) + 7;
    CGSize barSize = CGSizeMake(ControlBarWidth, ControlBarheight);
    
    //动态bar
    _dynamicBar = [[MCCustomBar alloc]initWithCount:@"0" andName:@"动态" size:barSize];
    [_dynamicBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _dynamicBar.tag = 0;
    _dynamicBar.nameLabel.textColor = ItemTintColor;
    [_dynamicBar setOrigin:CGPointMake(0, ControlBarY)];
    [_sectionView addSubview:_dynamicBar];
    //文章bar
    _articleBar = [[MCCustomBar alloc]initWithCount:@"0" andName:@"文章" size:barSize];
    [_articleBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _articleBar.tag = 1;
    [_articleBar setOrigin:CGPointMake(ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:_articleBar];
    //更多bar
    _moreBar = [[MCCustomBar alloc]initWithCount:@"0" andName:@"更多" size:barSize];
    [_moreBar addTarget:self action:@selector(changeView:) forControlEvents:UIControlEventTouchUpInside];
    _moreBar.tag = 2;
    [_moreBar setOrigin:CGPointMake(2*ControlBarWidth, ControlBarY)];
    [_sectionView addSubview:_moreBar];
    
    //划线
    _bottomLine = [ToolMothod createLineWithWidth:Screen_Width andHeight:1 andColor:RGBA(234, 234, 234, 1.0)];
    [_bottomLine setOrigin:CGPointMake(0, CGRectGetMaxY(_dynamicBar.frame) + 8)];
    [_sectionView addSubview:_bottomLine];
    
    //创建移动下划线
    _movingLine = [ToolMothod createLineWithWidth:35 andHeight:2 andColor:ItemTintColor];
    _movingLine.center = CGPointMake(_dynamicBar.centerX, 0);
    [_bottomLine addSubview:_movingLine];

    [_headerView addSubview:_sectionView];
}

- (void)changeView :(MCCustomBar *)sender{
    
    _index = sender.tag;
    [self moveLine:_index];
    
    if ([_dynamicBar isEqual:sender]) {
        
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(0, 0) animated:NO];
        _dynamicBar.nameLabel.textColor = ItemTintColor;
        _articleBar.selected = NO;
        _moreBar.selected = NO;
        
    }else if ([_articleBar isEqual:sender]){
        
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(Screen_Width, 0) animated:NO];
        _articleBar.nameLabel.textColor = ItemTintColor;
        _dynamicBar.selected = NO;
        _moreBar.selected = NO;
        
    }else if ([_moreBar isEqual:sender]){
        
        [self changeItemTintColor:(MCCustomBar *)sender];
        [_tableScrollView setContentOffset:CGPointMake(Screen_Width*2, 0) animated:NO];
        _moreBar.nameLabel.textColor = ItemTintColor;
        _dynamicBar.selected = NO;
        _articleBar.selected = NO;
    }
}

#pragma mark 创建头像，
-(void)createUserHead{

    CGFloat centerX = self.view.centerX;
    _userHead = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"aimage2"]];
    _userHead.layer.cornerRadius = 35;
    _userHead.layer.masksToBounds = YES;
    _userHead.size = CGSizeMake(headW, headW);
    _userHead.origin = CGPointMake(centerX - 35, 9);
    [self.navigationController.navigationBar addSubview:_userHead];
}

-(void)moveLine:(NSInteger)sender
{
    CGFloat lineX;
    if (sender == 0) {
        lineX = _dynamicBar.centerX;
    }else if (sender == 1){
        lineX = _articleBar.centerX;
    }else{
        lineX = _moreBar.centerX;
    }
    [UIView animateWithDuration:0.2 animations:^{
        
        _movingLine.center = CGPointMake(lineX, 0);
    }];
}

-(void)changeItemTintColor:(MCCustomBar *)sender
{
    if (![_dynamicBar isEqual:sender]) {
        
        _dynamicBar.nameLabel.textColor = ItemNorTintColor;
        
    }
    if (![_articleBar isEqual:sender]){
        
        _articleBar.nameLabel.textColor = ItemNorTintColor;
    }
    if (![_moreBar isEqual:sender]){
        
        _moreBar.nameLabel.textColor = ItemNorTintColor;
    }
}

#pragma mark scrollView
#warning 不知道为什么滑动的时候，慢的时候头像缩放还OK，但快的时候，就出现问题。。。
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([scrollView isEqual:_tableScrollView]) {
        _index = _tableScrollView.bounds.origin.x/_tableScrollView.bounds.size.width;
        [self moveLine:_index];
        return;
    }
    
    
    CGFloat offsetY = scrollView.contentOffset.y;
    NSLog(@"************* %f",offsetY);
    
    CGFloat scale = 1.0;
    // 放大
    if (offsetY < 0) {

    } else if (offsetY > 0) { // 缩小
        // 允许向上超过导航条缩小的最大距离为200
        // 为了防止缩小过度，给一个最小值为0.45，其中0.45 = 31.5 / 70.0，表示
        // 头像最小是31.5像素
        scale = MAX(0.45, 1 - offsetY / 200);
        
        _userHead.transform = CGAffineTransformMakeScale(scale, scale);
        
        // 保证缩放后y坐标不变
        CGRect frame = _userHead.frame;
        frame.origin.y = 5;
        _userHead.frame = frame;
    }
    
    
    if (scrollView.contentOffset.y > 200) {
        _headerView.center = CGPointMake(_headerView.center.x, _yOffset - 200);
        return;
    }
    CGFloat h = _yOffset - offsetY;
    _headerView.center = CGPointMake(_headerView.center.x, h);

}


-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:_tableScrollView]) {
        
        if (_index == 0) {
            [self changeView:_dynamicBar];
        }else if (_index == 1){
            [self changeView:_articleBar];
        }else if (_index == 2){
            [self changeView:_moreBar];
        }
        
        return;
    }
    
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if ([scrollView isEqual:_tableScrollView]) {
        return;
    }
    [self setTableViewContentOffsetWithTag:scrollView.tag contentOffset:scrollView.contentOffset.y];
}

//设置tableView的偏移量
-(void)setTableViewContentOffsetWithTag:(NSInteger)tag contentOffset:(CGFloat)offset{
    
    CGFloat tableViewOffset = offset;
    if(offset > 200){
        
        tableViewOffset = 200;
    }
    if (tag == 100) {
        [_articleView.tableview setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView.tableview setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else if(tag == 101){
        
        [_dynamicView.tableview setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_moreView.tableview setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }else{
        
        [_dynamicView.tableview setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
        [_articleView.tableview setContentOffset:CGPointMake(0, tableViewOffset) animated:NO];
    }
}



@end










