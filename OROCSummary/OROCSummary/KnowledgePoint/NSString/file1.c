//
//  file1.c
//  static
//
//  Created by LaoWen on 15/12/31.
//  Copyright (c) 2015年 LaoWen. All rights reserved.
//

#include "file1.h"

//static的用法二：
//限制全局变量的作用域为当前文件，即只在当前文件有效
static int count = 0;

void file1SetCount()
{
    count = 5;
}

void file1PrintCount()
{
    printf("file1, count---%d\n", count);
}
