//
//  SendMessageVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/17.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "SendMessageVC.h"
#import <MessageUI/MessageUI.h>

@interface SendMessageVC ()<MFMessageComposeViewControllerDelegate>

@end

@implementation SendMessageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 200, 300, 50)];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"发短信" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(sendMessage) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)sendMessage {
    __weak typeof(self) weakSelf = self;
    
    //发短信 不能设置短信内容
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"sms://10086"]];
    NSLog(@"====");
    //判断能否接收短信
    if (![MFMessageComposeViewController canSendText]) {
        return ;
    }
    
    //如果要设置内容，我使用MessageUI
    //1.创建MFMessageComposeViewController
    MFMessageComposeViewController *msgVc = [[MFMessageComposeViewController alloc] init];
    
    //设置电话
    msgVc.recipients = @[@"10086",@"10010"];
    
    //设置内容
    msgVc.body = @"恭喜你中奖，请选汇款.....";
    
    //设置代理
    msgVc.messageComposeDelegate = weakSelf;
    
    //显示信息界面
    [weakSelf presentViewController:msgVc animated:YES completion:nil];
}

@end
