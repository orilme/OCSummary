//
//  FileManagerVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "FileManagerVC.h"

@interface FileManagerVC ()

@end

@implementation FileManagerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    // NSData ： 存放二进制字节数据
    NSString *str = @"爆发后就开始客户机房环境快递顺丰快回家";
    // NSString --> NSData
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [mgr createFileAtPath:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/fileManager.text" contents:data attributes:nil];


    // 获得当前文件夹下面有哪些内容
    NSArray *contents = [mgr contentsOfDirectoryAtPath:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/" error:nil];
    NSLog(@"获得当前文件夹下面有哪些内容---%@", contents);
    
    NSArray *subpaths = [mgr subpathsOfDirectoryAtPath:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/" error:nil];
    NSLog(@"获得当前文件夹下包含子文件夹面有哪些内容---%@", subpaths);
    
    // 获得文件、文件夹的属性
    NSDictionary *attrs = [mgr attributesOfItemAtPath:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/" error:nil];
    NSLog(@"获得文件、文件夹的属性---%@", attrs[NSFileSize]);
    
    
    // 默认不是文件夹
    BOOL dir = NO;
    //BOOL exist = [mgr fileExistsAtPath:@"/Users/apple/Desktop/test.txt"];
    BOOL exist = [mgr fileExistsAtPath:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/" isDirectory:&dir];
    NSLog(@"文件是否存在：%d， 是否为文件夹：%d", exist, dir);
}

- (void)NSFileManagerDemo {
    //NSFileManager适用于文件管理的类
   //获取单例
   NSFileManager *fm = [NSFileManager defaultManager];
   //创建一个空文件,参数为一个文件的完整路径(绝对路径)
   [fm createFileAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated1.txt" contents:nil attributes:nil];
   
   //创建一个非空的文件
   NSString *strContent = @"hello";
   NSData *dateContent = [strContent dataUsingEncoding:NSUTF8StringEncoding];
   //参数一:要创建文件的绝对路径
   //参数二:文件内容
   //参数三:文件属性,nil表示默认属性
   //返回值:YES成功,NO失败
   BOOL ret = [fm createFileAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated2.txt" contents:dateContent attributes:nil];
   NSLog(@"%d",ret);
   
   //判断参数指定的文件是否存在
   //参数:文件的绝对路径
   //返回值:YES成功,NO失败
   ret = [fm fileExistsAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated2.txt"];
   NSLog(@"是否存在:%d",ret);
   
   BOOL isDir = NO;
   //判断参数一指定的文件或目录是否存在，如果存在进一步判断是不是目录
   //参数一：绝对路径
   //参数二：BOOL变量的地址，用于返回是否为目录
   //返回值：YES代表文件或目录存在，NO代表不存在
   ret = [fm fileExistsAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager" isDirectory:&isDir];//Directory目录
   if (ret) {
       if (isDir) {
           NSLog(@"是目录");
       } else {
           NSLog(@"是文件");
       }
   } else {
       NSLog(@"不存在");
   }
   
   NSError *error = nil;
   //返回某个目录下的所有文件和子目录(浅遍历)
   //参数一：目录的绝对路径
   //参数二：NSError*类型的地址，用于出错时返回错误信息
   //返回值：是个数组，包含指定目录下的所有文件和子目录，但是不包含子目录中的文件和子目录，这也叫浅遍历
   NSArray *contents= [fm contentsOfDirectoryAtPath:@"/Users/students/Desktop/BAO/OC8" error:&error];
   
   NSLog(@"浅遍历");
   NSLog(@"contents: %@", contents);
   
   //返回某个目录下所有的文件和子目录（深遍历）
   //遍历所有的子目录下的所有内容，参数同上
   contents = [fm subpathsOfDirectoryAtPath:@"/Users/students/Desktop/BAO/OC8" error:nil];
   NSLog(@"contents2: %@", contents);
   NSLog(@"深遍历");
   
   //拷贝文件，如果目标文件已经存在则拷贝失败
   //参数一：源文件的绝对路径
   //参数二：目标文件的绝对路径，注意：必须包含文件名
   //参数三：NSError*的地址，出错时返回错误信息
   //返回值：拷贝是否成功，成功YES，失败：NO
   ret = [fm copyItemAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated2.txt" toPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated21.txt" error:nil];
   NSLog(@"拷贝结果:%d", ret);
   
   //移动文件，参数与拷贝文件相同
   ret = [fm moveItemAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated2.txt" toPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated22.txt" error:nil];
   NSLog(@"移动结果：%d", ret);
   
   //删除文件
   ret = [fm removeItemAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated1.txt" error:nil];
   NSLog(@"删除结果:%d", ret);
   
   
   //获取文件属性，以文件大小为例
   NSDictionary *attributes = [fm attributesOfItemAtPath:@"/Users/students/Desktop/BAO/OC8/NSFileManager/OCCreated21.txt" error:nil];
   NSNumber *nFileSize = [attributes objectForKey:@"NSFileSize"];
   unsigned long long fileSize = nFileSize.unsignedLongLongValue;
   NSLog(@"fileSize: %lld", fileSize);
   
   //创建目录
   //参数一：目录的绝对路径
   //参数二：如果要创建的目录的上级目录不存在是否自动创建。YES代表自动创建，NO不自动创建且如果不存在就失败。
   //参数三：目录的属性，nil表示默认属性
   //参数四：失败时返回错误信息
   //返回值：YES创建成功，NO创建失败
   ret = [fm createDirectoryAtPath:@"/Users/students/Desktop/BAO/OC8/a/b" withIntermediateDirectories:YES attributes:nil error:&error];
   if (ret) {
       NSLog(@"创建目录成功");
   } else {
       NSLog(@"创建目录失败:%@", error);
   }
}

@end
