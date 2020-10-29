//
//  KVCPerson.h
//  KVC
//
//  Created by LaoWen on 16/2/25.
//  Copyright (c) 2016年 LaoWen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVCPerson : NSObject

@property (nonatomic, copy)NSString *nickName1;
@property (nonatomic, copy)NSString *nickName2;
@property (nonatomic, copy)NSString *nickName3;
@property (nonatomic, copy)NSString *nickName4;
@property (nonatomic, copy)NSString *nickName5;

@property (nonatomic, assign)int age;

+ (NSArray *)snsesFromJsonData:(NSData *)data;

@end
