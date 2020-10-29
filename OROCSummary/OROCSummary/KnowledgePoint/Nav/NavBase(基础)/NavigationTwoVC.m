//
//  NavigationTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NavigationTwoVC.h"
#import "NavigationThreeVC.h"

@interface NavigationTwoVC ()

@end

@implementation NavigationTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 46, 31);
    [btn setBackgroundImage:[UIImage imageNamed:@"btn_back_normal"] forState:UIControlStateNormal];
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem = backItem;
}

- (IBAction)backPreviousVc:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)toThirdVc:(id)sender {
    NavigationThreeVC *thirdVc = [[NavigationThreeVC alloc] init];
    [self.navigationController pushViewController:thirdVc animated:YES];
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
