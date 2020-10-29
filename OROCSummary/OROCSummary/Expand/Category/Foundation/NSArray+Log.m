//
//  NSArray+Log.m
//  ORIOSSummary
//
//  Created by orilme on 2019/6/23.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "NSArray+Log.h"

@implementation NSArray (Log)

- (NSString *)descriptionWithLocale:(id)locale {
    //    return @"-----";
    /**
     (
     "\U5f20\U4e09",
     lisi,
     123
     )
     
     */
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    
    
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n",obj];
    }];
    
    [strM appendString:@")\n"];
    
    return strM;
}

@end
