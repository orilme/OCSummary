//
//  YSHYAssetPickerController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//


#import "ShowBigViewController.h"
#import "YSHYZoomScrollView.h"
#import "YSHYAssetsCell.h"
#define IOS7LATER  [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0
@implementation ShowImage

-(id)init
{
    if (self = [super init])
    {
        
        self.stateOfSelect = YES;
        self.button = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.button setBackgroundImage:[UIImage imageNamed:@"isSeleted"] forState:UIControlStateNormal];
        [self.button setFrame:CGRectMake(0, 0, 30, 30)];
        [self.button addTarget:self action:@selector(cancelSelectedCurrentImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return  self;
}
-(void)cancelSelectedCurrentImage
{
//    [self.showBigViewControllerDelegate ChangeSendNumberWithCurrentState:self.stateOfSelect];
    [self.delegate navigationRightButtonClicked:self];
    if(self.stateOfSelect)
    {
        self.stateOfSelect= NO;
        [self.button setBackgroundImage:[UIImage imageNamed:@"No"] forState:UIControlStateNormal];
    }
    else
    {
        self.stateOfSelect = YES;
        [self.button setBackgroundImage:[UIImage imageNamed:@"isSeleted"] forState:UIControlStateNormal];
    }
    
}

@end

#pragma mark - ShowBigViewController

@interface ShowBigViewController ()

@property(strong, nonatomic) NSMutableArray *imageArray;
@property(assign, nonatomic) CGPoint currentPoint;
@property (strong, nonatomic) NSMutableArray *showImageArrary;
@property (assign, nonatomic) int sendNumber;
@property (nonatomic, strong) YSHYZoomScrollView *currentZoomScrollView;
@property (nonatomic, strong) YSHYZoomScrollView * lastZoomScrollView;


@end

@implementation ShowBigViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    self.sendNumber = (int)self.arrayOK.count;
    [self CreatUI];
    [self initData];
    [self showBigImage];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.popViewControllerBlock(self.removeArray);
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.navigationController.navigationBar.hidden = NO;
    
}
-(void)HandleHiddenNavigationBar
{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)initData
{
    for (int i = 0; i < self.arrayOK.count; i ++) {
        ShowImage *showImage = [[ShowImage alloc]init];
        showImage.delegate = self;
        showImage.theOrder = i;
        AssetObj * assetObj = self.arrayOK[i];
         UIImage *tempImg=[UIImage imageWithCGImage:assetObj.asset.defaultRepresentation.fullScreenImage];
        showImage.image= tempImg;
        showImage.stateOfSelect = YES;
        [self.showImageArrary addObject:showImage];
    }
    ShowImage *showimage = self.showImageArrary[0];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:showimage.button];
}

-(void)CreatUI{
    self.view.backgroundColor = [UIColor whiteColor];
    _scrollerview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    _scrollerview.delegate = self;
    _scrollerview.pagingEnabled = YES;
    [_scrollerview setShowsHorizontalScrollIndicator:NO];
    [_scrollerview setShowsVerticalScrollIndicator:NO];
    _scrollerview.contentSize = CGSizeMake((self.arrayOK.count) * (self.view.frame.size.width),0);
    _scrollerview.contentOffset = CGPointMake(0 , 0);
    [self.view addSubview:_scrollerview];

    //点击按钮，回到主发布页面
    _btnOK = [[UIButton alloc]initWithFrame:CGRectMake(kScreenWidth - 50 - 5, kScreenHeight - 64 -30 -5, 50, 30)];
    [_btnOK setBackgroundImage:[UIImage imageNamed:@"complete.png"] forState:UIControlStateNormal];
    [_btnOK setTitle:[NSString stringWithFormat:@"发送(%d)",self.sendNumber] forState:UIControlStateNormal];
    _btnOK .titleLabel.font = [UIFont systemFontOfSize:14.0];
    [_btnOK addTarget:self action:@selector(complete:) forControlEvents:UIControlEventTouchUpInside];
    [self.view insertSubview:_btnOK aboveSubview:_scrollerview];
    
    self.imageArray = [[NSMutableArray alloc]initWithCapacity:5];
    self.showImageArrary = [[NSMutableArray alloc]initWithCapacity:5];
    self.removeArray = [[NSMutableArray alloc]initWithCapacity:2];
    _currentIndex = 0;
    self.title = [NSString stringWithFormat:@"1/%d",(int)self.arrayOK.count];
}
-(void)showBigImage
{
    //显示选中的图片的大图
    for (int i=0; i<[self.showImageArrary count]; i++)
    {
        ShowImage *showImage = self.showImageArrary[i];
        YSHYZoomScrollView *zoomScrollView = [[YSHYZoomScrollView alloc]init];
        CGRect frame = _scrollerview.frame;
        frame.origin.x = frame.size.width * i;
        frame.origin.y = -22;
        zoomScrollView.frame = frame;
        [zoomScrollView setImageViewFrame:showImage.image];

        __block typeof (self)weakSelf = self;
        zoomScrollView.tapMRZoomScrollviewBlock = ^(YSHYZoomScrollView *view)
        {
             weakSelf.navigationController.navigationBar.hidden = !weakSelf.navigationController.navigationBar.hidden;
            if(!weakSelf.navigationController.navigationBar.hidden)
            {
                 [self performSelector:@selector(HandleHiddenNavigationBar) withObject:self afterDelay:3.0f];
            }
        };
        [_scrollerview addSubview:zoomScrollView];
    }
    [_scrollerview setContentOffset:CGPointMake(0, 0)];

}

