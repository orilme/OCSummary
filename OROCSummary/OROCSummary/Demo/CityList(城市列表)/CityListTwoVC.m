//
//  CityListTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/10.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CityListTwoVC.h"
#import "GYZChooseCityController.h"

@interface CityListTwoVC ()<GYZChooseCityDelegate>{
     UIButton *chooseCityBtn;
}

@end

@implementation CityListTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor  =[UIColor whiteColor];
    chooseCityBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 100, 100)];
    chooseCityBtn.center = self.view.center;
    [chooseCityBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [chooseCityBtn setTitle:@"选择城市" forState:UIControlStateNormal];
    [chooseCityBtn addTarget:self action:@selector(onClickChooseCity:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:chooseCityBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)onClickChooseCity:(id)sender {
    
    GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
    [cityPickerVC setDelegate:self];
    cityPickerVC.modalPresentationStyle = UIModalPresentationFullScreen;
    //    cityPickerVC.locationCityID = @"1400010000";
    //    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
    //    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
        
    }];
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
    [chooseCityBtn setTitle:city.cityName forState:UIControlStateNormal];
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
    [chooseCityController dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
