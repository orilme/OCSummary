//
//  ArchiveDemoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/5.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "ArchiveDemoVC.h"
#import "AdvanceUser.h"

@interface ArchiveDemoVC ()

@end

@implementation ArchiveDemoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    AutoArchiveObject *zhangsan = [[AdvanceUser alloc]init];
    zhangsan.userName = @"zhangsan";
    zhangsan.password = @"123";
    zhangsan.weight = 456.7;
    zhangsan.age = 20;
    
    
    
    AutoArchiveObject *lisi = [[AdvanceUser alloc]init];
    lisi.userName = @"lisi";
    lisi.password = @"456";
    lisi.weight = 789.7;
    lisi.age = 30;

    
    NSMutableData *datawrite = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:datawrite];
    [archiver encodeObject:zhangsan forKey:@"zhangsan"];
    //[archiver encodeObject:lisi forKey:@"lisi"];
    [archiver finishEncoding];
    [datawrite writeToFile:@"./test.archive" atomically:YES];
    
    NSData *data = [[NSMutableData alloc] initWithContentsOfFile:@"./test.archive"];
    NSKeyedUnarchiver *unarchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    AutoArchiveObject *z2 = [unarchiver decodeObjectForKey:@"zhangsan"];
    //User *z3 = [unarchiver decodeObjectForKey:@"lisi"];
    [unarchiver finishDecoding];
    NSLog(@"z2: %@", z2);
    //NSLog(@"z3: %@", z3);
}

@end
