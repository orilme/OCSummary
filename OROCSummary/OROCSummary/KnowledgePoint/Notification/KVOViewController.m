//
//  KVOViewController.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/15.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "KVOViewController.h"
#import "KVOKVCPerson.h"

@interface KVOViewController ()
@property (nonatomic, strong) KVOKVCPerson *p;
@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self testKvo];
}

- (void)testKvo {
    KVOKVCPerson *p = [[KVOKVCPerson alloc] init];
    p.age = 20;
    
    [p addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
    
    p.age = 30;
    p.age = 40;
    
    self.p = p;
}

/**
 *  当监控的某个属性的值改变了就会调用
 *
 *  @param keyPath 属性名（哪个属性改了？）
 *  @param object  哪个对象的属性被改了？
 *  @param change  属性的修改情况（属性原来的值、属性最新的值）
 *  @param context void * == id
 */
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"%@对象的%@属性改变了：%@", object, keyPath, change);
}


- (void)dealloc {
    [self.p removeObserver:self forKeyPath:@"age"];
}

@end
