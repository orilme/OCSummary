//
//  YSHYAssetGroupViewCell.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface YSHYAssetGroupViewCell : UITableViewCell
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;

- (void)bind:(ALAssetsGroup *)assetsGroup;

@end
