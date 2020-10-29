//
//  YSHYAssetPickerController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#define kScreenWidth      [[UIScreen mainScreen]bounds].size.width
#define kScreenHeight     [[UIScreen mainScreen]bounds].size.height
#define kPopoverContentSize CGSizeMake(kScreenWidth, kScreenHeight)

#define kThumbnailLength    kScreenWidth/4- 2
#define kThumbnailSize      CGSizeMake(kThumbnailLength, kThumbnailLength)
#define kCollectionViewSize CGSizeMake(kScreenWidth/4 -4,kScreenWidth/4 -4)
@class YSHYAssetPickerController;

@protocol YSHYAssetPickerControllerDelegate <NSObject>

-(void)assetPickerController:(YSHYAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets;

@optional

-(void)assetPickerControllerDidCancel:(YSHYAssetPickerController *)picker;

-(void)assetPickerController:(YSHYAssetPickerController *)picker didSelectAsset:(ALAsset*)asset;

-(void)assetPickerController:(YSHYAssetPickerController *)picker didDeselectAsset:(ALAsset*)asset;

-(void)assetPickerControllerDidMaximum:(YSHYAssetPickerController *)picker;

-(void)assetPickerControllerDidMinimum:(YSHYAssetPickerController *)picker;

@end

@interface YSHYAssetPickerController : UINavigationController
@property (nonatomic, weak) id <YSHYAssetPickerControllerDelegate,UINavigationControllerDelegate>pickerDelegate;
@property (nonatomic, strong) ALAssetsFilter *assetsFilter;

@property (nonatomic, copy) NSArray *indexPathsForSelectedItems;

@property (nonatomic, assign) NSInteger maximumNumberOfSelection;
@property (nonatomic, assign) NSInteger minimumNumberOfSelection;
@property (nonatomic, strong) NSPredicate *selectionFilter;

@property (nonatomic, assign) BOOL showCancelButton;

@property (nonatomic, assign) BOOL showEmptyGroups;

@property (nonatomic, assign) BOOL isFinishDismissViewController;

@property (nonatomic, strong) NSString *typeOfController;

@end
