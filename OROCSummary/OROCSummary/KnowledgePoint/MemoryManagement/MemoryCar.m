//
//  MemoryCar.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "MemoryCar.h"

@implementation MemoryCar

- (id)init {
    if (self = [super init]) {
        //发动机可以看做是汽车的子对象,一个对象里如果有子对象通常需要在init方法里创建子对象
        _engine = [[MemoryEngine alloc]init];//创建子对象
    }
    return self;
}

- (void)dealloc {
    [_engine release];
    NSLog(@"车即将销毁");
    [super dealloc];
}

@end
