//
//  LayoutBaseUseVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/2/25.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "LayoutBaseUseVC.h"
#import "XMGLineLayout.h"
#import "XMGPhotoCell.h"
#import "XMGCircleLayout.h"

@interface LayoutBaseUseVC ()<UICollectionViewDataSource, UICollectionViewDelegate>
/** collectionView */
@property (nonatomic, weak) UICollectionView *collectionView;
/** 数据 */
@property (nonatomic, strong) NSMutableArray *imageNames;
@end

@implementation LayoutBaseUseVC

static NSString * const XMGPhotoId = @"photo";

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i<20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%zd", i + 1]];
        }
    }
    return _imageNames;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 创建布局
    XMGCircleLayout *layout = [[XMGCircleLayout alloc] init];
    
    // 创建CollectionView
    CGFloat collectionW = self.view.frame.size.width;
    CGFloat collectionH = 200;
    CGRect frame = CGRectMake(0, 150, collectionW, collectionH);
    UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:layout];
    collectionView.dataSource = self;
    collectionView.delegate = self;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([XMGPhotoCell class]) bundle:nil] forCellWithReuseIdentifier:XMGPhotoId];
    
    // 继承UICollectionViewLayout
    // 继承UICollectionViewFlowLayout
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if ([self.collectionView.collectionViewLayout isKindOfClass:[XMGLineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[XMGCircleLayout alloc] init] animated:YES];
    } else {
        XMGLineLayout *layout = [[XMGLineLayout alloc] init];
        layout.itemSize = CGSizeMake(100, 100);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
    }
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.imageNames.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    XMGPhotoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:XMGPhotoId forIndexPath:indexPath];
    
    cell.imageName = self.imageNames[indexPath.item];
    
//    cell.backgroundColor = [UIColor orangeColor];
//
//    NSInteger tag = 10;
//    UILabel *label = (UILabel *)[cell.contentView viewWithTag:tag];
//    if (label == nil) {
//        label = [[UILabel alloc] init];
//        label.tag = tag;
//        [cell.contentView addSubview:label];
//    }
//
//    label.text = [NSString stringWithFormat:@"%zd", indexPath.item];
//    [label sizeToFit];
    
    return cell;
}

#pragma mark - <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}

@end
