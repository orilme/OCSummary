//
//  MitchellModel.m
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import "MitchellModel.h"

@implementation MitchellModel

+ (instancetype)modelWithDict:(NSDictionary *)dict{
    MitchellModel*vi = [[MitchellModel alloc] init];
    [vi setValuesForKeysWithDictionary:dict];
    return vi;
}
@end
