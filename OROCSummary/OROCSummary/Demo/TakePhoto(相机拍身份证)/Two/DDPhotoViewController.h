//
//  DDPhotoViewController.h
//  Loan
//
//  Created by yll on 2017/11/7.
//  Copyright © 2017年 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^ImageBlock)(UIImage *image);

@interface DDPhotoViewController : UIViewController

@property (nonatomic, copy) ImageBlock imageblock;


@end