#pragma  amrk - scrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    self.currentPoint = _scrollerview.contentOffset;
    int a = self.currentPoint.x   / _scrollerview.frame.size.width + 1 ;
    self.currentZoomScrollView = scrollView.subviews[a-1];
    for (int i = 0; i < scrollView.subviews.count; i ++)
    {
        YSHYZoomScrollView * zoomScrollView = scrollView.subviews[i];
        zoomScrollView.scrollEnabled = NO;
    }
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.currentPoint = _scrollerview.contentOffset;
    int b =self.currentPoint.x /_scrollerview.frame.size.width+1;
    _currentIndex = b-1 ;
    if( b > 0)
    {
        self.title =[ NSString stringWithFormat:@"%d/%lu",b,(unsigned long)self.showImageArrary.count];
        ShowImage * showImage = self.showImageArrary[b-1];
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:showImage.button];
    }
    self.lastZoomScrollView = self.currentZoomScrollView;
    self.currentZoomScrollView = scrollView.subviews[b-1];
    
    if(![self.lastZoomScrollView isEqual:self.currentZoomScrollView])
    {
        //让滑过去的image恢复默认大小
        float newScale = self.lastZoomScrollView.minimumZoomScale;
        [self.lastZoomScrollView scrollViewDidEndZooming:self.lastZoomScrollView withView:self.lastZoomScrollView.imageView atScale:newScale];
    }
}

#pragma  mark - 发送图片
-(void)complete:(UIButton *)sender{
    //发送到服务器
    [self.arrayOK removeObjectsInArray:self.removeArray];

    [self dismissViewControllerAnimated:YES completion:^{
        [self.removeArray removeAllObjects];
    }];
}
-(void)navigationRightButtonClicked:(ShowImage *)showImage
{
    [self ChangeSendNumberWithCurrentState:showImage];
}

-(void)ChangeSendNumberWithCurrentState:(ShowImage *)showImage
{
    YSHYAssetsCell * assetCell =(YSHYAssetsCell*)self.arrayOK[_currentIndex];
    
    if(showImage.stateOfSelect)
    {
        self.sendNumber --;
        [_btnOK setTitle:[NSString stringWithFormat:@"发送(%d)",self.sendNumber ] forState:UIControlStateNormal];
        [self.removeArray addObject:assetCell];
    }
    else
    {
        self.sendNumber ++;
        [_btnOK setTitle:[NSString stringWithFormat:@"发送(%d)",self.sendNumber ] forState:UIControlStateNormal];
        [self.removeArray removeObject:assetCell];
    }
    if(self.sendNumber == 0)
    {
        _btnOK.userInteractionEnabled = NO;
        [_btnOK setBackgroundImage:[UIImage imageNamed:@"defultComplete"] forState:UIControlStateNormal];
    }
    else
    {
        _btnOK.userInteractionEnabled = YES;
        [_btnOK setBackgroundImage:[UIImage imageNamed:@"complete"] forState:UIControlStateNormal];
    }
}

@end
