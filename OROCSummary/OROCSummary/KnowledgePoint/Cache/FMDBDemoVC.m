//
//  FMDBDemoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "FMDBDemoVC.h"
#import "FMDB.h"
#import "FMDBShop.h"

@interface FMDBDemoVC ()
@property (nonatomic, strong) FMDatabase *db;
@end

@implementation FMDBDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setup];
    [self addShops];
    [self readShops];
    [self testKeyedArchiver];
}

- (void)setup {
    // 初始化
    NSString *path = @"/Users/orilme/code/Z我的Git仓库/IOSSummary/shops.data";
    self.db = [FMDatabase databaseWithPath:path];
    [self.db open];
    
    // 2.创表
    [self.db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_shop (id integer PRIMARY KEY, shop blob NOT NULL);"];
}

- (void)readShops {
    FMResultSet *set = [self.db executeQuery:@"SELECT * FROM t_shop LIMIT 10,10;"];
    while (set.next) {
        NSData *data = [set objectForColumnName:@"shop"];
        FMDBShop *shop = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        NSLog(@"readShops---%@", shop);
    }
}

- (void)addShops {
    for (int i = 0; i<10; i++) {
        FMDBShop *shop = [[FMDBShop alloc] init];
        shop.name = [NSString stringWithFormat:@"FMDB商品--%d", i];
        shop.price = arc4random() % 10000;
        
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:shop];
        [self.db executeUpdateWithFormat:@"INSERT INTO t_shop(shop) VALUES (%@);", data];
    }
}

// 归档和解档开发中很少使用，主要是用在自定义对象存储
- (void)testKeyedArchiver {
    FMDBShop *shop = [[FMDBShop alloc] init];
    shop.name = [NSString stringWithFormat:@"Archiver商品"];
    shop.price = arc4random() % 10000;
    [NSKeyedArchiver archiveRootObject:shop toFile:@"/Users/apple/Desktop/shops.plist"];
    FMDBShop *shop2 = [NSKeyedUnarchiver unarchiveObjectWithFile:@"/Users/apple/Desktop/shops.plist"];
    NSLog(@"KeyedArchiver---%@", shop2);
}

@end
