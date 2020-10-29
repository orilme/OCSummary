//
//  JumpVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/10.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "JumpVC.h"

/*
URL:统一资源定位符 http://www.baidu.com tel://110 file:///apple/Desktop/
协议头Scheme:http:// tel:// file://
资源路径path:www.baidu.com 110 /apple/Desktop/

项目->info->url types ->+ -> 配置协议头
*/

/*
 * plist配置
<key>NSAppTransportSecurity</key>
 <dict>
     <key>NSAllowsArbitraryLoads</key>
     <true/>
 </dict>
 <key>LSApplicationQueriesSchemes</key>
 <array>
     <string>weixin</string>
 </array>
 */

/** 只要是由其他应用程序打开的，就会调用此方法 */
/** URL 就是其他应用程序，打开当前程序使用的URL */
//- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url

/**
 openURL 是打开当前应用程序的url
 sourceApplication 是当开当前应用程序的源程序的BundleId
 
 提示：一旦重写了新方法，旧方法就不再被执行
 但是：很多第三方框架，都建议两个方法全都写
 */
//- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation

@interface JumpVC ()

/**
 *  点击之后跳转到微信
 */
- (IBAction)jump;
/**
 *  点击微信好友按钮跳转到微信
 */
- (IBAction)sesstion;
/**
 *  点击朋友圈按钮跳转到微信
 */
- (IBAction)timeline;

@end


@implementation JumpVC

- (IBAction)jump {
    [self openWeiXin:@"weixin://"];
}

- (IBAction)sesstion {
    [self openWeiXin:@"weixin://session?iossummary"];
}

- (IBAction)timeline {
    [self openWeiXin:@"weixin://timeline"];
}

- (void)openWeiXin:(NSString *)urlStr {
    // 1.创建要打开的App的URL
    NSURL *weixinURL = [NSURL URLWithString:urlStr];
    
    // 2.判断是否该URL可以打开
    if ([[UIApplication sharedApplication] canOpenURL:weixinURL]) {
        // 3.打开URL
        [[UIApplication sharedApplication] openURL:weixinURL options:@{} completionHandler:nil];
    }
}

@end
