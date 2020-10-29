//
//  DDPhotoViewController.m
//  Loan
//
//  Created by yll on 2017/11/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import "DDPhotoViewController.h"
#import <Photos/Photos.h>

#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

@interface DDPhotoViewController ()<AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,CAAnimationDelegate>

//捕获设备，通常是前置摄像头，后置摄像头，麦克风（音频输入）
@property(nonatomic)AVCaptureDevice *device;
//AVCaptureDeviceInput 代表输入设备，他使用AVCaptureDevice 来初始化
@property(nonatomic)AVCaptureDeviceInput *input;
//当启动摄像头开始捕获输入
@property(nonatomic)AVCaptureMetadataOutput *output;
//输出
@property (nonatomic)AVCaptureStillImageOutput *ImageOutPut;
//session：由他把输入输出结合在一起，并开始启动捕获设备（摄像头）
@property(nonatomic)AVCaptureSession *session;
//图像预览层，实时显示捕获的图像
@property(nonatomic)AVCaptureVideoPreviewLayer *previewLayer;
//设备
@property (nonatomic, strong)AVCaptureDevice *deveice;
//拍照
@property (nonatomic, strong) UIButton *PhotoButton;
//取消
@property (nonatomic, strong) UIButton *cancleButton;
//切换摄像头
@property (nonatomic, strong) UIButton *changeButton;
//确定选择当前照片
@property (nonatomic, strong) UIButton *selectButton;
//重新拍照
@property (nonatomic, strong) UIButton *reCamButton;
//照片加载视图
@property (nonatomic, strong) UIImageView *imageView;
//对焦区域
@property (nonatomic, strong) UIImageView *focusView;
//上方功能区
@property (nonatomic, strong) UIView *topView;
//下方功能区
@property (nonatomic, strong) UIView *bottomView;
//拍到的照片
@property (nonatomic, strong) UIImage *image;
//照片的信息
@property (nonatomic, strong) NSDictionary *imageDict;
//是否可以拍照
@property (nonatomic, assign) BOOL canCa;
//闪光灯模式
@property (nonatomic, assign) AVCaptureFlashMode flahMode;
//前后摄像头
@property (nonatomic, assign) AVCaptureDevicePosition cameraPosition;

@property (nonatomic, strong) UIImageView *kuangImgView;//橘色边框

@property (nonatomic, strong) UILabel *tishiLabel;//提示字

@end

@implementation DDPhotoViewController

