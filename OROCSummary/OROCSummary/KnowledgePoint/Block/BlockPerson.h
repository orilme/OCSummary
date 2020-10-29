//
//  BlockPerson.h
//  ORIOSSummary
//
//  Created by orilme on 2019/12/6.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlockPerson : NSObject

- (BlockPerson *(^)(NSString *name))study;
- (BlockPerson *(^)())run;

@end
