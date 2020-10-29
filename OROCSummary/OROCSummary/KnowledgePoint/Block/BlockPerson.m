//
//  BlockPerson.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/6.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "BlockPerson.h"

@implementation BlockPerson

- (BlockPerson *(^)(NSString *))study {
    return ^(NSString *name){
        NSLog(@"study----%@", name);
        return self;
    };
}

- (BlockPerson *(^)())run {
    return ^{
        NSLog(@"run----");
        return self;
    };
}

@end