#pragma mark - 上方功能区
-(UIView *)topView{
    if (!_topView ) {
        _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, 50)];
        _topView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.2];
        [_topView addSubview:self.cancleButton];
        [_topView addSubview:self.changeButton];
    }
    return _topView;
}
#pragma mark - 取消
-(UIButton *)cancleButton{
    if (_cancleButton == nil) {
        _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancleButton.frame = CGRectMake(ScreenWidth-40, 15, 30, 30);
        [_cancleButton setImage:[UIImage imageNamed:@"cancelPhoto"] forState:(UIControlStateNormal)];
        [_cancleButton addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    }
    return  _cancleButton ;
}

#pragma mark - 下方功能区

-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, ScreenHeight-80, ScreenWidth, 80)];
        _bottomView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.4];
        [_bottomView addSubview:self.reCamButton];
        [_bottomView addSubview:self.PhotoButton];
        [_bottomView addSubview:self.selectButton];
    }
    return _bottomView;
}
-(UIButton *)reCamButton{
    if (_reCamButton == nil) {
        _reCamButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _reCamButton.frame = CGRectMake(40, 25, 80, 30);
        [_reCamButton addTarget:self action:@selector(reCam) forControlEvents:UIControlEventTouchUpInside];
        [_reCamButton setTitle:@"重新拍照" forState:UIControlStateNormal];
        _reCamButton.transform = CGAffineTransformMakeRotation(M_PI/2);
        [_reCamButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _reCamButton.alpha = 0;
    }
    return _reCamButton;
}
-(UIButton *)PhotoButton{
    if (_PhotoButton == nil) {
        _PhotoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _PhotoButton.frame = CGRectMake(ScreenWidth/2.0-30, 10, 60, 60);
        [_PhotoButton setImage:[UIImage imageNamed:@"photograph"] forState: UIControlStateNormal];
        [_PhotoButton setImage:[UIImage imageNamed:@"photograph_Select"] forState:UIControlStateNormal];
        [_PhotoButton addTarget:self action:@selector(shutterCamera) forControlEvents:UIControlEventTouchUpInside];
    }
    return _PhotoButton;
}
-(UIButton *)selectButton{
    if (_selectButton == nil) {
        _selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectButton.frame = CGRectMake(ScreenWidth-120, 25, 80, 30);
        [_selectButton addTarget:self action:@selector(selectImage) forControlEvents:UIControlEventTouchUpInside];
        [_selectButton setTitle:@"选择照片" forState:UIControlStateNormal];
        _selectButton.transform=CGAffineTransformMakeRotation(M_PI/2);
        [_selectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _selectButton.alpha = 0;
    }
    return _selectButton;
}
#pragma mark - 加载照片的视图
-(UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc]initWithFrame:self.previewLayer.frame];
        
        //这里要注意，图片填充方式的选择让图片不要变形了
        
        [_imageView setContentMode:UIViewContentModeScaleAspectFill];
        
        _imageView.clipsToBounds = YES;

        _imageView.image = _image;
    }
    return _imageView;
}
#pragma mark - 对焦区域
-(UIImageView *)focusView{
    if (_focusView == nil) {
        _focusView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
        _focusView.backgroundColor = [UIColor clearColor];
        _focusView.image = [UIImage imageNamed:@"foucs80pt"];
        _focusView.hidden = YES;
    }
    return _focusView;
}

- (UIImageView *)kuangImgView {
    if (_kuangImgView == nil) {
        _kuangImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,  226, 360)];
        _kuangImgView.center = self.view.center;
        _kuangImgView.image = [UIImage imageNamed:@"photoKuang"];
    }
    return _kuangImgView;
}

- (UILabel *)tishiLabel {
    
    if (_tishiLabel == nil) {
        _tishiLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*0.5, 60)];
        _tishiLabel.center = self.view.center;
        _tishiLabel.text = @"请将身份证置于此区域\n尝试对其边缘";
        _tishiLabel.textColor = [UIColor whiteColor];
        _tishiLabel.numberOfLines = 0;
        _tishiLabel.textAlignment = NSTextAlignmentCenter;
        _tishiLabel.font = [UIFont systemFontOfSize:15];
        _tishiLabel.transform = CGAffineTransformMakeRotation(M_PI/2);
        
    }
    
    return _tishiLabel;
}

#pragma mark - 使用self.session，初始化预览层，self.session负责驱动input进行信息的采集，layer负责把图像渲染显示
- (AVCaptureVideoPreviewLayer *)previewLayer{
    if (_previewLayer == nil) {
        _previewLayer = [[AVCaptureVideoPreviewLayer alloc]initWithSession:self.session];
        _previewLayer.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    }
    return  _previewLayer;
}
-(AVCaptureStillImageOutput *)ImageOutPut{
    if (_ImageOutPut == nil) {
        _ImageOutPut = [[AVCaptureStillImageOutput alloc] init];
    }
    return _ImageOutPut;
}
#pragma mark - 初始化输入
-(AVCaptureDeviceInput *)input{
    if (_input == nil) {
        
        _input = [[AVCaptureDeviceInput alloc]initWithDevice:self.device error:nil];
    }
    return _input;
}
#pragma mark - 初始化输出
-(AVCaptureMetadataOutput *)output{
    if (_output == nil) {
        
        _output = [[AVCaptureMetadataOutput alloc]init];
    }
    return  _output;
}
#pragma mark - 使用AVMediaTypeVideo 指明self.device代表视频，默认使用后置摄像头进行初始化
-(AVCaptureDevice *)device{
    if (_device == nil) {
        
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    }
    return _device;
}

