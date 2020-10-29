//
//  User.m
//  ArchiveDemo1
//
//  Created by LaoWen on 15-5-10.
//  Copyright (c) 2015年 LaoWen. All rights reserved.
//
#import <objc/runtime.h>
#import "AutoArchiveObject.h"

@implementation AutoArchiveObject

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    NSString *clsName;
    Class cls = self.class;
    do {
        clsName = NSStringFromClass(cls);
        NSLog(@"clsName: %@", clsName);
        
        unsigned int count = 0;
        //获得所有成员变量列表
        Ivar *ivars = class_copyIvarList(cls, &count);
        
        for (int i = 0; i<count; i++) {
            
            // 取出i位置对应的成员变量
            Ivar ivar = ivars[i];
            
            // 查看成员变量
            const char *name = ivar_getName(ivar);
            
            const char *encoding = ivar_getTypeEncoding(ivar);
            NSLog(@"encoding: %s", encoding);
            
            // 归档
            NSString *key = [NSString stringWithUTF8String:name];
            NSLog(@"key: %@", key);
            //读取变量的值
            id value = [self valueForKey:key];
            NSLog(@"class:%@, value: %@",[value class], value);
            [aCoder encodeObject:value forKey:key];
        }
        
        free(ivars);
        
        cls = class_getSuperclass(self.class);
    } while (![clsName isEqualToString:@"AutoArchiveObject"]);
    
    
//    [aCoder encodeObject:_userName forKey:@"userName"];
//    [aCoder encodeObject:_password forKey:@"password"];
    //[aCoder encodeObject:self.weight forKey:@"weight"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        
        NSString *clsName;
        Class cls = self.class;
        do {
            clsName = NSStringFromClass(cls);
            NSLog(@"clsName: %@", clsName);
            
            unsigned int count = 0;
            Ivar *ivars = class_copyIvarList(cls, &count);
            
            for (int i = 0; i<count; i++) {
                // 取出i位置对应的成员变量
                Ivar ivar = ivars[i];
                
                // 查看成员变量
                const char *name = ivar_getName(ivar);
                
                // 归档
                NSString *key = [NSString stringWithUTF8String:name];
                id value = [aDecoder decodeObjectForKey:key];
                
                // 设置到成员变量身上
                [self setValue:value forKey:key];
            }
            
            free(ivars);
            
            cls = class_getSuperclass(self.class);
        } while (![clsName isEqualToString:@"AutoArchiveObject"]);
        
//        self.userName = [aDecoder decodeObjectForKey:@"userName"];
//        self.password = [aDecoder decodeObjectForKey:@"password"];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"username:%@, password%@, weight:%f, age:%d", _userName, _password, _weight, _age];
}

@end
