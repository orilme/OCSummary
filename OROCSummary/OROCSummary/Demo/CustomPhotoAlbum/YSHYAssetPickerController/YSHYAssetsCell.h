//
//  YSHYAssetsCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AssetObj.h"
#define kScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight     [[UIScreen mainScreen]bounds].size.height
#define kCollectionViewSize CGSizeMake(kScreenWidth/4 -4,kScreenWidth/4 -4)

@class  YSHYAssetsCell;
@protocol YSHYAssetsCellDelegate <NSObject>
@optional
-(void)TapAssetsCell:(YSHYAssetsCell*)assetCell isSelectedImageHidden:(BOOL)selected indexPath:(NSIndexPath *)indexPath;
@end

@interface YSHYAssetsCell : UICollectionViewCell
{
    UIImageView * _selectedImageView;
}
@property(nonatomic, assign)NSIndexPath* indexPath;
@property(nonatomic, strong)ALAsset *asset;
@property(nonatomic, strong)UIImageView * imageView;
-(void)ConfigData:(ALAsset *)asset;
-(void)HandleTapTouch:(NSIndexPath *)indexPath;
-(void)HandleSelectedImage;
@property (nonatomic, weak)id<YSHYAssetsCellDelegate>delegate;

@end
