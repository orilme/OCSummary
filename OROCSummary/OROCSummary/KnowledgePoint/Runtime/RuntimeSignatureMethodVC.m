//
//  RuntimeSignatureMethodVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/8.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "RuntimeSignatureMethodVC.h"
#import "RuntimeExploreInfo.h"
#import "objc/runtime.h"

@interface RuntimeSignatureMethodVC ()

@end

@implementation RuntimeSignatureMethodVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self performSelector:@selector(runtimeMessageTest)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES; // 返回YES，进入下一步转发
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return nil; // 返回nil，进入下一步转发
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"runtimeMessageTest"]) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"]; // 签名，进入forwardInvocation
    }
    
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    SEL sel = anInvocation.selector;
    
    RuntimeExploreInfo *p = [RuntimeExploreInfo new];
    if([p respondsToSelector:sel]) {
        [anInvocation invokeWithTarget:p];
    }
    else {
        [self doesNotRecognizeSelector:sel];
    }
}

@end
