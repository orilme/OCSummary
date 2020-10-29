//
//  BasicTypeVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/5.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "BasicTypeVC.h"
#import "file1.h"

@interface BasicTypeVC ()

@end

@implementation BasicTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self NSDataDemo];
    [self testStatic];
}


static int count = 500;
- (void)funcStatic {
    //static用方法一：
    //修饰局部变量，使变量放在静态数据区，函数返回时不被释放，从而能保留以前的值
    static int count = 0;
    count++;
    NSLog(@"count = %d", count);
}
- (void)testStatic {
    for (int i=0; i<5; i++) {
        [self funcStatic];
    }
    
    file1SetCount();
    file1PrintCount();
    
    printf("main, count --- %d", count);
}

int add(int a, int b) {
    return a+b;
}
- (void)typedefDemo {
    typedef int INT;
    
    struct SSPoint {
        int x;
        int y;
    }c;
    c.x = 100;
    c.y = 200;
    
    
    typedef struct SPoint{
        int x;
        int y;
    }Point;
    
    struct SPoint a;
    Point b;
    
    //typedef的用法：不写typedef时应该出现变量的地方，加上typedef就变成了类型定义的地方
    
    int (*pfunc)(int a, int b);//定义了一个函数指针pfunc，有两个int型参数，返回值也是int型
    pfunc = add;
    
    int f = pfunc(1,5);
    NSLog(@"add %p  %p", add, f);
    
    //用typedef定义一个新类型：函数指针类型，有两个int型参数，返回值为int型
    typedef int (*PFunc)(int a, int b);
    PFunc p1;
    p1 = add;
    int d = p1(1, 2);
    
    //用typedef定义一个新类型：函数指针类型，三个float类型参数，返回值为void型
    //void func1(float a1, float a2, float a3);
    void (*pfunc1)(float a1, float a2, float a3);
    typedef  void (*PFunc1)(float a1, float a2, float a3);
    PFunc1 p2;
    
    typedef struct __Rect {
        int x;
        int y;
        int w;
        int h;
    } *PRect, TRect;
    
    int a1, b1;
    int a2, *b2;
    typedef int INTEGER, *PINTEGER;
    
    struct __Rect r1;
    r1.x = 100;
    r1.y = 200;
    r1.w = 300;
    r1.h = 400;
    
    TRect r2;
    r2.x = 10;
    PRect r3;
    r3->x = 8;
}

- (void)NSDataDemo {
    //NSData是OC里表示数据的类,很多类都有和NSData相互转换的方法
    NSString *str1 = @"hello";
    NSData *d1 = [str1 dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"d1:%@",d1);
    NSLog(@"d1.bytes:%s",d1.bytes);//如果d1指向的的对象里存的ASCII码可以用这种方式看一下,但是不是正规方式
    NSString *str2 = [[NSString alloc]initWithData:d1 encoding:NSUTF8StringEncoding];
    NSLog(@"str2:%@",str2);
}

- (void)stringTrimUpper {
    NSString *str = @"HTTP://ios.itcast.cn/IOS/images/content_25.jpg";
    
    NSString *newStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet uppercaseLetterCharacterSet]];
    NSLog(@"%@", newStr);
}

- (void)tringTrimSpace {
    NSString *str = @"  http://ios.itcast.cn  ios/images/  content_25.jpg  ";
    
    // trim : 去除头尾
    // whitespaceCharacterSet : 空格
    NSCharacterSet *set = [NSCharacterSet whitespaceCharacterSet];
    NSString *newStr = [str stringByTrimmingCharactersInSet:set];
    
    NSLog(@"--%@--", str);
    NSLog(@"--%@--", newStr);
}

- (void)string2int {
    NSString *str = @"108";
    NSString *str2 = @"200.5";
    // str.intValue ---> 108
    //        int sum = str.intValue + str2.intValue;
    double sum = str.intValue + str2.doubleValue;
    NSLog(@"%f", sum);
}

- (void)replaceString2 {
    NSString *str = @"  http:**  ios.itcast.cn  *ios*images*  content_25.jpg  ";
    
    // 1.把空格消掉
    NSString *newStrWithoutSpace = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    // 2.把*换成/
    NSString *destStr = [newStrWithoutSpace stringByReplacingOccurrencesOfString:@"*" withString:@"/"];
    
    NSLog(@"str = %@", str);
    NSLog(@"newStrWithoutSpace = %@", newStrWithoutSpace);
    NSLog(@"destStr = %@", destStr);
}

/**
 将http:**ios.itcast.cn*ios*images*content_25.jpg中的*替换为/
 */
- (void)replaceString {
    NSString *str = @"http:**ios.itcast.cn*ios*images*content_25.jpg";
    
    // Replacing : 替换
    // Occurrences : 出现
    //  用/替换所有出现的*
    NSString *newStr = [str stringByReplacingOccurrencesOfString:@"*" withString:@"/"];
    NSLog(@"%@", newStr);
}

/**
 用3种方法将下面字符串中的中文截取出来
 <itcast>传智播客</itcast>
 */
