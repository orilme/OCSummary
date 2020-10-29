//
//  ExceptionVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/5.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "ExceptionVC.h"

@interface ExceptionVC ()

@end

@implementation ExceptionVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    @try {
        @try {
            NSArray *array1 = @[@"1"];
            NSString *str1 = array1[1];
            NSLog(@"str1: %@", str1);
        }
        @catch (NSException *exception) {
            //@try部分的代码抛出异常时会执行@catch部分的代码，并传递一个NSException类的对象，exception表示本次发生的异常的相关信息
            
            NSLog(@"捕捉到异常:%@, %@", exception.name, exception.description);
            NSException *e1 = [NSException exceptionWithName:@"抛出定义的异常" reason:@"出现了异常，愿因待查" userInfo:nil];
            @throw e1;//抛出异常
        }
        @finally {
            NSLog(@"不管try部分是否发生异常都要执行finally部分的代码");
        }
    }
    @catch (NSException *e) {
        NSLog(@"异常:%@", e.description);
    }
    @finally {
        NSLog(@"外层的finally");
    }
}

@end
