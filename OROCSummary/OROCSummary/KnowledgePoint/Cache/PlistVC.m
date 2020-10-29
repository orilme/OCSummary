//
//  PlistVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "PlistVC.h"

@interface PlistVC ()
@property (nonatomic,copy) NSString *plistPath;
@property (nonatomic,copy) NSString *plistPath2;
@property (nonatomic,copy) NSString *plistPath3;
@end

@implementation PlistVC

- (NSString *)plistPath {
    if (!_plistPath) {
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"plistPath---%@",doc);
        _plistPath = [doc stringByAppendingPathComponent:@"data.plist"];
    }
    return _plistPath;
}

- (NSString *)plistPath2 {
    if (!_plistPath2) {
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"plistPath2---%@",doc);
        _plistPath2 = [doc stringByAppendingPathComponent:@"data2.plist"];
    }
    return _plistPath2;
}

- (NSString *)plistPath3 {
    if (!_plistPath3) {
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"plistPath3---%@",doc);
        _plistPath3 = [doc stringByAppendingPathComponent:@"data3.plist"];
    }
    return _plistPath3;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor greenColor];
    
    //查看沙盒的路径
    //1.控制台打印沙盒的路径,使用finder-前往-文件夹 打开
    //2.控制台打印沙盒的路径,打开终端 open + 路径
    //3.使用simpholders工具
    //4.可以断点 输入po NSHomeDirectory()
    
    //获取缓存路径(cache)
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    NSLog(@"获取缓存路径---%@",cachePath);
    
    
    //获取临时路径(tmp)
    NSString *tmpPath = NSTemporaryDirectory();
    NSLog(@"获取临时路径---%@",tmpPath);
    
    //主目录
    NSString *homePath = NSHomeDirectory();
    NSLog(@"主目录---%@",homePath);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self testString];
    [self testDictionary];
    [self testArray];
}

- (void)testString {
    NSString *data = @"aabc";
    
    //写字符串
    [data writeToFile:self.plistPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
    
    //读字符串
    NSString *str = [NSString stringWithContentsOfFile:self.plistPath encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"testString---%@",str);
}

- (void)testDictionary {
    //把数据保存到沙盒的一个plist文件里
    NSDictionary *data = @{@"name":@"zhangsan", @"age":@23};
    //把数据写入一个文件
    [data writeToFile:self.plistPath2 atomically:YES];
    //读取
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:self.plistPath2];
    NSLog(@"testDictionary---%@",dict);
}

//  测试数组存储在一个plist文件
- (void)testArray {
    //把数据保存到沙盒的一个plist文件里
    NSArray *data = @[@"asd", @"asds"];
    
    //把数据写入一个文件
    [data writeToFile:self.plistPath3 atomically:YES];
    
    //读取
    NSArray *array = [NSArray arrayWithContentsOfFile:self.plistPath3];
    NSLog(@"testArray---%@",array);
}

@end
