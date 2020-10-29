//
//  DemoViewController.h
//  02.UIDynamic演练
//
//  Created by apple on 13-12-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum
{
    kDemoFunctionSnap = 0,
    kDemoFunctionPush,
    kDemoFunctionAttachment,
    kDemoFunctionSpring,
    kDemoFunctionCollision,
    
} kDemoFunction;

@interface DemoViewController : UIViewController

// 要演练的功能类型
@property (nonatomic, assign) kDemoFunction function;

@end
