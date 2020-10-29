//
//  Programmer+Category.h
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "Programmer.h"

@interface Programmer (Category)

@property(nonatomic,copy) NSString *nameWithSetterGetter;   //设置setter/getter方法的属性

@property(nonatomic,copy) NSString *nameWithoutSetterGetter; //不设置setter/getter方法的属性，注意编译的警告部分

- (void) programCategoryMethod; //分类方法

@end
