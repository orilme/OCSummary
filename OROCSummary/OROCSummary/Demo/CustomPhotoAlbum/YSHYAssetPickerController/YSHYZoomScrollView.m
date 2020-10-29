//
//  YSHYZoomScrollView.m
//  YSHYImageView
//
//  Created by 杨淑园 on 15/10/13.
//  Copyright © 2015年 yangshuyaun. All rights reserved.
//

#import "YSHYZoomScrollView.h"

#define kScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight     [[UIScreen mainScreen]bounds].size.height
@implementation YSHYZoomScrollView

//@synthesize imageView;

- (id)init
{
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.delegate = self;
        [self initImageView];
    }
    return self;
}

- (void)initImageView
{
    self.imageView = [[UIImageView alloc]init];
    [self.imageView setFrame:CGRectMake(0, 0, kScreenWidth,kScreenHeight)];
    [self.imageView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
    [self.imageView setBackgroundColor:[UIColor whiteColor]];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.userInteractionEnabled = YES;
    
    [self addSubview:self.imageView];
    UITapGestureRecognizer *tapGesture =[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(tapGesture:)];
    [self addGestureRecognizer:tapGesture];
    self.maximumZoomScale = 4.0;
}

//根据image的大小设置 imageView的大小
-(void)setImageViewFrame:(UIImage *)image
{
    [self.imageView setImage:image];
    CGSize  size =  image.size;
    CGFloat ration = size.height/size.width?size.height/size.width:1;
    CGSize newSize = CGSizeMake(kScreenWidth, kScreenWidth * ration);
    [self.imageView setFrame:CGRectMake(0, 0, newSize.width, newSize.height)];
    self.contentSize = self.imageView.frame.size;
    if(newSize.height < kScreenHeight)
    {
        [self.imageView setCenter:CGPointMake(kScreenWidth/2, kScreenHeight/2)];
    }
}

#pragma mark - Zoom methods

-(void)tapGesture:(UITapGestureRecognizer *)gesture
{
    self.tapMRZoomScrollviewBlock(self);
}

#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
     scrollView.scrollEnabled = YES;
    [scrollView setZoomScale:scale animated:NO];
}

//实现图片在缩放过程中居中
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?(scrollView.bounds.size.width - scrollView.contentSize.width)/2 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?(scrollView.bounds.size.height - scrollView.contentSize.height)/2 : 0.0;
    self.imageView.center = CGPointMake(scrollView.contentSize.width/2 + offsetX,scrollView.contentSize.height/2 + offsetY);
}


@end
