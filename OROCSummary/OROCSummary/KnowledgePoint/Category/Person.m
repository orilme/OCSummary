//
//  Person.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "Person.h"

@interface Person ()

@property(nonatomic,copy)NSString *personPrivateName;

@end


@implementation Person

- (void)eat {
    NSLog(@"%@",self);
}

@end
