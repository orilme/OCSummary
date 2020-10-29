//
//  NormalDemoVC.m
//  GCD
//
//  Created by orilme on 2018/7/28.
//  Copyright © 2018年 orilme. All rights reserved.
//  常用demo

#import "NormalDemoVC.h"

@interface NormalDemoVC ()
@property (nonatomic, copy) NSArray *meunArr;
@end

@implementation NormalDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.navigationItem.title = @"常用demo~~";
    self.meunArr = @[
    // 重要
    @{@"headName": @"重要",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"利用多态及协议多重继承", @"className": @"MultipleInheritVC"},
                  @{@"menuName": @"转盘", @"className": @"WheelVC"},
                  @{@"menuName": @"轮播图", @"className": @"CarouselOneVC"},
                  @{@"menuName": @"左右菜单", @"className": @"LeftRightMenuVC"},
                  @{@"menuName": @"下拉小菜单（一小块）", @"className": @"DropDownMenuVC"},
                  @{@"menuName": @"纯代码自适应高度cell", @"className": @"AutoHeightCellVC"},
                  @{@"menuName": @"自定义相册选图片", @"className": @"CustomPhotoAlbumVC"},
                  @{@"menuName": @"相机拍身份证", @"className": @"TakeIDcardPhotoVC"},
                  @{@"menuName": @"相机拍身份证2", @"className": @"TakeIDcardPhotoTwoVC"},
                  @{@"menuName": @"我的界面-仿简书", @"className": @"MineJianShuVC"},
                  @{@"menuName": @"header图片下拉拉伸", @"className": @"HeaderStretchVC"},
                  @{@"menuName": @"输入验证码或者密码UI", @"className": @"CodeOrPassWordOneVC"},
                  @{@"menuName": @"输入验证码或者密码UI2", @"className": @"CodeOrPassWordTwoVC"},
                  @{@"menuName": @"输入验证码或者密码UI3（弹窗式）", @"className": @"CodeOrPassWordThreeVC"},
                  
                  @{@"menuName": @"TableView、collectionView空数据默认占位图", @"className": @"PlaceholderTableVC"},]}.mutableCopy,
    // 分类使用
    @{@"headName": @"分类使用",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"富文本添加点击", @"className": @"AttributeTapActionVC"}]}.mutableCopy,
    // 音频
    @{@"headName": @"音频",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"音乐播放器（后台播放、锁屏播放）", @"className": @"MusicPlayerVC"},
                  @{@"menuName": @"录音", @"className": @"VoiceRecordVC"},]}.mutableCopy,
    // 弹出视图
    @{@"headName": @"弹出视图",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"弹出视图弹簧动画", @"className": @"AlertAnimationVC"},
                  @{@"menuName": @"弹出视图到导航栏下面位置", @"className": @"AlertTwoVC"},
                  @{@"menuName": @"中间弹窗", @"className": @"AlertThreeVC"},
                  @{@"menuName": @"各种弹窗FFToast", @"className": @"FFToastAlertVC"},]}.mutableCopy,
    // 滑动翻页
    @{@"headName": @"滑动翻页",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"导航栏滑动翻页", @"className": @"NavPageScrollVC"}]}.mutableCopy,
    // 进度条
    @{@"headName": @"进度条",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"圆形进度条", @"className": @"CircleProgressVC"},
                  @{@"menuName": @"横条渐变色进度条", @"className": @"GradientProgressVC"},
                  @{@"menuName": @"圆形远点和条进度条", @"className": @"CirclePointProgressVC"},]}.mutableCopy,
    // 地图
    @{@"headName": @"地图",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"苹果地图-CoreLocationVC", @"className": @"CoreLocationVC"},
                  @{@"menuName": @"苹果地图-MapKit", @"className": @"MKMapViewVC"},
                  @{@"menuName": @"苹果地图-大头针", @"className": @"MKMapAnnotationVC"},
                  @{@"menuName": @"苹果地图-导航", @"className": @"MKMapNavigationVC"},
                  @{@"menuName": @"苹果地图-画线", @"className": @"MKMapDrawLineVC"},]}.mutableCopy,
    // 其他
    @{@"headName": @"其他",
      @"isFold": @"0",
      @"value": @[@{@"menuName": @"城市列表1", @"className": @"CityListOneVC"},
                  @{@"menuName": @"城市列表2", @"className": @"CityListTwoVC"},
                @{@"menuName": @"HttpCache", @"className": @"HttpCacheVC"},]}.mutableCopy,
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.meunArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.meunArr[section][@"value"];
    return [self.meunArr[section][@"isFold"]  isEqual: @"1"] ? 0 : array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =  self.meunArr[indexPath.section][@"value"][indexPath.row][@"menuName"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.meunArr[indexPath.section][@"value"][indexPath.row];
    UIViewController *vc = [[NSClassFromString(dict[@"className"]) alloc]init];
    vc.title = dict[@"menuName"];
    [self.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
    headerView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    headerBtn.frame = CGRectMake(0, 1, Screen_Width, 58);
    headerBtn.tag = section;
    headerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    headerBtn.backgroundColor = UIColor.whiteColor;
    headerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [headerBtn setTitle:self.meunArr[section][@"headName"] forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(onBtnheaderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    return headerView;
}

- (void)onBtnheaderBtnClicked:(UIButton *)sender {
    if ([self.meunArr[sender.tag][@"isFold"]  isEqual: @"1"]) {
        self.meunArr[sender.tag][@"isFold"] = @"0";
    }else {
        self.meunArr[sender.tag][@"isFold"] = @"1";
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sender.tag];//只刷新当前行
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
