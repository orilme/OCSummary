//
//  CZLockView.h
//  B04.手势解锁
//
//  Created by apple on 15-1-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZLockView;

@protocol CZLockViewDelegate <NSObject>

-(void)lockView:(CZLockView *)lockView didSeletedPassowrd:(NSString *)password;

@end

@interface CZLockView : UIView

 @end
