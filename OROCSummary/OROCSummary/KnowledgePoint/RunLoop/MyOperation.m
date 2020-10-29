//
//  MyOperation.m
//  RunLoop
//
//  Created by LaoWen on 16/3/11.
//  Copyright (c) 2016年 LaoWen. All rights reserved.
//

#import "MyOperation.h"

@implementation MyOperation
{
    NSURLConnection *_connection;
    NSMutableData *_responseData;
}

- (id)initWithUrl:(NSString *)strUrl target:(id)target selector:(SEL)selector
{
    if (self = [super init]) {
        self.strUrl = strUrl;
        self.target = target;
        self.selector = selector;
    }
    return self;
}

- (void)main
{
    _responseData = [[NSMutableData alloc]init];
    NSURL *url = [NSURL URLWithString:self.strUrl];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    _connection = [[NSURLConnection alloc]initWithRequest:request delegate:self];
    
    //输入源和RunLoop都是iOS里事件处理机制，互相配合完成（比如button的或定时器的）事件处理方法和代理的方法（比如NSURLConnection的代理方法）的调用。(就是输入源(事件)都是RunLoop调用的)
    //输入源：一般来说，需要处理事件的对象都有会有一个输入源（如button、手势、等等可交互的UI控件）。通过代理和用户交互的控件也有一个输入源（比如TableView、NSURLConnection等）。假如用户点了一个button或做了个手势或TableView要刷新或URLConnection收到了数据等等情况都叫做产生了一个事件，这个事件会被放入这个对象的输入源（换句话说，某个事件有事件要处理时，就会在这个对象的输入源中加入一个事件）
    //RunLoop：每个线程都有一个RunLoop。主线程的RunLoop是系统自动运行的，工作线程的RunLoop需要程序员手工运行。RunLoop会不停的检查它的所有输入源里是否有事件要处理，如果有事件要处理它就调用这个事件的事件处理方法（比如button的点击事件处理方法）或代理的方法（比如NSURLConnection的didReceiveData:）。在我们看来，就是一但有事件产生时，对象（控件）的事件处理方法就被系统自动调用了。
    //如果某个对象被销毁了，它对应的输入源也会被销毁（比如NSURLConnection完成了数据的下载或网络连接出错）。
    //如果当前线程的RunLoop一个输入源都没有了，就意味着它无事可做了，runUntilData就会返回。
    
    //使当前线程（工作线程）的RunLoop运行起来
    [[NSRunLoop currentRunLoop]runUntilDate:[NSDate distantFuture]];
    NSLog(@"after run");
}

//NSURLConnection的对象在哪个线程中创建，其代理方法就在哪个线程中运行
//在这里_connection是在工作线程中创建的，所以代理方法一定是在工作线程中运行
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    NSLog(@"didReceiveData");
    [_responseData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSLog(@"finishLoading");
    [self.target performSelector:self.selector withObject:_responseData];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"failWithError");
}

@end
