//
//  CityListOneVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/10.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CityListOneVC.h"
#import "CityListViewController.h"

@interface CityListOneVC ()<CityListViewDelegate>
@property (nonatomic, strong) IBOutlet UIButton *button;
@end

@implementation CityListOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor  =[UIColor whiteColor];
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setFrame:CGRectMake(10, 100, 300, 40)];
    [self.button setTitle:@"选择城市" forState:UIControlStateNormal];
    [self.button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.button addTarget:self action:@selector(selectCityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
}

- (void)selectCityAction {
    CityListViewController *cityListView = [[CityListViewController alloc]init];
    cityListView.delegate = self;
    //热门城市列表
    cityListView.arrayHotCity = [NSMutableArray arrayWithObjects:@"广州",@"北京",@"天津",@"厦门",@"重庆",@"福州",@"泉州",@"济南",@"深圳",@"长沙",@"无锡", nil];
    //历史选择城市列表
    cityListView.arrayHistoricalCity = [NSMutableArray arrayWithObjects:@"福州",@"厦门",@"泉州", nil];
    //定位城市列表
    cityListView.arrayLocatingCity   = [NSMutableArray arrayWithObjects:@"福州", nil];
    
    [self presentViewController:cityListView animated:YES completion:nil];
    
}

- (void)didClickedWithCityName:(NSString*)cityName {
    [_button setTitle:cityName forState:UIControlStateNormal];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
