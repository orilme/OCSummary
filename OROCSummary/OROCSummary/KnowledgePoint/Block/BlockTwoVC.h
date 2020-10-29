//
//  BlockTwoVC.h
//  ORIOSSummary
//
//  Created by orilme on 2019/12/6.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <UIKit/UIKit.h>

//用于反向传值（用户名、密码）的Block类型
typedef void (^BlockOK)(NSString *userName, NSString *password);

@interface BlockTwoVC : UIViewController

@property (nonatomic, copy)BlockOK certainBlock;//用于反向传值的block

@end
