//
//  ScrollImageView.m
//  轮播图
//
//  Created by xiaoshi on 16/2/17.
//  Copyright © 2016年 kamy. All rights reserved.
//

#import "ScrollImageView.h"

@interface ScrollImageView()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;
@end

const static NSInteger imageCount = 5;

@implementation ScrollImageView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        [self initScrollViewImage];
        [self addTimer];
    }
    return self;
}

- (void)stopScroll {
    [self.timer invalidate];
    self.timer = nil;
}

#pragma private Method
- (void)initScrollViewImage
{
    //第一张图片(向前拖拽，为了循环，第一张图应该和显示的最后一张图一样)
    UIImageView *firstImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_5"]];
    firstImage.frame = CGRectMake(0, 0, ScrollWidth, ScrollHeight);
    [self.scrollView addSubview:firstImage];
    
    //最后一张图片(向后拖拽，为了循环，最后一张图应该和显示的第一张图一样)
    UIImageView *lastImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_1"]];
    lastImage.frame = CGRectMake((imageCount + 1) * ScrollWidth, 0, ScrollWidth, ScrollHeight);
    [self.scrollView addSubview:lastImage];
    //第二张图 → 倒数第二张图
    for (NSInteger i = 0; i < imageCount; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_%ld",i + 1]]];
        imageView.frame = CGRectMake(ScrollWidth * (i + 1), 0, ScrollWidth, ScrollHeight);
        [self.scrollView addSubview:imageView];
    }
    
    //开始显示第二张图片
    self.scrollView.contentOffset = CGPointMake(ScrollWidth, 0);
    self.scrollView.contentSize = CGSizeMake((imageCount + 2) * ScrollWidth, 0);
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.pagingEnabled = YES;
}

- (void)addTimer
{
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

- (void)nextPage
{
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = self.pageControl.currentPage;
    if (index == imageCount + 1) {
        index = 0;
    } else {
        index ++;
    }
    [self.scrollView setContentOffset:CGPointMake((index + 1) * scrollWidth, 0) animated:YES];
}

- (void)scrollViewFinish:(UIScrollView *)scrollView
{
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = (self.scrollView.contentOffset.x + scrollWidth * 0.5) / scrollWidth;
    if (index == imageCount + 1) {
        //显示最后一张的时候，强制设置为第二张（也就是轮播图的第一张），这样就开始无限循环了
        [self.scrollView setContentOffset:CGPointMake(scrollWidth, 0) animated:NO];
    } else if (index == 0) {
        //显示第一张的时候，强制设置为倒数第二张（轮播图最后一张），实现倒序无限循环
        [self.scrollView setContentOffset:CGPointMake(imageCount * scrollWidth, 0) animated:NO];
    }
}

#pragma mark - ScrollView Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSLog(@"滚动");
    CGFloat scrollWidth = self.scrollView.frame.size.width;
    NSInteger index = (self.scrollView.contentOffset.x + scrollWidth * 0.5) / scrollWidth;
    if (index == imageCount + 2) {
        index = 1;
    } else if (index == 0) {
        index = imageCount;
    }
    self.pageControl.currentPage = index - 1;
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    NSLog(@"开始拖动");
    [self.timer invalidate];
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self addTimer];
}

/**
 *  当滚动视图动画完成后，调用该方法，如果没有动画，那么该方法不会被调用，
 *  下面两个方法为有效的动画方法，
 *  setContentOffset:<#(CGPoint)#> animated:<#(BOOL)#>
 *  scrollRectToVisible:<#(CGRect)#> animated:<#(BOOL)#>
 */
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"滚动结束");
    //此方法，
    [self scrollViewFinish:scrollView];
}

/**
 *  滚动视图减速完成,滚动将停止时,调用该方法。一次有效滑动,只执行一次。
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSLog(@"减速至滚动停止");
    [self scrollViewFinish:scrollView];
}

#pragma mark - 懒加载
- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, ScrollWidth, ScrollHeight)];
        _scrollView.delegate = self;
    }
    return _scrollView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((ScrollWidth - 100) * 0.5f, ScrollHeight - 100, 100, 20)];
        _pageControl.numberOfPages = imageCount;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor yellowColor];
        _pageControl.currentPage = 0;
    }
    return _pageControl;
}
@end
