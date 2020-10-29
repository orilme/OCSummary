//
//  NotificationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/15.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NotificationVC.h"

@interface NotificationVC ()

@end

@implementation NotificationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    // 主线程发的通知dealTest就在主线程执行，子线程发的就在子线程执行
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dealTest) name:@"test" object:nil];
}

- (void)dealTest {
    NSLog(@"dealTest-----%@", [NSThread currentThread]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil userInfo:nil];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"%@-----", [NSThread currentThread]);
        [[NSNotificationCenter defaultCenter] postNotificationName:@"test" object:nil userInfo:nil];
    });
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
