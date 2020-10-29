//
//  ShowImageView.m
//  自定义相机
//
//  Created by macbook on 16/9/6.
//  Copyright © 2016年 QIYIKE. All rights reserved.
//

#import "ShowImageView.h"

@interface ShowImageView ()

@property (weak, nonatomic) IBOutlet UIImageView *imageV;

@end

@implementation ShowImageView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [[[NSBundle mainBundle] loadNibNamed:@"ShowImageView" owner:nil options:nil] lastObject];
    }
    return self;
}

+ (instancetype)showImageView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"ShowImageView" owner:nil options:nil] lastObject];
}


- (IBAction)save:(id)sender {
    self.didClickSaveBtn();
}

- (IBAction)cancle:(id)sender {
    self.didCancleSaveBtn();
}

- (void)setImage:(UIImage *)image
{
    _image = image;
    _imageV.image = image;
}

@end
