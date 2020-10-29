//
//  SDWebImageVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/6.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "SDWebImageVC.h"
#import "UIImageView+WebCache.h"
#import "SDWebImageManager.h"

@interface SDWebImageVC ()

@end

@implementation SDWebImageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 100, 300, 300)];
//    [self.view addSubview:imageView];
//    // [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://user-gold-cdn.xitu.io/2019/4/6/169f13e92a6ee774?w=1748&h=1290&f=png&s=459488"]];
//    [imageView sd_setImageWithURL:[NSURL URLWithString:@"https://user-gold-cdn.xitu.io/2019/4/6/169f13e92a6ee774?w=1748&h=1290&f=png&s=459488"] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        NSLog(@"下载进度---%f", (float)receivedSize/expectedSize);
//    } completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        NSLog(@"下载完成---%@", [NSThread currentThread]);
//    }];
//    
//    [[SDWebImageManager sharedManager].imageLoader downloadImageWithURL:[NSURL URLWithString:@"https://user-gold-cdn.xitu.io/2019/4/6/169f13e92a6ee774?w=1748&h=1290&f=png&s=459488"] options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
//        NSLog(@"下载进度2---%f", (float)receivedSize/expectedSize);
//    } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
//        NSLog(@"下载完成2---%@", [NSThread currentThread]);
//    }];
//    
//    [self performSelector:@selector(clearDisk) withObject:nil afterDelay:5];
}

//- (NSString *)readSDWebImageCache {
//    NSUInteger size = [SDImageCache sharedImageCache].getSize;
//    // 1k = 1024, 1m = 1024k
//    if (size < 1024) { // 小于1k
//        return [NSString stringWithFormat:@"%ldB",(long)size];
//    }else if (size < 1024 * 1024) { // 小于1m
//        CGFloat aFloat = size/1024;
//        return [NSString stringWithFormat:@"%.0fK",aFloat];
//    }else if (size < 1024 * 1024 * 1024) { // 小于1G
//        CGFloat aFloat = size/(1024 * 1024);
//        return [NSString stringWithFormat:@"%.1fM",aFloat];
//    }else {
//        CGFloat aFloat = size/(1024*1024*1024);
//        return [NSString stringWithFormat:@"%.1fG",aFloat];
//    }
//}
//
//// 清除图片缓存
//- (void)clearDisk {
//    NSLog(@"SDWebImageCache---%@", [self readSDWebImageCache]);
//    [[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
//    [[SDImageCache sharedImageCache] clearMemory]; //可不写
//    NSLog(@"SDWebImageCache2---%@", [self readSDWebImageCache]);
//}

@end
