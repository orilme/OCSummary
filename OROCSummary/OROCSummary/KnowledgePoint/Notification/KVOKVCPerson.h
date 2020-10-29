//
//  KVOKVCPerson.h
//  01-多线程网络
//
//  Created by apple on 14-8-21.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KVOKVCPerson : NSObject {
    @private
    float _height;
}
@property (nonatomic, assign) int age;
@property (nonatomic, strong) NSArray *books;
@end
