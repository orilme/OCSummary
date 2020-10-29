//
//  MitchellFrameModel.h
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MitchellModel.h"
@interface MitchellFrameModel : NSObject
/**
 *  nameFrame
 */
@property(nonatomic,assign)CGRect nameFrame;
/**
 *iconFrame
 */
@property(nonatomic,assign)CGRect iconFrame;
/**
 *textFrame
 */
@property(nonatomic,assign)CGRect textFrame;
/**
 *vipFrame
 */
@property(nonatomic,assign)CGRect vipFrame;
/**
 *pictureFrame
 */
@property(nonatomic,assign)CGRect pictureFrame;

/**
 *cellHeight
 */
@property(nonatomic,assign)CGFloat cellHeight;
/**
 *  model
 */
@property(nonatomic,strong)MitchellModel * model;

+ (NSMutableArray*)frameModelWithArray:(NSMutableArray*)arr;

+ (instancetype)frameModelWithModel:(MitchellModel*)model;
@end
