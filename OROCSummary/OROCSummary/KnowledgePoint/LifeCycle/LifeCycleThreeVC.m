//
//  LifeCycleThreeVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/12.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "LifeCycleThreeVC.h"

@interface LifeCycleThreeVC ()
- (IBAction)backOneVc;
@end

@implementation LifeCycleThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"three view加载完成");
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"three  view将显示");
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"three  view完成显示");
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"three  view将消失");
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"three  view已经消失");
}


-(void)dealloc{
    NSLog(@"three 销毁");
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //导航控制器的子控制器
    NSArray *subContrs =  self.navigationController.childViewControllers;
    NSArray *subContrs2 = self.navigationController.viewControllers;
    NSLog(@"%@",subContrs);
    NSLog(@"%@",subContrs2);
}


- (IBAction)backOneVc {
//    [self.navigationController popToRootViewControllerAnimated:YES];
    
    NSArray *subContrs =  self.navigationController.childViewControllers;
    
    UIViewController *oneVc = subContrs[0];
    [self.navigationController popToViewController:oneVc animated:YES];
    
}

//内存警告
-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    //自觉清除一些不必要的内存
    
    // self.images = nil;
    NSLog(@"%s",__func__);
    
    //判断当前的view在不在窗口
    if(self.view.window){//代表当前的view显示在窗口上
    
    }else{//不在窗口上，不在窗口就可释放资源
    
    }
}
@end