- (void)substring {
    NSString *str = @"<itt>传智</itt>";
    
    // 不建议采取
    //        NSRange range;
    //        range.location = 8;
    //        range.length = 4;
    //        NSString *substr = [str substringWithRange:range];
    
    // 1.方法1
    //        NSRange range;
    //        range.location = [str rangeOfString:@">"].location + 1;
    //        range.length = [str rangeOfString:@"</"].location - range.location;
    
    /**
     typedef struct _NSRange {
     NSUInteger location;
     NSUInteger length;
     } NSRange;
     */
    NSUInteger loc = [str rangeOfString:@">"].location + 1;
    NSUInteger len = [str rangeOfString:@"</"].location - loc;
    //        NSRange range = {loc, len};
    //        NSRange range = {.length = len, .location = loc};
    NSRange range = NSMakeRange(loc, len);
    NSString *substr = [str substringWithRange:range];
    NSLog(@"%@", substr);
    
    // 2.方法2
    // <it>传智</it>  ---> 传智</it>  --> 传智
    // <it>传智</it>  ---> <it>传智  --> 传智
    //        NSUInteger from = [str rangeOfString:@">"].location + 1;
    //        NSString *substr = [str substringFromIndex:from];
    //        // 传智</it>
    //        NSUInteger to = [substr rangeOfString:@"<"].location;
    //        NSString *destStr = [substr substringToIndex:to];
    //        NSLog(@"%@", destStr);
}

// NSMutableString====================================================
- (void)testNSMutableString {
 // 1.将file://ios.itcast.cn/ios/images/content_25.jpg中的file替换为http
//        NSMutableString *str = [NSMutableString stringWithString:@"file://ios.itcast.cn/ios/images/content_25.jpg"];
        NSMutableString *str = [NSMutableString string];
        // 设置整个字符串的内容
        str.string = @"file://ios.itcast.cn/ios/images/content_25.jpg";
        
        // 替换
//        NSRange range = NSMakeRange(0, str.length);
        NSLog(@"%@", str);
//        [str replaceOccurrencesOfString:@"file" withString:@"http" options:0 range:range];
        
        [str replaceCharactersInRange:[str rangeOfString:@"file"] withString:@"http"];
        
        NSLog(@"%@", str);
        
        // 将字符串拼接到最后面
//        [str appendString:@"abc"];
        
        // 设置整个字符串的所有内容
//        str.string = @"def";
        
        
        // 这种方法会产生新的字符串对象
//        NSString *str = @"file://ios.itcast.cn/ios/images/content_25.jpg";
//
//        NSString *newStr = [str stringByReplacingOccurrencesOfString:@"file" withString:@"http"];
//
//        NSLog(@"str=%@", str);
//        NSLog(@"newStr=%@", newStr);
}
- (void)insertString {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"itcast"];
    [str insertString:@"http://" atIndex:0];
    NSLog(@"%@", str);
}

/**
 不建议采取（会产生很多临时的字符串对象）
 */
- (void)appendString4 {
    // 1.将10个itcast拼接起来, 中间用空格隔开
    // 目标字符串
    NSString *destStr = @"";
    
    // 拼接字符串
    for (int i = 0; i<10; i++) {
        destStr = [destStr stringByAppendingString:@" itcast"];
    }
    
    destStr = [destStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    
    NSLog(@"-%@-", destStr);
}

- (void)appendString3 {
    // 1.将10个itcast拼接起来, 中间用空格隔开
    NSMutableString *destStr = [NSMutableString string];
    for (int i = 0; i<10; i++) {
        [destStr appendString:@" itcast"];
    }
    
    // 2.删除最后一个空格
    [destStr deleteCharactersInRange:NSMakeRange(0, 1)];
    // [destStr deleteCharactersInRange:NSMakeRange(destStr.length - 1, 1)];
    
    NSLog(@"--%@--", destStr);
}

- (void)deleteString {
    NSMutableString *str = [NSMutableString string];
    [str appendString:@"http://itcast"];
    NSLog(@"初始化：%@", str);
    
    //        [str deleteCharactersInRange:NSMakeRange(0, 7)];
    
    // 结合rangeOfString和deleteCharactersInRange方法能准确删除某个固定的字符串
    NSRange range = [str rangeOfString:@"itcast"];
    [str deleteCharactersInRange:range];
    
    NSLog(@"删除后：%@", str);
}

- (void)appendString2 {
    // 1.将10个itcast拼接起来, 中间用空格隔开, 最后写入文件中
    NSString *substr = @"itcast";
    
    NSMutableString *destStr = [NSMutableString string];
    for (int i = 0; i<10; i++) {
        //            if (i != 0) {
        if (i) { // 只有i不等于
            [destStr appendString:@" "];
        }
        [destStr appendString:substr];
    }
    
    [destStr writeToFile:@"/Users/apple/Desktop/dest.txt" atomically:YES encoding:NSUTF8StringEncoding error:nil];
}

- (void)appendString {
    // 不可变
    NSString *str = @"Jack";
    
    // 可变
    NSMutableString *str2 = [NSMutableString string];
    
    [str2 appendString:@"Rose"];
    [str2 appendString:@" love  "];
    [str2 appendString:@"Jack."];
    
    int age = 20;
    [str2 appendFormat:@"My age is %d", age];
    
    NSLog(@"%@", str2);

}

@end
