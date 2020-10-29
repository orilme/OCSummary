//
//  CustomPhotoAlbumVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/1.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CustomPhotoAlbumVC.h"
#import "YSHYAssetPickerController.h"

@interface CustomPhotoAlbumVC ()<YSHYAssetPickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation CustomPhotoAlbumVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"选择图片" forState:UIControlStateNormal];
    [btn setFrame:CGRectMake(0, 0, 80, 80)];
    [btn addTarget:self action:@selector(HandleClickBtn) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn setCenter:self.view.center];
    [self.view addSubview:btn];
}

-(void)HandleClickBtn
{
    YSHYAssetPickerController *picker = [[YSHYAssetPickerController alloc]init];
    picker.maximumNumberOfSelection = 10;
    picker.assetsFilter = [ALAssetsFilter allPhotos];

    picker.showEmptyGroups = NO;
    picker.pickerDelegate = self;
    picker.selectionFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject,NSDictionary *bindings){
        
        if ([[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyType]isEqual:ALAssetTypeVideo]) {
            NSTimeInterval duration = [[(ALAsset *)evaluatedObject valueForProperty:ALAssetPropertyDuration]doubleValue];
            return duration >= 5;
        }else{
            return  YES;
        }
    }];
    picker.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:picker animated:YES completion:^{
        [self.view endEditing:YES];
    }];
}

-(void)assetPickerController:(YSHYAssetPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    NSLog(@"选好了");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
