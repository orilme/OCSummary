//
//  URLSeccionOneVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/19.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "URLSeccionOneVC.h"
#import "SSZipArchive.h"

@interface URLSeccionOneVC ()

@end

@implementation URLSeccionOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self studyURLSession1];
    [self studyURLSession2];
}

/**
 使用NSURLSession肯定是异步，在子线程做耗时操作
 我们只需要 创建一个session，发起一个任务，让任务resume就OK了
 */
- (void)studyURLSession1 {
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://192.168.10.9/videos.json"];
    
    // 2. 由session发起任务
    [[[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
        // 反序列化
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        
        NSLog(@"%@", result);
        
        
        // 更新UI在主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"更新UI");
        });
        
    }] resume];
    
    NSLog(@"come here");
}

- (void)studyURLSession2 {
    // 1. url
    NSURL *url = [NSURL URLWithString:@"http://192.168.10.9/videos.json"];

    // 2. 创建session
    // 苹果直接提供了一个全局的session
    NSURLSession *session = [NSURLSession sharedSession];
    
    // 3. 由session发起任务
    NSURLSessionDataTask *task = [session dataTaskWithURL:url completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        // 反序列化
        id result = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
        NSLog(@"%@", result);
    }];
    
    // 4. 需要把任务开始。 默认都是挂起
    [task resume];
}

// 解压缩
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    NSString *urlStr = @"http://127.0.0.1/itcast/images.zip";
    urlStr = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url = [NSURL URLWithString:urlStr];
    // 2. 下载
    [[[NSURLSession sharedSession] downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        
        NSLog(@"文件的路径%@", location.path);
        
        NSString *cacheDir = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"%@", cacheDir);
        /**
         FileAtPath：要解压缩的文件
         Destination: 要解压缩到的路径
         */
        [SSZipArchive unzipFileAtPath:location.path toDestination:cacheDir];
        
    }] resume];
}

@end
