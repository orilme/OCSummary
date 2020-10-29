//
//  MemManagementCountVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/18.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "MemManagementCountVC.h"
#import "MemoryPerson.h"
#import "MemoryCar.h"
#import "MemoryEngine.h"
#import "MemoryDog.h"

@interface MemManagementCountVC ()

@end

@implementation MemManagementCountVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //OC内存管理基本思想:
    //每个对象内部有一个引用计数,其值始终和指向这个对象的指针个数相同.多一个指针指向这个对象引用计数就加一；少一个指针指向这个对象引用计数就减一，减到0这个对象就被释放掉。这个引用计数应放在NSObject里
    //OC内存管理分为自动内存管理ARC(Automatic Reference Counting)和手动内存管理MRC(Manual Reference Counting)
    //MRC:程序猿调用增加和减少引用计数方法保证引用计数的值始终和指向这个对象的指针个数相同,从而避免内存管理出问题
    //ARC:编译器负责在代码的适当位置自动插入增加和减少引用计数的方法保证引用计数的值始终和指向这个对象的指针个数相同，从而避免内存管理出现问题
    
    
    //OC内存管理的原则(黄金法则):
    //1.通过alloc,new,retain,copy,mutableCopy五种方式得到的指针用完之后需要rlease
    //2.谁增加的引用计数谁就要减少引用计数(谁分配的谁释放)
    //3.个人顾个人,指针用完了就release而不管别人是否还要使用这个指针指向的对象
    //4.对一个对象指针release之后就不要通过这个指针操作对象了

    
    MemoryPerson *d1 = [[MemoryPerson alloc]init];
    NSLog(@"引用计数---%lu", [d1 retainCount]); //retainCount返回对象的引用计数
    
    MemoryPerson *d2 = [d1 retain]; //retain用于给对象的引用计数加一,并返回原对象d1.即d2,d1指向同一个对象
    NSLog(@"p2:%p, p1:%p", d2, d1);
    NSLog(@"引用计数---%lu", [d1 retainCount]);
    
    //这里不再需要d2了,调用rlease减少引用计数
    [d2 release];
    NSLog(@"引用计数---%lu", [d1 retainCount]);
    
    //这里不再需要d1了,调用rlease减少引用计数
    [d1 release]; //release之后d1所指向的对象的引用计数就变为0了,也就释放了.释放之后就不要通过这个指针操作对象了
    
    // 内存管理
    [self testRelease];
    // 集合的内存管理
    [self gatherMemManagement];
    // C的内存管理
    [self testCMemManagement];
}

- (void)testRelease {
    MemoryCar *bmw = [[MemoryCar alloc]init];
    bmw.engine = bmw.engine;
    
    /// 汽车大修
    MemoryEngine *e1 = [[MemoryEngine alloc]init];
    bmw.engine = e1;
    [e1 release];
    
    /// 又过了好久车也不要了
    [bmw release];
}

// 集合的内存管理
- (void)gatherMemManagement {
    MemoryDog *d1 = [[MemoryDog alloc]init];
    
    //只要一个对象加入一个数组不管以什么方式加的,该对象都会被retain
    NSMutableArray *array1 = [[NSMutableArray alloc]init];
    [array1 addObject:d1];//把一个对象(指针)加入数组,数组会对对象做一次retain
    [d1 release];
    [array1 release];
    
    MemoryDog *d2 = [[MemoryDog alloc]init];
    NSArray *array2 = @[d2];//这种简写法编译会自动替换为类方法,本行代码实际上如下
    //NSArray *array2 = [NSArray arrayWithObjects:d2, nil];
    [d2 release];
    printf("11----%@", array2);
    
    //只要一个对象加入一个字典不管以什么方式加的,该对象都会被retain
    MemoryDog *d3 = [[MemoryDog alloc]init];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc]init];
    [dict setObject:d3 forKey:@"安倍"];
    [d3 release];
    [dict release];
    
    MemoryDog *d4 = [[MemoryDog alloc]init];
    NSDictionary *dict2 = @{@"东条":d4};
    printf("22----%@", dict2);
    [d4 release];
}

- (void)testCMemManagement {
    func1();
    func2();
    func3();
    func4();
    func5();
    
    /// 实际项目中内存管理难题3:一个函数返回的内存到底需不需要释放,又该由谁释放
    char *p = func6();
    free(p); /// func6返回的内存是malloc来的必须free
    char *q = func7();/// func7返回的内存不是malloc来的不能free
    
    char *pp = malloc(100);
    char *pq = retain(pp);
    char *pq2 = retain(pp);
    release(pp);
    release(pq);
    release(pq2);
}

void func1() {
    char *p = malloc(100*1024);
    strcpy(p, "hello");
    NSLog(@"%s",p);
    
    //这里忘记了释放内存,该释放没有释放这种情况叫做内存泄露
}

void func2() {
    char *p = malloc(100*1024);
    strcpy(p, "memory management");
    NSLog(@"%s",p);
    /// ...
    free(p); /// 还没用完就释放了,叫做提前释放
    /// ..
    strcpy(p, "oc memory");
}

void func3() {
    char *p = malloc(100*1024);
    strcpy(p, "hahahaha");
    free(p);
    /// ....
    free(p);/// p之前的内存已经释放过了,这里又释放了一次,叫做重复释放
}

void func4() {
    char *p = malloc(100);
    char *q = p;
    strcpy(p, "hello");
    NSLog(@"%s",p);
    /// ...
    free(p);
    /// ...
    strcpy(q, "haha"); /// 实际项目中难题1:释放一块内存时要考虑是否有其他指针指向这块内存,避免提前释放
}

void func5() {
    char *p = malloc(100);
    char *q = p;
    strcpy(p, "hello");
    NSLog(@"%s",p);
    /// ...
    free(p);
    /// ...
    free(q);/// 实际项目中难题2:通过一个指针释放内存时要考虑内存是否通过其他指针释放过,避免重复释放
}

char *func6() {
    char *p = malloc(100);
    strcpy(p, "hello");
    return p;
}

char *func7() {
    static char buf[100];
    strcpy(buf, "hello");
    return buf;
}

static int count = 1;

char *retain(char *p) {
    count++;
    return p;
}

void release(char *p) {
    if (count == 1) {
        free(p);
    }else {
        count--;
    }
}

@end
