//
//  YSHYAssetPickerController.h
//  ColorGradualChangeDemo
//
//  Created by 杨淑园 on 16/3/30.
//  Copyright © 2016年 yangshuyaun. All rights reserved.
//


#import <UIKit/UIKit.h>
@class ShowImage;

typedef void(^PopViewControllerBlock)(NSArray * array);

@protocol NavigationRightButtonDelegate <NSObject>

-(void)navigationRightButtonClicked:(ShowImage *)showImage;

@end

@protocol ShowBigViewControllerDelegate <NSObject>
-(void)ChangeSendNumberWithCurrentState:(bool)stateOfSelect;
@end

#pragma mark - showImage

@interface ShowImage : NSObject

@property (strong, nonatomic) UIImage *image;
@property (assign, nonatomic) bool stateOfSelect;
@property (strong, nonatomic) UIButton * button;
@property (assign, nonatomic) int theOrder;
@property (weak, nonatomic) id<NavigationRightButtonDelegate>delegate;
@end

#pragma mark - ShowBigViewController
@interface ShowBigViewController : UIViewController<UIScrollViewDelegate,UINavigationControllerDelegate,NavigationRightButtonDelegate>
{
    UIImageView    *_imagvtitle;
    
    UIButton        *rightbtn;
    UIScrollView    *_scrollerview;
    UIButton        *_btnOK;
    NSInteger        _currentIndex;
}
//@property (strong, nonatomic) ShowImage *showImage;
@property(nonatomic, copy)PopViewControllerBlock popViewControllerBlock;
@property(nonatomic, strong) NSMutableArray *arrayOK;     //选中的图片数组
@property(nonatomic, strong)NSMutableArray *removeArray; //最后的图片数组
@end




