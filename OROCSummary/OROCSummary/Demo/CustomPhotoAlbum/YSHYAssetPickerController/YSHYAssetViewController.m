//
//  YSHYAssetViewController.m
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//

#import "YSHYAssetViewController.h"
#import "YSHYAssetPickerController.h"
#import "ShowBigViewController.h"
#import "EqualSpaceFlowLayout.h"
#import "YSHYAssetsCell.h"
#import "MBProgressHUD.h"
#import "AssetObj.h"
#define maxSelectedNumber   10;
@interface YSHYAssetViewController()<UICollectionViewDelegate,UICollectionViewDataSource,EqualSpaceFlowLayoutDelegate,YSHYAssetsCellDelegate>{
    BOOL unFirst;
}

@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) UIView *toolBar;
@property (nonatomic, strong) UIButton *preview;
@property (nonatomic, strong) UIButton *send;

@property (nonatomic, strong) UICollectionView * collectionView;
@end

@implementation YSHYAssetViewController

- (id)init
{
    if (self = [super init])
    {
        self.maxSlectedNumber = 10;
        self.indexPathsForSelectedItems=[[NSMutableArray alloc] init];
        if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)])
            [self setEdgesForExtendedLayout:UIRectEdgeNone];
        
        if ([self respondsToSelector:@selector(setContentSizeForViewInPopover:)])
            self.preferredContentSize = kPopoverContentSize;
    }
    
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self CreatCollectionView];
    [self setupButtons];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (!unFirst) {
        [self setupAssets];
        unFirst=YES;
    }
}
#pragma mark - Rotation



-(void)CreatCollectionView
{
    EqualSpaceFlowLayout * flowLayout = [[EqualSpaceFlowLayout alloc]init];
    flowLayout.delegate = self;
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.minimumLineSpacing = 5;
    flowLayout.minimumInteritemSpacing = 3;
    flowLayout.sectionInset = UIEdgeInsetsMake(2, 3, 2, 0);
    flowLayout.itemSize = kCollectionViewSize;
    
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 -40) collectionViewLayout:flowLayout];
    [self.collectionView setBackgroundColor:[UIColor whiteColor]];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[YSHYAssetsCell class] forCellWithReuseIdentifier:@"CellID"];
    [self.view addSubview:self.collectionView];
}

#pragma mark - Setup

- (void)setupButtons
{
    self.navigationItem.rightBarButtonItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"取消", nil)
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(cancelPickingAssets:)];
    
    self.toolBar = [[UIView alloc]initWithFrame:CGRectMake(0, kScreenHeight - 105 - 64, kScreenWidth, 40 )];
    [self.toolBar setBackgroundColor:[UIColor colorWithRed:244.0/255.0 green:244.0/255.0 blue:239.0/255.0 alpha:1.0]];
    
    
    self.preview = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.preview setBackgroundImage:[UIImage imageNamed:@"defultComplete"] forState:UIControlStateNormal];
    [self.preview setTitle:@"预览" forState:UIControlStateNormal];
    self.preview.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.preview setFrame:CGRectMake(5, 5 , 80, 30)];
    self.preview.userInteractionEnabled = NO;
    [self.preview addTarget:self action:@selector(previewClick) forControlEvents:UIControlEventTouchUpInside];
    
    self.send = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.send setBackgroundImage:[UIImage imageNamed:@"defultComplete"] forState:UIControlStateNormal];
    [self.send setTitle:@"确定" forState:UIControlStateNormal];
    self.send.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.send setFrame:CGRectMake((kScreenWidth- 80 -5), 5 , 80, 30)];
    self.send.userInteractionEnabled = NO;
    [self.send addTarget:self action:@selector(sendClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.toolBar addSubview:self.preview];
    [self.toolBar addSubview:self.send];
    
    [self.view addSubview:self.toolBar];
}

