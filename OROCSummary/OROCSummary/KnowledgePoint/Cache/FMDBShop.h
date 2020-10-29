//
//  FMDBShop.h
//  将任意对象存进数据库
//
//  Created by orilme on 2019/12/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBShop : NSObject <NSCoding>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) double  price;
@end
