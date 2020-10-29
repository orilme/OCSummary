//
//  ORShapeViewVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/8/11.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ORShapeViewVC.h"
#import "ORShapeView.h"

@interface ORShapeViewVC ()

@end

@implementation ORShapeViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    ORShapeView *view = [[ORShapeView alloc]initWithFrame:CGRectMake(10, 100, 400, 400)];
    view.backgroundColor = [UIColor purpleColor];
    [self.view addSubview:view];
}


@end
