//
//  HTTPCookieStorageVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/20.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "HTTPCookieStorageVC.h"

@interface HTTPCookieStorageVC ()

@end

@implementation HTTPCookieStorageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    /* cookie创建
     * 注意点：有几个key是必须要设置的: NSHTTPCookiePath, NSHTTPCookieName, NSHTTPCookieValue,还有就是NSHTTPCookieOriginURL 和 NSHTTPCookieDomain一定要选一个。开始就因为没有设置NSHTTPCookiePath搞了半天
     */
    NSMutableDictionary *properties = [NSMutableDictionary dictionary];
    [properties setObject:@"key" forKey:NSHTTPCookieName];
    [properties setObject:@"newValue" forKey:NSHTTPCookieValue];
    [properties setObject:@"domian" forKey:NSHTTPCookieDomain];
    [properties setObject:@"path" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookieuser = [NSHTTPCookie cookieWithProperties:properties];
    NSLog(@"cookieuser----------- %@", cookieuser);
    
    // cookie获取
    NSArray *array = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookiesForURL:[NSURL URLWithString:@"urlString"]];
    for (NSHTTPCookie *cookie in array) {
        NSLog(@"-----------cookiename: %@ cookieValue: %@ cookieDomin: %@",cookie.name,cookie.value,cookie.domain);
    }
    
    // 给指定url设置cookie
    NSMutableDictionary *cookieProperties = [NSMutableDictionary dictionary];
    [cookieProperties setObject:@"userId" forKey:NSHTTPCookieName];
    [cookieProperties setObject:@"loginModel.userId" forKey:NSHTTPCookieValue];
    [cookieProperties setObject:@"networkAuthenModel.domain" forKey:NSHTTPCookieDomain];
    [cookieProperties setObject:@"networkAuthenModel.urlString" forKey:NSHTTPCookiePath];
    NSHTTPCookie *cookie = [NSHTTPCookie cookieWithProperties:cookieProperties];
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    // cookie删除
    NSHTTPCookieStorage *cookieStorage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    NSArray *tempArray = [NSArray arrayWithArray:[cookieStorage cookies]];
    for (NSHTTPCookie *cookie in tempArray) {
        [cookieStorage deleteCookie:cookie];
    }

}



@end
