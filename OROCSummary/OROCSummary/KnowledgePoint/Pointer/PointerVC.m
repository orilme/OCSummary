//
//  PointerVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/20.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "PointerVC.h"

@interface PointerVC ()

@end

@implementation PointerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    int array[4] = {10, 20, 30, 40};
    
    // 1.==========================
    // array == &array[0]
    // 数组名 == 首元素的地址 == 认为是指向首元素的指针
    int *p = array; // p : 存储的是第0个元素的值10
    NSLog(@"*p---%d", *p);
    for (int i = 0; i<4; i++) {
        NSLog(@"p---%d", *(p + i));
    }
    
    int *p1 = &array[3];
    NSLog(@"p1---%d", *(p1 - 2));

    // 2.==========================
    int *p2 = array; // 指向首元素的指针,指向4个字节的空间
    int (*p3)[4] = &array; // 指向数组的指针,指向16个空间
    NSLog(@"p2---%p", p2);
    NSLog(@"p3---%p", p3);
    NSLog(@"array + 1 ---%p", array + 1);
    NSLog(@"&array + 1---%p", &array + 1);
    
    // 2.==========================
    int *p4 = (int *)(&array + 1);
    NSLog(@"p4---%d", *(p4 - 1));
    double *p5 = (double *)(&array + 1);
    NSLog(@"p5---%f", *(p5 - 1));
    NSLog(@"p5---%d", *(int *)(p5 - 1));
    
    // 3.二维数组==========================
    /*
     * a[0]; // a[0][0]的地址,指向a[0][0]元素的指针,指向4个字节的空间
     * a[1]; // a[1][0]的地址,指向a[1][0]元素的指针,指向4个字节的空间
     * a; // a[0]的地址,指向a[0]的指针,指向12个字节的空间
     * &a; // a的地址,指向a的指针,指向24个字节的空间
     */
    int a[2][3] = {{10, 20, 30}, {100, 200, 300}};
    int *p6 = (int *)(a + 1);
    NSLog(@"p6---%d", *(p6 - 2));
    
    
    // 反转二叉树
//    func invertTree (root) {
//        if (root != null) {
//            var temp = root.left
//            root.left = root.right
//            root.right = temp
//            invertTree(root.left)
//            invertTree(root.right)
//        }
//        return root
//    }
    
}


@end
