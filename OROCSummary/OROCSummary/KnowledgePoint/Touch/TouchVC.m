//
//  TouchVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/6.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "TouchVC.h"
#import "CZView.h"

@interface TouchVC ()

@end

@implementation TouchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CZView *ballonView = [[CZView alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
    ballonView.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:ballonView];
    
}

@end
