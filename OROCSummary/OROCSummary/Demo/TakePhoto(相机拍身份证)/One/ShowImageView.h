//
//  ShowImageView.h
//  自定义相机
//
//  Created by macbook on 16/9/6.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowImageView : UIView

@property (nonatomic, copy) void (^didClickSaveBtn)(void);
@property (nonatomic, copy) void (^didCancleSaveBtn)(void);
@property (nonatomic, strong) UIImage *image;

+ (instancetype)showImageView;

@end
