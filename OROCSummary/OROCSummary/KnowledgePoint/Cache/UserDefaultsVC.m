//
//  UserDefaultsVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "UserDefaultsVC.h"

@interface UserDefaultsVC ()

@end

@implementation UserDefaultsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //使用偏好设置保存数据
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    //保存的数据
    [defaults setObject:@"zhangsan" forKey:@"account"];
    [defaults setObject:@"123" forKey:@"password"];
    [defaults setBool:YES forKey:@"autoLogin"];
    [defaults setBool:YES forKey:@"rememberPwd"];
    
    //调用同步的方法，把数据保存到沙盒文件
    [defaults synchronize];
    
    [self read];
    [self modify];
    [self read];
    [self delete];
    [self read];
}

- (void)modify {
    //修改 用户偏好设置 数据
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"321" forKey:@"password"];
    [defaults synchronize];
}

- (void)delete {
    //删除 用户偏好设置 数据
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    [defautls removeObjectForKey:@"account"];
    
    //删除记得也要调用 同步的方法
    [defautls synchronize];
}

- (void)read {
    //读取 用户偏好设置 的数据
    NSUserDefaults *defautls = [NSUserDefaults standardUserDefaults];
    NSString *account = [defautls objectForKey:@"account"];
    NSString *password = [defautls objectForKey:@"password"];
    BOOL rememberPwd = [defautls boolForKey:@"rememberPwd"];
    BOOL autoLogin = [defautls boolForKey:@"autoLogin"];
    NSLog(@"account---%@ password---%@ rememberPwd---%d autoLogin---%d", account, password, rememberPwd, autoLogin);
}

@end
