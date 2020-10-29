//
//  RuntimeExploreInfo+RuntimeAddProperty.m
//  ORIOSSummary
//
//  Created by orilme on 2019/4/8.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "RuntimeExploreInfo+RuntimeAddProperty.h"
#import "objc/runtime.h"

@implementation RuntimeExploreInfo (RuntimeAddProperty)

static char kPhoneNumKey;

- (void)setPhoneNum:(NSString *)phoneNum {
    objc_setAssociatedObject(self, &kPhoneNumKey, phoneNum, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)phoneNum {
    return objc_getAssociatedObject(self, &kPhoneNumKey);
}

@end
