//
//  BlockTwoVC.m
//  OROCSummary
//
//  Created by orilme on 2019/12/6.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "BlockTwoVC.h"

@interface BlockTwoVC ()

@end

@implementation BlockTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(20, 400, Screen_Width - 40, 80)];
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(onBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    [self sortedArrayBlock];
}

- (void)onBtnClick {
    if (self.certainBlock) {//判断有没有指定block
        self.certainBlock(@"悟空", @"7399393939");//调用block反向传值
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)sortedArrayBlock {
    NSMutableArray *stringsArray = [NSMutableArray arrayWithObjects:
                             @"string 1",
                             @"String 21",
                             @"string 12",
                             @"String 11",
                             @"String 02", nil];
    static NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch | NSNumericSearch | NSWidthInsensitiveSearch | NSForcedOrderingSearch;
    NSLocale *currentLocale = [NSLocale currentLocale];
    NSComparator finderSortBlock = ^(id string1, id string2) {
        NSRange string1Range = NSMakeRange(0, [string1 length]);
        [stringsArray addObject:@"111"];
        return [string1 compare:string2 options:comparisonOptions range:string1Range locale:currentLocale];
    };
    
    NSArray *finderSortArray = [stringsArray sortedArrayUsingComparator:finderSortBlock];
    /*
    Output:
    finderSortArray: (
    "string 1",
    "String 02",
    "String 11",
    "string 12",
    "String 21"
    )
    */
    NSLog(@"finderSortArray: %@", finderSortArray);
}

// __block变量
//你 可以使用一个 block 来计数多少个字符串和 block 中只读变量 currentLocal 相同:
- (void)sortedArrayBlock2 {
     NSArray *stringsArray = [NSArray arrayWithObjects:
                              @"string 1",
                              @"String 21",
                              @"string 12",
                              @"String 11",
                              @"Strîng 21",
                              @"Striñg 21",
                              @"String 02", nil];
    NSLocale *currentLocale = [NSLocale currentLocale];
    __block NSUInteger orderedSameCount = 0;
    NSArray *diacriticInsensitiveSortArray = [stringsArray sortedArrayUsingComparator:^(id string1, id string2) {
        NSRange string1Range = NSMakeRange(0, [string1 length]);
        NSComparisonResult comparisonResult = [string1 compare:string2 options:NSDiacriticInsensitiveSearch range:string1Range locale:currentLocale];
        if (comparisonResult == NSOrderedSame) {
            orderedSameCount++;
        }
        return comparisonResult;
    }];
    NSLog(@"diacriticInsensitiveSortArray: %@", diacriticInsensitiveSortArray);
    NSLog(@"orderedSameCount: %lu", (unsigned long)orderedSameCount);
      /*
       Output:
          diacriticInsensitiveSortArray: (
           "String 02",
           "string 1",
           "String 11",
           "string 12",
           "String 21",
           "Str\U00eeng 21",
           "Stri\U00f1g 21"
           )
           2011-12-09 | © 2011 YouMi Mobile Co. Ltd. All Rights Reserved. [5]

        Blocks Programming Topics
         
      orderedSameCount: 2
      */
    
}
 
@end
