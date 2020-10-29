//
//  YSHYAssetGroupViewController.h
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

@interface YSHYAssetGroupViewController : UITableViewController
@property (nonatomic, assign) NSInteger  isFirstAppear;   // 0 表示是  其他表示不是
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@end
