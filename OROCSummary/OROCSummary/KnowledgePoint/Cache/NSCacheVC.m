//
//  NSCacheVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NSCacheVC.h"

@interface NSCacheVC ()
@property (nonatomic, strong) NSCache *myCache;
@end

@implementation NSCacheVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSCache *myCache = [[NSCache alloc]init];
    for (int i = 0; i<10; i++) {
        [myCache setObject:[NSString stringWithFormat:@"NSCache---%d", i] forKey:@(i)];
    }
    
    for (int i = 0; i<10; i++) {
        NSLog(@"%@", [myCache objectForKey:@(i)]);
    }
}



@end
