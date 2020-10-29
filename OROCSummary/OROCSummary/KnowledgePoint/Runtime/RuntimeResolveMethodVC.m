//
//  RuntimeResolveMethodVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/8.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "RuntimeResolveMethodVC.h"
#import <objc/message.h>

@interface RuntimeResolveMethodVC ()

@end

@implementation RuntimeResolveMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //执行foo函数
    [self performSelector:@selector(runtimeMessageTest:)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    if (sel == @selector(runtimeMessageTest:)) { //如果是执行foo函数，就动态解析，指定新的IMP
        class_addMethod([self class], sel, (IMP)fooMethod, "v@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

void fooMethod(id obj, SEL _cmd) {
    NSLog(@"RuntimeMessageTest---"); //新的runtimeMessageTest函数
}

@end
