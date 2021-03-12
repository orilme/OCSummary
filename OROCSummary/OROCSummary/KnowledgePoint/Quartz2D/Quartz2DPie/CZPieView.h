//
//  CZPieView.h
//  A01.画饼状
//
//  Created by Apple on 15/1/2.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CZPieView : UIView


/**
 * 数据里只能放int @[@20,@30,@20,@30]
 */
@property (nonatomic,strong)NSArray   *sections;


/**
 *  指定不同section的饼状颜色
 */
@property (nonatomic,strong)NSArray   *sectionColors;

@end
