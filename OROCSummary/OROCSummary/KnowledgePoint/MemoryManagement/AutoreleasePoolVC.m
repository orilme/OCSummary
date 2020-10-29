//
//  AutoreleasePoolVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "AutoreleasePoolVC.h"
#import "MemoryPerson.h"
        
@interface AutoreleasePoolVC ()

@end

@implementation AutoreleasePoolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    // 如果不想自动内存管理，可以在build phases 下的compile sources 中找到不想自动管理的.m文件 ，给它加compiler flags  为 -fno-objc-arc
    
    // 1,创建自动释放池
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    // 2.循环创建对象
    for (int i = 0; i < 20; i++) {
        // 每创建5个对象就释放一次
        if (i % 5 == 0) {
            [pool release];
            pool = [[NSAutoreleasePool alloc] init];
            NSLog(@"-----------");
        }
        MemoryPerson *p = [[[ MemoryPerson alloc] init] autorelease];
        NSLog(@"-----------%@"), p;
    }
    [pool release];
}

@end
