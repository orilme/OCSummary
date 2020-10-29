//
//  HMPerson.m
//  03-单例模式-Singleton（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "HMPerson.h"

@implementation HMPerson
+ (void)load
{
    NSLog(@"load---HMPerson");
}

+ (void)initialize
{
    NSLog(@"initialize---HMPerson");
}
@end
