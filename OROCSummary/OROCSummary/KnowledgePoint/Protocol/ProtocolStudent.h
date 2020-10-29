//
//  ProtocolStudent.h
//  ORIOSSummary
//
//  Created by orilme on 2019/12/4.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StudyProtocol.h"
#import "CrazyPlayProtocol.h"

@interface ProtocolStudent : NSObject <StudyProtocol, CrazyPlayProtocol>

@end
