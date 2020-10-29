//
//  YSHYZoomScrollView.h
//  YSHYImageView
//
//  Created by 杨淑园 on 15/10/13.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YSHYZoomScrollView;
typedef void(^TapMRZoomScrollviewBlock)(YSHYZoomScrollView * zoomScrollView);

@protocol YSHYZoomScrollViewDelegate <NSObject>

-(void)tapGesture;

@end

@interface YSHYZoomScrollView : UIScrollView <UIScrollViewDelegate>

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, assign)id<YSHYZoomScrollViewDelegate> zoomScrolleViewDelegate;
@property (nonatomic, copy)TapMRZoomScrollviewBlock tapMRZoomScrollviewBlock;

-(void)setImageViewFrame:(UIImage *)image;
@end
