//
//  PresentVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/7/18.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "PresentVC.h"

@interface PresentVC ()

@end

@implementation PresentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self customView];
}

- (void)customView {
    
    UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    cancelButton.backgroundColor = [UIColor greenColor];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelButtonAction) forControlEvents:UIControlEventTouchUpInside];
    cancelButton.frame = CGRectMake(0, 0, Screen_Width, 30);
    [self.view addSubview:cancelButton];
    
    UILabel *contentLable = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(cancelButton.frame), Screen_Width, 300-CGRectGetMaxY(cancelButton.frame))];
    contentLable.backgroundColor = [UIColor redColor];
    contentLable.text = @"contentLabel";
    contentLable.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:contentLable];
}

- (void)cancelButtonAction {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
