//
//  AssetObj.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/4/1.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
@interface AssetObj : NSObject

@property (nonatomic, strong)ALAsset * asset;
@property (nonatomic, assign)BOOL  selectedImageHidden;
@property (nonatomic, strong)NSIndexPath * indexPath;

@end
