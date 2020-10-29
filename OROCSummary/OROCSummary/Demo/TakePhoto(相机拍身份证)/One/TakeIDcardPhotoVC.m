//
//  TakeIDcardPhotoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/4.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "TakeIDcardPhotoVC.h"
#import "TakeAPictureView.h"
#import "ShowImageView.h"

#define WeakSelf    __weak typeof(self) weakSelf = self;
#define StrongSelf  __strong typeof(weakSelf) self = weakSelf;

@interface TakeIDcardPhotoVC ()
@property (weak, nonatomic) IBOutlet TakeAPictureView *cameraView;
@property (weak, nonatomic) ShowImageView *showImageView;
@property (weak, nonatomic) IBOutlet UIView *bottmView;
@end

@implementation TakeIDcardPhotoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 是否在按照成功直接写入本地
    //self.cameraView.shouldWriteToSavedPhotos = YES;
    
    [self.view bringSubviewToFront:self.bottmView];
    WeakSelf
    self.cameraView.getImage = ^(UIImage *image){
        StrongSelf
        self.cameraView.hidden = YES;
        self.bottmView.hidden = YES;
        self.showImageView.image = image;
    };
    
}

- (ShowImageView *)showImageView
{
    if (!_showImageView) {
        _showImageView = [ShowImageView showImageView];
        
        WeakSelf
        _showImageView.didCancleSaveBtn = ^ (void) {
            StrongSelf
            [self.view bringSubviewToFront:self.cameraView];
            [self.view bringSubviewToFront:self.bottmView];
            self.cameraView.hidden = NO;
            self.bottmView.hidden = NO;
        };
        
        _showImageView.didClickSaveBtn = ^ (void) {
            StrongSelf
            // 保存之后的操作
            NSLog(@"用户选定这张图片");
            // 保存到本地
            [self.cameraView writeToSavedPhotos];
        };
        
        [self.view addSubview:_showImageView];
    }
    return _showImageView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.cameraView startRunning];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self.cameraView stopRunning];
}

// 拍照
- (IBAction)takeAPicker:(id)sender {
    [self.cameraView takeAPicture];
}

// 切换前置后置镜头
- (IBAction)change:(UIButton *)sender {
    
    [self.cameraView setFrontOrBackFacingCamera:sender.selected];
    sender.selected = !sender.selected;
    
}

@end
