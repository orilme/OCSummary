//
//  TouchChainVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/5.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "TouchChainVC.h"

@interface TouchChainVC ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation TouchChainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    //当父控件不能接收触摸事件的时候，它的子控件不在遍历
    //当触摸点不在父控件的事件，它的子控件也不在遍历
    
    //往图片添加一个按钮
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.imageView addSubview:btn];
}

-(void)btnClick{
    NSLog(@"%s",__func__);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    NSLog(@"%s",__func__);
}

@end