#pragma mark - 当前视图控制器的初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        _canCa = [self canUserCamear];
    }
    return self;
}

#pragma mark - 检查相机权限
- (BOOL)canUserCamear{
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"请打开相机权限" message:@"设置-隐私-相机" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:@"取消", nil];
        alertView.tag = 100;
        [alertView show];
        return NO;
    }
    else{
        return YES;
    }
    return YES;
}
#pragma mark - 视图加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor clearColor];
    if (_canCa) {
        [self customCamera];
        [self customUI];
    }else{
        return;
    }
    
    
}
#pragma mark - 自定义视图
- (void)customUI {

    [self.view addSubview:self.topView];
    [self.view addSubview:self.bottomView];
    [self.view addSubview:self.focusView];
    [self.view addSubview:self.kuangImgView];
    [self.view addSubview:self.tishiLabel];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(focusGesture:)];
    [self.view addGestureRecognizer:tapGesture];
    
}
#pragma mark - 自定义相机
- (void)customCamera{
    
    //生成会话，用来结合输入输出
    self.session = [[AVCaptureSession alloc]init];
    if ([self.session canSetSessionPreset:AVCaptureSessionPresetPhoto]) {
        self.session.sessionPreset = AVCaptureSessionPresetPhoto;
    }
    if ([self.session canAddInput:self.input]) {
        [self.session addInput:self.input];
    }
    
    if ([self.session canAddOutput:self.ImageOutPut]) {
        [self.session addOutput:self.ImageOutPut];
    }
    
    [self.view.layer addSublayer:self.previewLayer];
    
    //开始启动
    [self.session startRunning];
    if ([self.device lockForConfiguration:nil]) {
        if ([self.device isFlashModeSupported:AVCaptureFlashModeAuto]) {
            [self.device setFlashMode:AVCaptureFlashModeAuto];
        }
        //自动白平衡
        if ([self.device isWhiteBalanceModeSupported:AVCaptureWhiteBalanceModeAutoWhiteBalance]) {
            [self.device setWhiteBalanceMode:AVCaptureWhiteBalanceModeAutoWhiteBalance];
        }
        
        [self.device unlockForConfiguration];
    }
    
}

#pragma mark - 聚焦
- (void)focusGesture:(UITapGestureRecognizer*)gesture{
    CGPoint point = [gesture locationInView:gesture.view];
    [self focusAtPoint:point];
}
- (void)focusAtPoint:(CGPoint)point{
    CGSize size = self.view.bounds.size;
    CGPoint focusPoint = CGPointMake( point.y /size.height ,1-point.x/size.width );
    NSError *error;
    if ([self.device lockForConfiguration:&error]) {
        
        if ([self.device isFocusModeSupported:AVCaptureFocusModeAutoFocus]) {
            [self.device setFocusPointOfInterest:focusPoint];
            [self.device setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        
        if ([self.device isExposureModeSupported:AVCaptureExposureModeAutoExpose ]) {
            [self.device setExposurePointOfInterest:focusPoint];
            [self.device setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        
        [self.device unlockForConfiguration];
        self.focusView.center = point;
        _focusView.hidden = NO;
        
        //        self.focusView.alpha = 1;
        [UIView animateWithDuration:0.2 animations:^{
            self.focusView.transform = CGAffineTransformMakeScale(1.25f, 1.25f);
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:0.3 animations:^{
                self.focusView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                [self hiddenFocusAnimation];
            }];
        }];
    }
    
}
#pragma mark - 拍照
- (void)shutterCamera
{
    
    AVCaptureConnection * videoConnection = [self.ImageOutPut connectionWithMediaType:AVMediaTypeVideo];
    if (!videoConnection) {
        NSLog(@"take photo failed!");
        return;
    }
    
    [self.ImageOutPut captureStillImageAsynchronouslyFromConnection:videoConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == NULL) {
            return;
        }
        NSData * imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        self.image = [UIImage imageWithData:imageData];
    
        self.imageDict = @{@"image":self.image,@"info":@{@"PHImageFileUTIKey":@".jpeg"}};
        [self.session stopRunning];
        [self.view insertSubview:self.imageView belowSubview:self.topView];
        NSLog(@"image size = %@",NSStringFromCGSize(self.image.size));
        self.PhotoButton.alpha = 0;
        self.reCamButton.alpha = 1;
        self.selectButton.alpha = 1;
    }];
}

#pragma - 保存至相册
- (void)saveImageToPhotoAlbum:(UIImage*)savedImage {
    //写入相册
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        /// 异步执行修改操作
        [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:savedImage];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",@"保存失败");
            } else {
                NSLog(@"%@",@"保存成功");
            }
        }];
    }];
}

