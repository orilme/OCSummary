//
//  FMDBShop.m
//  将任意对象存进数据库
//
//  Created by orilme on 2019/12/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "FMDBShop.h"

@implementation FMDBShop

// 归档（encoder）：将自定义的对象写入磁盘前，将对象转成”二进制“
- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeDouble:self.price forKey:@"price"];
}

// 解档（decoder）：将磁盘上保存的二进制数据，转化成自定义对象
- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.name = [decoder decodeObjectForKey:@"name"];
        self.price = [decoder decodeDoubleForKey:@"price"];
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%@ <-> %f", self.name, self.price];
}

@end
