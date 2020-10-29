//
//  ShapeImageVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/9/2.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "ShapeImageVC.h"
#import "ShapeImageView.h"

@interface ShapeImageVC ()

@end

@implementation ShapeImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGRect frame = CGRectMake(0, 100, Screen_Width, Screen_Width);
    ShapeImageView *shapeImageView = [[ShapeImageView alloc] initWithFrame:frame];
    shapeImageView.image = [UIImage imageNamed:@"aimage"];
    shapeImageView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:shapeImageView];
    

}

@end
