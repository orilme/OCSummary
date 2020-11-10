//
//  LifeCycleTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/12.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "LifeCycleTwoVC.h"

@interface LifeCycleTwoVC ()

@end

@implementation LifeCycleTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //状态栏20
    //导航条44
    //设置导航栏中间标题的view
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds = CGRectMake(0, 0, 100, 44);
    imageView.image = [UIImage imageNamed:@"zhongguo"];
    self.navigationItem.titleView = imageView;
    
    NSLog(@"two view加载完成");
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"two view将显示");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"two view完成显示");
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@" twoview将消失");
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"two view已经消失");
}


-(void)dealloc{
    NSLog(@"two 销毁");
}

//内存警告
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //自觉清除一些不必要的内存
    // self.images = nil;
    NSLog(@"%s",__func__);
}

- (IBAction)back {
    //返回上一个控制器
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //导航控制器的子控制器
    NSArray *subContrs =  self.navigationController.childViewControllers;
    NSArray *subContrs2 = self.navigationController.viewControllers;
    NSLog(@"%@",subContrs);
    NSLog(@"%@",subContrs2);
}

@end
