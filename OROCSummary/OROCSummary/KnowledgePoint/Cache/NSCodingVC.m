//
//  NSCodingVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NSCodingVC.h"
#import "FMDBShop.h"

@interface NSCodingVC ()
@property (nonatomic,copy) NSString *plistPath;
@end

@implementation NSCodingVC

-(NSString *)plistPath {
    if (!_plistPath) {
        
        // 获取document目录
        NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        
        NSLog(@"plistPath---%@",doc);
        _plistPath = [doc stringByAppendingPathComponent:@"data.archiver"];
    }
    
    return _plistPath;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self testNSKeyedArchiver];
    
    //保存字典
    [self testDict];
    //读字典
    NSDictionary *dict = [NSKeyedUnarchiver unarchiveObjectWithFile:self.plistPath];
    NSLog(@"读字典---%@", dict);
    
    // 保存数据
    FMDBShop *contact = [[FMDBShop alloc] init];
    contact.name = @"张三";
    contact.price = 27;
    [NSKeyedArchiver archiveRootObject:contact toFile:self.plistPath];
    
    //读数据
    FMDBShop *shop = [NSKeyedUnarchiver unarchiveObjectWithFile:self.plistPath];
    NSLog(@"读数据---name:%@ price:%f ", shop.name, shop.price);
}

/**
 *  测试 系统的NSDictionary NSArray的归档
 *  只有 对象 遵守了NSCoding协议才可以使用NSKeyedArchiver进行数据存储
 */
- (void)testDict {
    //使用 “归档” 方法保存数据
    //NSArray *data = @[@"asbc",@23];
    NSDictionary *data = @{@"name":@"zhangs",@"heigt":@1.90};
    //直接把一个对象保存到沙盒里
    [NSKeyedArchiver archiveRootObject:data toFile:self.plistPath];
}

- (void)testNSKeyedArchiver {
    NSArray *array1 = @[@"1",@"2",@"3"];
    //归档也是OC中的一种数据持久化存储机制
    //Foundation库中的类的对象多数都能直接归档(和解档)
    //自定义类中的对象也能归档和解档，但是这个类必须遵守NSCoding协议并实现其中的方法
    
    //把array1写入归档文件
    //参数一:要归档的对象(指针)
    //参数二:要归档的绝对路径
    //归档文件和plist格式不一样,也不建议用xcode打开
    [NSKeyedArchiver archiveRootObject:array1 toFile:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/ORIOSSummary/array.bin"];
    

    //解档,即读出归档文件并生成对象
    NSArray *array2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/ORIOSSummary/array.bin"];
    NSLog(@"testNSKeyedArchiver---%@", array2);
    
    //类中的读档与归档
    FMDBShop *contact = [[FMDBShop alloc] init];
    contact.name = @"张三";
    contact.price = 27;
    [NSKeyedArchiver archiveRootObject:contact toFile:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/ORIOSSummary/array.bin"];
    
    FMDBShop *d2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/ORIOSSummary/dongTiao.bin"];
    NSLog(@"testNSKeyedArchiver2---%@", d2);
}

@end
