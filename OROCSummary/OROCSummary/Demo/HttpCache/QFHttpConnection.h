//
//  QFHttpConnection.h
//  HttpWithCache
//
//  Created by students on 16/3/14.
//  Copyright (c) 2016年 students. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^BSuccess)(NSData *data);
typedef void (^BFailure)(NSError *error);

@interface QFHttpConnection : NSObject

//下载数据的方法(假定是get),参数
//1.网址
//2.下载成功如何让把数据传给用户
//3.下载失败如何把数据传给用户

- (void)getDataWithUrl:(NSString *)strUrl onSuccess:(BSuccess)success onFailure:(BFailure)failure;

//清缓存
+ (void)clearCache;

@end
