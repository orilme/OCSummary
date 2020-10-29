//
//  NavigationThreeVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NavigationThreeVC.h"

@interface NavigationThreeVC ()

@end

@implementation NavigationThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.bounds = CGRectMake(0, 0, 80, 30);
    imageView.image = [UIImage imageNamed:@"zhongguo"];
    self.navigationItem.titleView = imageView;
}

- (IBAction)backPreviousVc:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backFirstVc:(id)sender {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)dealloc{
    NSLog(@"%s",__func__);
}

@end
