//
//  TakeAPictureView.h
//  自定义相机
//
//  Created by macbook on 16/9/2.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TakeAPictureView : UIView

- (void)startRunning;
- (void)stopRunning;

// 拍照
- (void)takeAPicture;

// 切换前后镜头
- (void)setFrontOrBackFacingCamera:(BOOL)isUsingFrontFacingCamera;

// 写入本地
- (void)writeToSavedPhotos;

// 获取拍照后的图片
@property (nonatomic, copy) void (^getImage)(UIImage *image);

// 是否写入本地
@property (nonatomic, assign) BOOL shouldWriteToSavedPhotos;


@end
