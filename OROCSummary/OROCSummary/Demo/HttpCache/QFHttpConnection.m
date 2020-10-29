//
//  QFHttpConnection.m
//  HttpWithCache
//
//  Created by students on 16/3/14.
//  Copyright (c) 2016年 students. All rights reserved.
//

#import "QFHttpConnection.h"
#import "NSString+Hashing.h"

@implementation QFHttpConnection

//下载数据的方法(假定是get),参数
//1.网址
//2.下载成功如何让把数据传给用户
//3.下载失败如何把数据传给用户

- (void)getDataWithUrl:(NSString *)strUrl onSuccess:(BSuccess)success onFailure:(BFailure)failure
{
    NSString *fileName = [strUrl MD5Hash];//计算出网址的MD5值做成文件名
    NSString *path = [NSString stringWithFormat:@"%@/Documents/cache/%@",NSHomeDirectory(),fileName];
    //NSLog(@"%@",path);//====
    BOOL ret = [[NSFileManager defaultManager]fileExistsAtPath:path];
    if (ret) {//存在本地缓存,直接读文件
        NSLog(@"有缓存");
        NSFileHandle *handle = [NSFileHandle fileHandleForReadingAtPath:path];//以读方式打开文件
        NSData *data = [handle readDataToEndOfFile];//读出文件内容
        [handle closeFile];//关闭文件
        
        success(data);//把数据返回给用户
        return;
    }
    
    NSLog(@"无缓存");
    //没有缓存才去从网络下载
    NSURL *url = [NSURL URLWithString:strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failure(error);
            });
            
        }else {//连接成功,把数据写入文件(上面算好了)并返回给用户
            
            //创建目录
            NSString *dir = [NSHomeDirectory() stringByAppendingString:@"/Documents/cache"];
            [[NSFileManager defaultManager]createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
            
            [[NSFileManager defaultManager]createFileAtPath:path contents:data attributes:nil];
            
            //考虑到我们封装的方法大部分是在主线程中调用的,所以我们也在主线程中调用success
            //TDDO:更好的实现是我们封装的这个方法在哪个线程调用,就在哪个线程中调用success
            dispatch_async(dispatch_get_main_queue(), ^{
                success(data);
            });
            
        }
    }];
    [task resume];
}

+ (void)clearCache {
    NSString *cachePath = [NSHomeDirectory() stringByAppendingString:@"/Documents/cache"];
    [[NSFileManager defaultManager]removeItemAtPath:cachePath error:nil];
}

@end
