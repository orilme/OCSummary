//
//  KVCPerson.m
//  KVC
//
//  Created by LaoWen on 16/2/25.
//  Copyright (c) 2016年 LaoWen. All rights reserved.
//

#import "KVCPerson.h"

@implementation KVCPerson

//重写setValue:forUndefinedKey
//这个方法当你用KVC给不存在的属性赋值时会被调用.
//如果你没重写这个方法又给不存在的属性赋值了，那程序就会崩

//如果model里的属性比json中的少，一定要写这个方法，不然会崩
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    NSLog(@"value:%@, key:%@", value, key);
}


+ (NSArray *)snsesFromJsonData:(NSData *)data {
    NSMutableArray *result = [NSMutableArray array];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *user in dict[@"users"]) {
        KVCPerson *model = [[KVCPerson alloc]init];
        [model setValuesForKeysWithDictionary:user];
        [result addObject:model];
    }
    
    return result;
}

@end