//-
#pragma mark - 取消 返回上级
-(void)cancle{
    [self.imageView removeFromSuperview];
    [self.session stopRunning];
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0 && alertView.tag == 100) {
        
        NSURL * url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        
        if([[UIApplication sharedApplication] canOpenURL:url]) {
            
            [[UIApplication sharedApplication] openURL:url];
            
        }
    }
}
#pragma mark - 重新拍照
- (void)reCam{
    self.imageView.image = nil;
    [self.imageView removeFromSuperview];
    [self.session startRunning];
    self.PhotoButton.alpha = 1;
    self.reCamButton.alpha = 0;
    self.selectButton.alpha = 0;
}

#warning 这里是重点

#pragma mark - 选择照片 返回上级
- (void)selectImage{
    
    UIImage *image1 = self.image;
    [self saveImageToPhotoAlbum:self.image];
    CGImageRef cgRef = image1.CGImage;
    
    CGFloat widthScale = image1.size.width / ScreenWidth;
    CGFloat heightScale = image1.size.height / ScreenHeight;
    
    //其实是横屏的
    //多减掉50是因为最后的效果图片的高度有偏差，不知道原因
    CGFloat orignWidth = 226-50;//226
    CGFloat orginHeight = 360;//360
    
    //我们要裁剪出实际边框内的图片，但是实际的图片和我们看见的屏幕上的img，size是不一样，可以打印一下image的size看看起码好几千的像素，要不然手机拍的照片怎么都是好几兆的呢？
    CGFloat x = (ScreenHeight - orginHeight) * 0.5 * heightScale;
    CGFloat y = (ScreenWidth - orignWidth) * 0.5 * widthScale;
    CGFloat width = orginHeight * heightScale;
    CGFloat height = orignWidth * widthScale;
    
    CGRect r = CGRectMake(x, y, width, height);
    
    CGImageRef imageRef = CGImageCreateWithImageInRect(cgRef, r);
    
    UIImage *thumbScale = [UIImage imageWithCGImage:imageRef];
    //
    image1 = thumbScale;
    
    self.image = image1;
    
    CGImageRelease(imageRef);
    //返回的时候把图片传回去
    self.imageblock(self.image);
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)focusDidFinsh{
    self.focusView.hidden = YES;
    self.focusView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
}

- (void)startFocusAnimation{
    self.focusView.hidden = NO;
    self.focusView.transform = CGAffineTransformMakeScale(1.25f, 1.25f);//将要显示的view按照正常比例显示出来
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];
  
    [UIView setAnimationDidStopSelector:@selector(hiddenFocusAnimation)];
    [UIView setAnimationDuration:0.5f];//动画时间
    self.focusView.transform = CGAffineTransformIdentity;//先让要显示的view最小直至消失
    [UIView commitAnimations]; //启动动画
    //相反如果想要从小到大的显示效果，则将比例调换
    
}
- (void)hiddenFocusAnimation{
    [UIView beginAnimations:nil context:UIGraphicsGetCurrentContext()];

    [UIView setAnimationDelay:3];
    self.focusView.alpha = 0;
    [UIView setAnimationDuration:0.5f];//动画时间
    [UIView commitAnimations];
    
}
- (void)hiddenFoucsView{
    self.focusView.alpha = !self.focusView.alpha;
}




@end
