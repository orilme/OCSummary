//
//  User.h
//  ArchiveDemo1
//
//  Created by LaoWen on 15-5-10.
//  Copyright (c) 2015年 LaoWen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AutoArchiveObject : NSObject <NSCoding>

@property (nonatomic, assign)int age;
@property (nonatomic, assign)float weight;
@property (nonatomic, copy)NSString *userName;
@property (nonatomic, copy)NSString *password;

@end
