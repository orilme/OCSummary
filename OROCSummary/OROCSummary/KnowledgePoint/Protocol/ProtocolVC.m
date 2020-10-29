//
//  ProtocolVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/4.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "ProtocolVC.h"
#import "ProtocolStudent.h"
#import "ProtocolTeacher.h"
#import "ProtocolGoodStudent.h"

/**
 * 代理设计模式的场合：
 * 当对象A发生了一些行为，想告知对象B （让对象B成为对象A的代理对象）
 * 对象B想监听对象A的一些行为 （让对象B成为对象A的代理对象）
 * 当对象A无法处理某些行为的时候，想让对象B帮忙处理 （让对象B成为对象A的代理对象）
   1.监听器的场合 * Teacher想监听Baby的一些行为
   2.通知的场合 * Baby发生了一些行为，想告知Teacher
   3.有些事情，不想自己处理，想交给别人处理 * Baby发生了一些行为， 但是自己不会处理， 可以交给Teacher处理
 */
#import "ProtocolBaby.h"
#import "ProtocolNurse.h"

@interface ProtocolVC ()

@end

@implementation ProtocolVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    // 要求： 变量d指向的对象必须遵守PlayProcotol协议
    id<StudyProtocol> d = [[ProtocolGoodStudent alloc] init];
    ProtocolGoodStudent<StudyProtocol> *p = [[ProtocolGoodStudent alloc] init];
    NSLog(@"11----%@---%@", d, p);
    
    [self test1];
    [self test2];
}

- (void)test1 {
    ProtocolGoodStudent *gs = [[ProtocolGoodStudent alloc] init];
    [gs fight]; // 继承父类也可以重写父类遵守的协议的方法
    
    ProtocolStudent *stu = [[ProtocolStudent alloc] init];
    [stu paoKu];
    [stu readBook];
    [stu doHomework];
    
    // 注意未实现协议方法会报警告，使用未实现的方法会崩溃
//    ProtocolTeacher *tea = [[ProtocolTeacher alloc] init];
//    [tea readBook];
//    [tea doHomework];
}

- (void)test2 {
    ProtocolBaby *b = [[ProtocolBaby alloc] init];
    b.delegate = [[ProtocolNurse alloc] init];
    
    [b wantEat];
    [b wantSleep];
}

@end
