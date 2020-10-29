//
//  StudyProtocol.h
//  ORIOSSummary
//
//  Created by orilme on 2019/12/4.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
@protocol 协议名称
// 方法声明
@end
*/
@protocol StudyProtocol <NSObject>
@optional
- (void)doHomework;

@required
- (void)readBook;
@end
