//
//  MitchellModel.h
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MitchellModel : NSObject
/**
 *
 */
@property(nonatomic,strong)NSString * name;
/**
 *
 */
@property(nonatomic,strong)NSString * icon;
/**
 *
 */
@property(nonatomic,strong)NSString * text;
/**
 *
 */
@property(nonatomic,assign)BOOL vip;
/**
 *
 */
@property(nonatomic,strong)NSString * picture;

/**
 *  framemodel
 */
+ (instancetype)modelWithDict:(NSDictionary*)dict;
@end
