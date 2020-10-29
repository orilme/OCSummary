//
//  GesturePuzzleVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/10.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "GesturePuzzleVC.h"

@interface GesturePuzzleVC ()

@end

#define IMAGE_NUM 9

@implementation GesturePuzzleVC {
    NSMutableArray *_imageArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self customUI];
}

- (void)customUI {
    _imageArr = [[NSMutableArray alloc]init];
    for(int i=0;i<IMAGE_NUM;i++){
        CGFloat row = i/3;
        CGFloat col = i%3;
        CGFloat x = row*120+10;
        CGFloat y = col*120+120;
        UIImage *image = [self clipImage:[UIImage imageNamed:@"IMG_0190.JPG"] inRect:CGRectMake(x,y, 120, 120)];
        UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(x, y, 117, 117)];
        imageView.image = image;
        if(i==IMAGE_NUM-1){
            imageView.alpha = 0;
        }
        [self.view addSubview:imageView];
        //给视图加手势向下
        UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipe:)];
        [imageView addGestureRecognizer:swipeDown];
        swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
        //向上
        UISwipeGestureRecognizer *swipeUp = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipe:)];
        [imageView addGestureRecognizer:swipeUp];
        swipeUp.direction = UISwipeGestureRecognizerDirectionUp;
        //向左
        UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipe:)];
        [imageView addGestureRecognizer:swipeLeft];
        swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
        //向右
        UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(onSwipe:)];
        [imageView addGestureRecognizer:swipeRight];
        swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
        
        imageView.userInteractionEnabled =YES;
        [_imageArr addObject:imageView];
    }
}

- (void)onSwipe:(UISwipeGestureRecognizer *)sender {
    CGPoint lastP = ((UIImageView *)_imageArr[IMAGE_NUM-1]).center;
    for(int i=0;i<_imageArr.count-1;i++) {
        CGPoint tmp = ((UIImageView *)_imageArr[i]).center;
        if(lastP.x == tmp.x && lastP.y !=tmp.y){
            if(sender.direction == UISwipeGestureRecognizerDirectionDown && tmp.y+120==lastP.y){
                ((UIImageView *)_imageArr[IMAGE_NUM-1]).center =((UIImageView *)_imageArr[i]).center;
                ((UIImageView *)_imageArr[i]).center = CGPointMake(tmp.x, tmp.y+120);
                
                NSLog(@" x %f  y:%f",((UIImageView *)_imageArr[IMAGE_NUM-1]).center.x,((UIImageView *)_imageArr[IMAGE_NUM-1]).center.y);
                return;
            }else if(sender.direction == UISwipeGestureRecognizerDirectionUp && tmp.y-120 ==lastP.y){
                ((UIImageView *)_imageArr[IMAGE_NUM-1]).center =((UIImageView *)_imageArr[i]).center;
                ((UIImageView *)_imageArr[i]).center = CGPointMake(tmp.x, tmp.y-120);
                                NSLog(@" x %f  y:%f",((UIImageView *)_imageArr[IMAGE_NUM-1]).center.x,((UIImageView *)_imageArr[IMAGE_NUM-1]).center.y);
                return;
            }
        }else if(lastP.y == tmp.y && lastP.x !=tmp.x){
            if(sender.direction == UISwipeGestureRecognizerDirectionLeft &&tmp.x-120 ==lastP.x){
                ((UIImageView *)_imageArr[IMAGE_NUM-1]).center =((UIImageView *)_imageArr[i]).center;
                ((UIImageView *)_imageArr[i]).center = CGPointMake(tmp.x-120, tmp.y);
                return;
            }else if(sender.direction == UISwipeGestureRecognizerDirectionRight &&tmp.x+120 == lastP.x ){
                ((UIImageView *)_imageArr[IMAGE_NUM-1]).center =((UIImageView *)_imageArr[i]).center;
                ((UIImageView *)_imageArr[i]).center = CGPointMake(tmp.x+120, tmp.y);
                return;
            }
        }
    }
}

//从给定的大图中切出指定矩形区域的小图
- (UIImage *)clipImage: (UIImage *)bigImage inRect: (CGRect)rect {
    CGImageRef imageRef = CGImageCreateWithImageInRect(bigImage.CGImage, rect);
    UIImage *image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

@end
