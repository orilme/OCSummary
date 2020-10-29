//
//  RuntimeForwardMethodVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/8.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "RuntimeForwardMethodVC.h"
#import "RuntimeExploreInfo.h"
#import "objc/runtime.h"

@interface RuntimeForwardMethodVC ()

@end

@implementation RuntimeForwardMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self performSelector:@selector(runtimeMessageTest)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"resolveInstanceMethod----");
    return YES; // 返回YES，进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    NSLog(@"forwardingTargetForSelector----");
    if (aSelector == @selector(runtimeMessageTest)) {
        return [RuntimeExploreInfo new]; // 返回RuntimeExploreInfo对象，让RuntimeExploreInfon对象接收这个消息
    }
    return [super forwardingTargetForSelector:aSelector];
}

@end
