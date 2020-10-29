//
//  CZMusicCell.h
//  A01_传智音乐
//
//  Created by apple on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CZMusic;
@interface CZMusicCell : UITableViewCell


+(instancetype)musicCellWithTableView:(UITableView *)tableView;

@property(strong,nonatomic)CZMusic *music;
@end
