//
//  MyOperation.h
//  RunLoop
//
//  Created by LaoWen on 16/3/11.
//  Copyright (c) 2016年 LaoWen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyOperation : NSOperation<NSURLConnectionDataDelegate>

- (id)initWithUrl:(NSString *)strUrl target:(id)target selector:(SEL)selector;

@property (nonatomic, copy)NSString *strUrl;
@property (nonatomic, retain)id target;
@property (nonatomic, assign)SEL selector;

@end
