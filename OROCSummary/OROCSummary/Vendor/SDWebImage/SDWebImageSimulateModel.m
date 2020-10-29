//
//  SDWebImageSimulateModel.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/6.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "SDWebImageSimulateModel.h"

@implementation SDWebImageSimulateModel

+ (instancetype)appWithDict:(NSDictionary *)dict {
    SDWebImageSimulateModel *app = [[self alloc] init];
    
    [app setValuesForKeysWithDictionary:dict];
    
    return app;
}

@end
