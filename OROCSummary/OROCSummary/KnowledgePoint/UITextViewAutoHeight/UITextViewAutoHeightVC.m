//
//  UITextViewAutoHeightVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/2/24.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "UITextViewAutoHeightVC.h"
#import <Masonry/Masonry.h>

@interface UITextViewAutoHeightVC ()

@end

@implementation UITextViewAutoHeightVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITextView *textView2 = [[UITextView alloc]init];
    textView2.scrollEnabled = NO;
    textView2.backgroundColor = [UIColor redColor];
    [self.view addSubview:textView2];
    [textView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view).offset(100);
        make.left.mas_equalTo(self.view).offset(60);
        make.right.mas_equalTo(self.view).offset(-60);
        make.height.mas_greaterThanOrEqualTo(30);
    }];
}

@end
