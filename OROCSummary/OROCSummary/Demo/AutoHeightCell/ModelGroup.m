//
//  ModelGroup.m
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import "ModelGroup.h"

@implementation ModelGroup
+ (NSMutableArray *)groupWithNameOfContent:(NSString *)name{
    NSMutableArray*dataArr = [NSMutableArray arrayWithCapacity:0];
    NSMutableArray*arr     = [ NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle]
                                                                       pathForResource:name
                                                                       ofType:nil]];
    for (NSDictionary*dic  in arr) {
        MitchellModel*mo = [MitchellModel modelWithDict:dic];
        [dataArr addObject: mo];
    }
    
    
    return dataArr;
}
@end
