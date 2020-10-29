//
//  MitchellCell.h
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MitchellModel.h"
#import "MitchellFrameModel.h"
@interface MitchellCell : UITableViewCell


/**
 *  model
 */
@property(nonatomic,strong)MitchellModel * model;
/**
 *  frameModel
 */
@property(nonatomic,strong)MitchellFrameModel * frameModel;
@end
