//
//  EncryptVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/25.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "EncryptVC.h"
#import "SSKeychain.h"

#define kLoginPwdKey            @"LoginPasswordKey"
#define kLoginKeyServiceName    @"LoginKeyService"

@interface EncryptVC ()

@end

@implementation EncryptVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *pwd = @"asdf12234567";
    NSString *encryptPwd = [self base64Decode:pwd];
    NSLog(@"加密后的密码---%@", encryptPwd);
    NSString *finalPwd = [self base64Encode:encryptPwd];
    NSLog(@"还原后的密码---%@", finalPwd);
    
    // 钥匙串
    /// 设置密码
    [SSKeychain setPassword:@"mima111111" forService:kLoginKeyServiceName account:@"key00000"];
    /// 读取账户信息
    NSLog(@"读取钥匙串全部账户信息---%@", [SSKeychain allAccounts]);
    NSString *pwd2 = [SSKeychain passwordForService:kLoginKeyServiceName account:@"key00000"];
    NSLog(@"读取指定钥匙串----%@", pwd2);
    /// 删除钥匙串
    [SSKeychain deletePasswordForService:kLoginKeyServiceName account:@"key00000"];
}

- (NSString *)base64Encode:(NSString *)str {
    NSData *data = [[NSData alloc]initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
}

- (NSString *)base64Decode:(NSString *)str {
    NSData *base64Data = [[str dataUsingEncoding:NSUTF8StringEncoding] base64EncodedDataWithOptions:0];
    return [[NSString alloc]initWithData:base64Data encoding:NSUTF8StringEncoding];
}

@end
