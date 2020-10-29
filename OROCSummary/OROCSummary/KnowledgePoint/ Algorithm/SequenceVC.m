//
//  SequenceVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/3/26.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "SequenceVC.h"

@interface SequenceVC ()

@end

@implementation SequenceVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    NSMutableArray *arr = [[NSMutableArray alloc] initWithObjects:@(6000), @(1000), @(2000), @(5000), @(10000), @(9000), @(4000), @(3000), @(7000), nil];
    
    // 冒泡排序
    [self foolSortArray:arr];
    
    // 选择排序
    //[self selectSortArray:arr];
    
    // 插入排序
    //[self insertSortArray:arr];
    //[self binaryInsertSortArray:arr];
    
    // 希尔排序
    //[self shellSortArray:arr];
    
    // 堆排序
    //[self heapSortArray:arr len:arr.count];
    
    // 归并排序
    //arr = [self mergeSortArray:arr].copy;
    
    // 快速排序
    //[self quickSortArray:arr withLeftIndex:0 andRightIndex:arr.count - 1];
    
    NSLog(@"排序结果---%@", arr);
    
    // 二分查找法
    //NSInteger dest = [self dichotomySearch:arr target:@(1)];
    //NSLog(@"二分查找法---%ld", (long)dest);

}

#pragma mark - 冒泡排序（依次循环旁边的比较放到后边去）
/**
 最好时间复杂度是O(n)
 最坏时间复杂度是O(n^2)
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 */
- (void)foolSortArray:(NSMutableArray *)array {
    for (int i = 0; i < array.count-1; i++) {
        for (int j = 0; j < array.count-i-1; j++) {
            if (array[j] > array[j+1]) {
                id tmp = array[j];
                array[j] = array[j+1];
                array[j+1] = tmp;
            }
        }
    }
}

#pragma mark - 选择排序（拿前边的和后边的依次比较放到前边去，就是先排好前边的）
/**
 最好时间复杂度是O(n)
 最坏时间复杂度是O(n^2)
 平均时间复杂度：O(n^2)
 平均空间复杂度：O(1)
 */
- (void)selectSortArray:(NSMutableArray *)array {
    for (int i = 0; i < array.count-1; i++) {
        for (int j = i+1; j < array.count; j++) {
            if (array[i] > array[j]) {
                id tmp = array[i];
                array[i] = array[j];
                array[j] = tmp;
            }
        }
    }
}

#pragma mark - 插入排序
- (void)insertSortArray:(NSMutableArray *)array {
    for (int i = 1; i < [array count]; i++) {
        int j = i;
        NSInteger temp = [[array objectAtIndex:i] integerValue];
        while (j > 0 && temp < [[array objectAtIndex:j - 1] integerValue]) {
            [array replaceObjectAtIndex:j withObject:[array objectAtIndex:(j - 1)]];
            j--;
        }
        [array replaceObjectAtIndex:j withObject:[NSNumber numberWithInteger:temp]];
    }
}

// 折半插入排序
- (void)binaryInsertSortArray:(NSMutableArray *)array {
    for (int i = 1; i < [array count]; i++) {
        NSInteger temp = [[array objectAtIndex:i] integerValue];
        int left = 0;
        int right = i - 1;
        while (left <= right) {
            int middle = (left + right) / 2;
            if (temp < [[array objectAtIndex:middle] integerValue]) {
                right = middle - 1;
            }else{
                left = middle + 1;
            }
        }
        for (int j = i; j > left; j--) {
            [array replaceObjectAtIndex:j withObject:[array objectAtIndex:j-1]];
        }
        [array replaceObjectAtIndex:left withObject:[NSNumber numberWithInteger:temp]];
    }
}

#pragma mark - 希尔排序
/**
 最优的增量在最坏的情况下时间复杂度为O(n²⁄³)，最坏的情况下仍为O(n²)
 需要注意的是，增量序列的最后一个增量值必须等于1才行
 另外由于记录是跳跃式的移动，希尔排序并不是一种稳定的排序算法
 */
- (void)shellSortArray:(NSMutableArray *)array {
    int count = (int)array.count;
    // 初始增量为数组长度的一半，然后每次除以2取整
    for (int increment = count/2; increment > 0; increment/=2) {
        // 初始下标设为第一个增量的位置，然后递增
        for (int i = increment; i<count; i++) {
            // 获取当前位置
            int j = i;
            // 然后将此位置之前的元素，按照增量进行跳跃式比较
            while (j-increment>=0 && [array[j] integerValue]<[array[j-increment] integerValue]) {
                [array exchangeObjectAtIndex:j withObjectAtIndex:j-increment];
                j-=increment;
            }
        }
    }
}

#pragma mark - 快速排序
/**
 最理想情况算法时间复杂度O(nlogn)，最坏O(n^2),平均O(nlogn)
 平均空间复杂度：O(nlogn)       O(nlogn)~O(n^2)
 */
