//
//  SDWebImageSimulateModel.h
//  ORIOSSummary
//
//  Created by orilme on 2019/4/6.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SDWebImageSimulateModel : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *icon;

@property(nonatomic,copy)NSString *download;

/**
 保存网络下载下来的图像
 */
//@property(nonatomic,strong)UIImage *image;


+ (instancetype)appWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
