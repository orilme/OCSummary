//
//  MyFrameWorkVC.m
//  OROCSummary
//
//  Created by orilme on 2021/6/5.
//  Copyright © 2021 orilme. All rights reserved.
//

#import "MyFrameWorkVC.h"
#import <MyFramework/MyFrameWorkTool.h>

@interface MyFrameWorkVC ()

@end

@implementation MyFrameWorkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"MyFrameWorkVC---%ld", [MyFrameWorkTool sumNum1:20 num2:290]);
}

@end