- (void)quickSortArray:(NSMutableArray *)array withLeftIndex:(NSInteger)leftIndex andRightIndex:(NSInteger)rightIndex {
    if (leftIndex >= rightIndex) { // 如果数组长度为0或1时返回
        return ;
    }
    
    NSInteger i = leftIndex;
    NSInteger j = rightIndex;
    NSInteger key = [array[i] integerValue]; // 记录比较基准数
    
    while (i < j) {
        /**** 首先从右边j开始查找比基准数小的值 ***/
        while (i < j && [array[j] integerValue] >= key) { // 如果比基准数大，继续查找
            j--;
        }
        // 如果比基准数小，则将查找到的小值调换到i的位置
        array[i] = array[j];
        
        /**** 当在右边查找到一个比基准数小的值时，就从i开始往后找比基准数大的值 ***/
        while (i < j && [array[i] integerValue] <= key) { // 如果比基准数小，继续查找
            i++;
        }
        // 如果比基准数大，则将查找到的大值调换到j的位置
        array[j] = array[i];
        
    }
    
    // 将基准数放到正确位置
    array[i] = @(key);
    
    /**** 递归排序 ***/
    // 排序基准数左边的
    [self quickSortArray:array withLeftIndex:leftIndex andRightIndex:i - 1];
    // 排序基准数右边的
    [self quickSortArray:array withLeftIndex:i + 1 andRightIndex:rightIndex];
}

#pragma mark - 堆排序
/**
 时间复杂度为O(nlogn)
 */
- (void)heapSortArray:(NSMutableArray *)heapList len:(NSInteger)len {
    // 建立堆，从最底层的父节点开始
    for(NSInteger i = (heapList.count/2 -1); i>=0; i--)
        [self adjustHeap:heapList location:i len:heapList.count];
    
    for(NSInteger i = heapList.count -1; i >= 0; i--){
        NSInteger maxEle = ((NSString *)heapList[0]).integerValue;
        heapList[0] = heapList[i];
        heapList[i] = @(maxEle).stringValue;
        
        [self adjustHeap:heapList location:0 len:i];
    }
}

- (void)adjustHeap:(NSMutableArray *)heapList location:(NSInteger)p len:(NSInteger)len {
    NSInteger curParent = ((NSString *)heapList[p]).integerValue;
    NSInteger child = 2*p + 1;
    while (child < len) {
        // left < right
        if (child+1 < len && ((NSString *)heapList[child]).integerValue < ((NSString *)heapList[child+1]).integerValue) {
            child ++;
        }
        if (curParent < ((NSString *)heapList[child]).integerValue) {
            heapList[p] = heapList[child];
            p = child;
            child = 2*p + 1;
        }
        else
            break;
    }
    heapList[p] = @(curParent).stringValue;
}

#pragma mark - 归并排序
/**
 时间复杂度为O(nlogn)
（1）“分解”——将序列每次折半划分
（2）“合并”——将划分后的序列段两两合并后排序
 */
- (NSArray *)mergeSortArray:(NSMutableArray *)array {
    // 排序数组
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:1];
    // 第一趟排序是的子数组个数为ascendingArr.count
    for (NSNumber *num in array) {
        NSMutableArray *subArray = [NSMutableArray array];
        [subArray addObject:num];
        [tempArray addObject:subArray];
    }
    /**
     分解操作 每一次归并操作
     当数组个数为偶数时tempArray.count/2; 当数组个数为奇数时tempArray.count/2+1; 当tempArray.count == 1时，归并排序完成
     */
    while (tempArray.count != 1) {
        NSInteger i = 0;
        
        // 当数组个数为偶数时 进行合并操作， 当数组个数为奇数时，最后一位轮空
        while (i < tempArray.count - 1) {
            
            // 将i 与i+1 进行合并操作 将合并结果放入i位置上 将i+1位置上的元素删除
            tempArray[i] = [self mergeArrayFirstList:tempArray[i] secondList:tempArray[i + 1]];
            [tempArray removeObjectAtIndex:i + 1];
            
            // i++ 继续下一循环的合并操作
            i++;
        }
    }

    return tempArray.copy;
}
// 合并
- (NSArray *)mergeArrayFirstList:(NSArray *)array1 secondList:(NSArray *)array2 {
    
    // 合并序列数组
    NSMutableArray *resultArray = [NSMutableArray array];
    
    // firstIndex是第一段序列的下标 secondIndex是第二段序列的下标
    NSInteger firstIndex = 0, secondIndex = 0;
    
    // 扫描第一段和第二段序列，直到有一个扫描结束
    while (firstIndex < array1.count && secondIndex < array2.count) {
        // 判断第一段和第二段取出的数哪个更小，将其存入合并序列，并继续向下扫描
        if ([array1[firstIndex] floatValue] < [array2[secondIndex] floatValue]) {
            [resultArray addObject:array1[firstIndex]];
            firstIndex++;
        } else {
            [resultArray addObject:array2[secondIndex]];
            secondIndex++;
        }
    }
    // 若第一段序列还没扫描完，将其全部复制到合并序列
    while (firstIndex < array1.count) {
        [resultArray addObject:array1[firstIndex]];
        firstIndex++;
    }
    // 若第二段序列还没扫描完，将其全部复制到合并序列
    while (secondIndex < array2.count) {
        [resultArray addObject:array2[secondIndex]];
        secondIndex++;
    }
    // 返回合并序列数组
    return resultArray.copy;
}

#pragma mark - 二分查找
/**
 二分查找法只适用于已经排好序的查找
 */
- (NSInteger)dichotomySearch:(NSArray *)array target:(id)key {
    NSInteger left = 0;
    NSInteger right = [array count] - 1;
    NSInteger middle;
    
    while (right >= left) {
        middle = (right + left) / 2;
        
        if (array[middle] == key) {
            return middle;
        }
        
        if (array[middle] > key) {
            right = middle - 1;
        }else if (array[middle] < key) {
            left = middle + 1;
        }
    }
    return -1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
