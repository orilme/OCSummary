//
//  ProtocolNurse.h
//  03-利用protocol实现代理设计模式
//
//  Created by MLJ on 14-5-16.
//  Copyright (c) 2014年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol ProtocolBabyDelegate;

@interface ProtocolNurse : NSObject <ProtocolBabyDelegate>

@end
