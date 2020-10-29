//
//  TakeAPictureView.m
//  自定义相机
//
//  Created by macbook on 16/9/2.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "TakeAPictureView.h"
#import <AVFoundation/AVFoundation.h>
// 为了导入系统相册
#import <AssetsLibrary/AssetsLibrary.h>

#import <Photos/Photos.h>
#import "UIImage+info.h"

@interface TakeAPictureView ()
{
    CGRect _imageRect;
}
@property (nonatomic, strong) AVCaptureSession *session;/**< 输入和输出设备之间的数据传递 */
@property (nonatomic, strong) AVCaptureDeviceInput *videoInput;/**< 输入设备 */
@property (nonatomic, strong) AVCaptureStillImageOutput *stillImageOutput;/**< 照片输出流 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;/**< 预览图片层 */
@property (nonatomic, strong) UIImage *image;

@end

@implementation TakeAPictureView

- (void)awakeFromNib
{
    [self initAVCaptureSession];
    [self initCameraOverlayView];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initAVCaptureSession];
        [self initCameraOverlayView];
    }
    return self;
}

- (void)startRunning
{
    if (self.session) {
        [self.session startRunning];
    }
}

- (void)stopRunning
{
    if (self.session) {
        [self.session stopRunning];
    }
}

- (void)initCameraOverlayView
{
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(8, height * 0.3, width - 2 * 8, height * 0.3)];
    imageV.clipsToBounds = YES;
    imageV.layer.borderColor = [UIColor greenColor].CGColor;
    imageV.layer.borderWidth = 0.5;
    [self addSubview:imageV];
    _imageRect = imageV.frame;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, imageV.frame.origin.y - 20, width, 20)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请把身份证放入相框内";
    label.font = [UIFont systemFontOfSize:16];
    label.textColor = [UIColor greenColor];
    [self addSubview:label];
    
}

- (void)initAVCaptureSession {
    self.session = [[AVCaptureSession alloc] init];
    NSError *error;
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    //更改这个设置的时候必须先锁定设备，修改完后再解锁，否则崩溃
    [device lockForConfiguration:nil];
    
    // 设置闪光灯自动
    [device setFlashMode:AVCaptureFlashModeAuto];
    [device unlockForConfiguration];
    
    self.videoInput = [[AVCaptureDeviceInput alloc] initWithDevice:device error:&error];
    if (error) {
        NSLog(@"%@", error);
    }
    // 照片输出流
    self.stillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    
    // 设置输出图片格式
    NSDictionary *outputSettings = @{AVVideoCodecKey : AVVideoCodecJPEG};
    [self.stillImageOutput setOutputSettings:outputSettings];
    
    if ([self.session canAddInput:self.videoInput]) {
        [self.session addInput:self.videoInput];
    }
    if ([self.session canAddOutput:self.stillImageOutput]) {
        [self.session addOutput:self.stillImageOutput];
    }
    // 初始化预览层
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:self.session];
    [self.previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    self.previewLayer.frame = CGRectMake(0, 0, Screen_Width, Screen_Height - 100);
    [self.layer addSublayer:self.previewLayer];
    
}

// 获取设备方向

- (AVCaptureVideoOrientation)getOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    if (deviceOrientation == UIDeviceOrientationLandscapeLeft) {
        return AVCaptureVideoOrientationLandscapeRight;
    } else if ( deviceOrientation == UIDeviceOrientationLandscapeRight){
        return AVCaptureVideoOrientationLandscapeLeft;
    }
    return (AVCaptureVideoOrientation)deviceOrientation;
}

// 拍照
- (void)takeAPicture
{
    AVCaptureConnection *stillImageConnection = [self.stillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    UIDeviceOrientation curDeviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation avOrientation = [self getOrientationForDeviceOrientation:curDeviceOrientation];
    [stillImageConnection setVideoOrientation:avOrientation];
    [self.stillImageOutput captureStillImageAsynchronouslyFromConnection:stillImageConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        NSData *jpegData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        
        UIImage *image = [UIImage imageWithData:jpegData];
        
        image = [UIImage image:image scaleToSize:CGSizeMake(self.frame.size.width, self.frame.size.height)];
        
        image = [UIImage imageFromImage:image inRect:_imageRect];
        
        self.image = image;
        self.getImage(image);
        
        // 写入相册
        if (self.shouldWriteToSavedPhotos) {
            [self writeToSavedPhotos];
        }
        
    }];
    
}

- (void)writeToSavedPhotos
{
    //写入相册
    // 判断授权状态
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) return;
        /// 异步执行修改操作
        [[PHPhotoLibrary sharedPhotoLibrary]performChanges:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:self.image];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"%@",@"保存失败");
            } else {
                NSLog(@"%@",@"保存成功");
            }
        }];
    }];
}


- (void)setFrontOrBackFacingCamera:(BOOL)isUsingFrontFacingCamera {
    AVCaptureDevicePosition desiredPosition;
    if (isUsingFrontFacingCamera){
        desiredPosition = AVCaptureDevicePositionBack;
    } else {
        desiredPosition = AVCaptureDevicePositionFront;
    }
    
    for (AVCaptureDevice *d in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
        if ([d position] == desiredPosition) {
            [self.previewLayer.session beginConfiguration];
            AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:d error:nil];
            for (AVCaptureInput *oldInput in self.previewLayer.session.inputs) {
                [[self.previewLayer session] removeInput:oldInput];
            }
            [self.previewLayer.session addInput:input];
            [self.previewLayer.session commitConfiguration];
            break;
        }
    }
    
}


@end
