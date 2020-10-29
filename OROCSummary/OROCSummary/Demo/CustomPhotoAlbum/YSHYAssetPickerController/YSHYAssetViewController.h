//
//  YSHYAssetViewController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface YSHYAssetViewController : UIViewController<UIToolbarDelegate>
@property (nonatomic, assign) NSInteger hasSelecteNumber;
@property (nonatomic, assign) NSInteger maxSlectedNumber;
@property (nonatomic, strong) NSMutableArray *SelectedaAssetView;
@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *indexPathsForSelectedItems;
@property (nonatomic, strong) UITableView *tableView;
@end
