//
//  DrawRectScrawlColorVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/6.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "DrawRectScrawlColorVC.h"
#import "CZColorPaintView.h"
#import "UIImage+CZ.h"

@interface DrawRectScrawlColorVC ()
- (IBAction)back;
-(IBAction)clean;
- (IBAction)save;

@property (weak, nonatomic) IBOutlet CZColorPaintView *paintView;//画板
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation DrawRectScrawlColorVC

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    // 禁用返回手势
    if ([self.navigationController respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    //开启
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 1.拖一个view,用于画板
    
    // 2.监听触摸的事件，记录触摸的点
    
    // 3.根据触摸的点进行绘制
    
}


//回退
- (IBAction)back {
    [self.paintView back];
}

// 清屏
- (IBAction)clean {
    [self.paintView clear];
}

- (IBAction)save {
    // 将画板 保存成一张图片
    UIImage *captureImage = [UIImage captureImage:self.paintView];
    self.imageView.image = captureImage;
//    NSData *imgData = UIImagePNGRepresentation(captureImage);
//    [imgData writeToFile:@"/Users/orilme/code/Z我的Git仓库/IOSSummary/capture.png" atomically:YES];
}


- (IBAction)colorBtnClick:(UIButton *)sender {
    // 设置paintView当前颜色
    self.paintView.currentColor = sender.backgroundColor;
    NSLog(@"当前颜色---%@---%@---%@", self.paintView.currentColor, sender, sender.backgroundColor);
}

@end
