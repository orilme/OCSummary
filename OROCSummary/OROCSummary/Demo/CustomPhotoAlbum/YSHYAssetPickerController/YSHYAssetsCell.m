//
//  YSHYAssetsCell.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "YSHYAssetsCell.h"
@implementation YSHYAssetsCell

-(instancetype)initWithFrame:(CGRect)frame
{
   if(self = [super initWithFrame:frame])
   {
       [self CreatUI];
   }
    return  self;
}

-(void)CreatUI
{
    _imageView = [[UIImageView alloc]initWithFrame:self.bounds];
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [_imageView setBackgroundColor:[UIColor whiteColor]];
    [self.contentView addSubview:_imageView];
    
    _selectedImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 25, self.frame.size.height - 25, 20, 20)];
    [_selectedImageView setImage:[UIImage imageNamed:@"isSeleted"]];
    _selectedImageView.hidden = YES;
    [self.contentView addSubview:_selectedImageView];
}

-(void)ConfigData:(AssetObj *)assetObj
{
    self.asset = assetObj.asset;
    _selectedImageView.hidden = assetObj.selectedImageHidden;
    UIImage * tempImg = [UIImage imageWithCGImage:[self.asset thumbnail]];
    [_imageView setImage:tempImg];
}

//点击图片
-(void)HandleTapTouch:(NSIndexPath *)indexPath
{
    self.indexPath = indexPath;
    [self.delegate TapAssetsCell:self isSelectedImageHidden:_selectedImageView.hidden indexPath:indexPath];
}
//改变界面的图片选中状态
-(void)HandleSelectedImage
{
    _selectedImageView.hidden = !_selectedImageView.hidden;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CAShapeLayer * layer = [[CAShapeLayer alloc]init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, _imageView.frame);
    [layer setPath:path];
    CGPathRelease(path);
    _imageView.layer.mask = layer;
}

@end
