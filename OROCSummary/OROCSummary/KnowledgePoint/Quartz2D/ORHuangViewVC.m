//
//  ORHuangViewVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/9/8.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORHuangViewVC.h"
#import "ORHuangView.h"

@interface ORHuangViewVC ()

@end

@implementation ORHuangViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ORHuangView *view = [[ORHuangView alloc]initWithFrame:CGRectMake(10, 100, 400, 600)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
}


@end
