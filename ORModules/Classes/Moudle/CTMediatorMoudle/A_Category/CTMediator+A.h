//
//  CTMediator+A.h
//  A_Category
//
//  Created by casa on 2016/12/10.
//  Copyright © 2016年 casa. All rights reserved.
//

#import <CTMediator/CTMediator.h>
#import <UIKit/UIKit.h>

@interface CTMediator (A)

- (UIViewController *)A_Category_Swift_ViewControllerWithCallback:(void(^)(NSString *result))callback;
- (UIViewController *)A_Category_Objc_ViewControllerWithCallback:(void(^)(NSString *result))callback;

@end
