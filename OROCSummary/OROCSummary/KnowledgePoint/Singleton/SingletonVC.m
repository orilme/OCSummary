//
//  SingletonVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/5.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "SingletonVC.h"
#import "HMDataTool.h"
#import "HMGoodStudent.h"
#import "HMMusicTool.h"
#import "HMMovieTool.h"

@interface SingletonVC ()

@end

@implementation SingletonVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 测试 +load, +initialize
    [[HMGoodStudent alloc] init];
    
    HMDataTool *tool1 = [HMDataTool sharedDataTool];
    HMDataTool *tool2 = [HMDataTool sharedDataTool];
    HMDataTool *tool3 = [[HMDataTool alloc] init];
    HMDataTool *tool4 = [[HMDataTool alloc] init];
    NSLog(@"单例--- %@ %@ %@ %@", tool1, tool2, tool3, tool4);
    
    HMMusicTool *tool5 = [HMMusicTool sharedMusicTool];
    HMMusicTool *tool6 = [[HMMusicTool alloc] init];
    NSLog(@"单例2--- %@ %@ ", tool5, tool6);
    
    HMMovieTool *tool7 = [HMMovieTool sharedMovieTool];
    HMMovieTool *tool8 = [[HMMovieTool alloc] init];
    NSLog(@"宏定义单例--- %@ %@ ", tool7, tool8);
    
}

@end
