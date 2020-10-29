//
//  People.h
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>

// 把成员变量做成公用的，在类的外部可以随意访问，就可能出现不合理的或不合法的值，而且在一定程度上破坏了封装，所以尽量少用
// 做成保护或私有的可以在getter,setter内部对参数做一些检查，防止不合法或不合理值的存在
@interface People : NSObject {
    
@public//表明访问权限是公有的，在类的外部内部子类中都能访问
    int _age;
    int _weight;
    
@protected//访问权限是受保护的，这也是默认的访问权限，在类的外部不能能直接访问，在类的内部及子类中可以访问
    int _money;
    
@private//访问权限是私有的，在类的外部和子类中都不能访问，在类的内部能访问
    int _secretary;
    
}

- (void)saySelf;

@end
