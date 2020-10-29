//
//  KVOStudyVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/11.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "KVOStudyVC.h"
#import "KVCPerson.h"

@interface KVOStudyVC ()

@end

@implementation KVOStudyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    KVCPerson *p1 = [[KVCPerson alloc]init];

    // KVO的是KeyValue Observe的缩写，这是一个典型的观察者模式，观察者在键值改变时会得到通知。iOS中有个Notification的机制，也可以获得通知，但这个机制需要有个Center，相比之下KVO更加简洁而直接。
    /*
     * KVO的使用也很简单，就是简单的3步。
     * 1.注册需要观察的对象的属性addObserver:forKeyPath:options:context:
     * 2.实现observeValueForKeyPath:ofObject:change:context:方法，这个方法当观察的属性变化时会自动调用
     * 3.取消注册观察removeObserver:forKeyPath:context:
     */
    
    
    // 1. 效率肯定是delegate比NSNotification高。
    // delegate 方法比 notification 更加直接，最典型的特征是，delegate方法往往需要关注返回值，也就是delegate方法的结果。比如-windowShouldClose:，需要关心返回的是yes还是no。所以delegate方法往往包含 should这个很传神的词。也就是好比你做我的delegate，我会问你我想关闭窗口你愿意吗？你需要给我一个答案，我根据你的答案来决定如何做下一步。相反的，notification最大的特色就是不关心接受者的态度，我只管把通告放出来，你接受不接受就是你的事情，同时我也不关心结果。所以notification往往用did这个词汇，比如NSWindowDidResizeNotification，那么NSWindow对象放出这个notification后就什么都不管了也不会等待接 受者的反应。
    
    // 2. KVO和NSNotification的区别：
    // 和delegate一样，KVO和NSNotification的作用也是类与类之间的通信，与delegate不同的是1）这两个都是负责发出通知，剩下的事情就不管了，所以没有返回值；2）delegate只是一对一，而这两个可以一对多。这两者也有各自的特点。
    

    /* 给p1的nickName1属性增加一个键值观察者（KVO Key Value Observer）
     * 以后每当p1的nickName1属性被赋值时，观察者的某个方法都会被系统调用（通知观察者某个对象的某属性值变了）
     * 参数1：观察者的指针
     * 参数2：被观察的属性
     * 参数3：选项，NSKeyValueObservingOptionNew 表示观察者能得到被观察的属性的新值，NSKeyValueObservingOptionOld表示观察者能得到被观察的属性的原值
     */
    
    [p1 addObserver:self forKeyPath:@"nickName1" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    p1.nickName1 = @"Golden";
    [p1 setValue:@"Modern" forKey:@"nickName1"];
    [p1 setValue:@"Modern" forKey:@"nickName1"];
    // 取消p1的nickName1属性的键值观察者
    [p1 removeObserver:self forKeyPath:@"nickName1"];
}

// 键值观察者的观察方法，当被观察的属性变化时这个方法会被系统自动调用
// 参数1：被观察的属性
// 参数2：被观察的对象
// 参数3：被观察的属性的一些值
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    NSLog(@"KVO---keyPath:%@, change:%@", keyPath, change);
}

@end
