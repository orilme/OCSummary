//
//  EnumVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//

typedef enum {
    TouchTypeTop = 0,
    TouchTypeBottom = 1,
    TouchTypeLeft = 2,
    TouchTypeRight = 3,
} TouchType;

#import "EnumVC.h"

@interface EnumVC ()

@end

@implementation EnumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self test:TouchTypeTop];
    [self test:TouchTypeBottom];
    [self test:TouchTypeLeft];
    [self test:TouchTypeRight];
    
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if ([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}

- (void)test:(TouchType)type {
    if (type == 0) {
        NSLog(@"上---");
    }else if (type == 1) {
        NSLog(@"下---");
    }else if (type == 2) {
        NSLog(@"左---");
    }else if (type == 3) {
        NSLog(@"右---");
    }
}

@end