- (void)setupAssets
{
    self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        [self.assets removeAllObjects];
    
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop) {
        
        if (asset)
        {
            [self.assets addObject:asset];
        }
        else if (self.assets.count > 0)
        {
            [self.collectionView reloadData];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
    
}

#pragma mark - Actions

- (void)cancelPickingAssets:(id)sender
{
    YSHYAssetPickerController *picker = (YSHYAssetPickerController *)self.navigationController;
    
    if (picker.isFinishDismissViewController)
    {
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

-(void)previewClick
{
    YSHYAssetPickerController *picker = (YSHYAssetPickerController *)self.navigationController;
    ShowBigViewController *big = [[ShowBigViewController alloc]init];
    big.arrayOK = [NSMutableArray arrayWithArray:_indexPathsForSelectedItems];
    big.popViewControllerBlock= ^(NSArray * array)
    {
        for (AssetObj *assetObj in array) {
            [_indexPathsForSelectedItems removeObject:assetObj];
            assetObj.selectedImageHidden = YES;
            YSHYAssetsCell * cell =(YSHYAssetsCell *)[_collectionView cellForItemAtIndexPath:assetObj.indexPath];
            [cell HandleTapTouch:assetObj.indexPath];
        }
    };
    [picker pushViewController:big animated:YES];
}
-(void)sendClick
{
    YSHYAssetPickerController *picker = (YSHYAssetPickerController *)self.navigationController;
    if ([picker.pickerDelegate respondsToSelector:@selector(assetPickerController:didFinishPickingAssets:)])
        [picker.pickerDelegate assetPickerController:picker didFinishPickingAssets:_indexPathsForSelectedItems];
   
    if (picker.isFinishDismissViewController)
        [picker.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - UICollectionViewDelegate

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"CellID";
    if([self.assets[indexPath.row] isKindOfClass:[ALAsset class]])
    {
        AssetObj * obj = [[AssetObj alloc]init];
        obj.asset = self.assets[indexPath.row];
        obj.selectedImageHidden = YES;
        obj.indexPath = indexPath;
        [self.assets replaceObjectAtIndex:indexPath.row withObject:obj];
    }
    
    YSHYAssetsCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.delegate = self;
    cell.backgroundColor = [UIColor yellowColor];
    [cell ConfigData:_assets[indexPath.row]];
    [cell layoutIfNeeded];
    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return kCollectionViewSize;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    YSHYAssetsCell * cell = (YSHYAssetsCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell HandleTapTouch:indexPath];
}
-(void)HandleHiddenHud:(UIView *)view
{
    [view removeFromSuperview];
}


-(void)TapAssetsCell:(YSHYAssetsCell *)assetCell isSelectedImageHidden:(BOOL)selected indexPath:(NSIndexPath *)indexPath
{
    AssetObj * obj =(AssetObj *)self.assets[indexPath.row];
    if(selected)
    {
        if(self.hasSelecteNumber >= 10)
        {
            MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            hud.mode = MBProgressHUDModeText;
            [self.view bringSubviewToFront:hud];
            hud.label.text =[NSString stringWithFormat:@"最多只能选%ld张呢",(long)self.maxSlectedNumber];
            [self performSelector:@selector(HandleHiddenHud:) withObject:hud afterDelay:2.0];
        }else
        {
            [_indexPathsForSelectedItems addObject:obj];
            obj.selectedImageHidden = NO;
        }
    }
    else
    {
        [_indexPathsForSelectedItems removeObject:obj];
        obj.selectedImageHidden = YES;
    }
    
    [assetCell HandleSelectedImage];
    [self setTitleWithSelectedIndexPaths:_indexPathsForSelectedItems];
}

#pragma mark - Title
- (void)setTitleWithSelectedIndexPaths:(NSArray *)indexPaths
{
    // Reset title to group name
    self.hasSelecteNumber = indexPaths.count;
    if (indexPaths.count == 0)
    {
        self.title = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyName];
        [self.preview setBackgroundImage:[UIImage imageNamed:@"defultComplete" ]forState:
         UIControlStateNormal];
        self.preview.userInteractionEnabled = NO;
        [self.send setBackgroundImage:[UIImage imageNamed:@"defultComplete" ]forState:
         UIControlStateNormal];
        self.send.userInteractionEnabled = NO;
        [self.send setTitle:@"确定" forState:UIControlStateNormal];
        return;
    }
    
    [self.preview setBackgroundImage:[UIImage imageNamed:@"complete" ]forState:
     UIControlStateNormal];
    self.preview.userInteractionEnabled = YES;
    [self.send setBackgroundImage:[UIImage imageNamed:@"complete" ]forState:
     UIControlStateNormal];
    self.send.userInteractionEnabled = YES;
    [self.send setTitle:[NSString stringWithFormat:@"确定(%ld)",(long)self.hasSelecteNumber] forState:UIControlStateNormal];
}


@end
