//
//  MCCustomBar.h
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MCCustomBar : UIControl

//@property(nonatomic,strong)UILabel *countLabel;
@property(nonatomic,strong)UILabel *nameLabel;
/**
 *  创建问答详情页导航条
 *
 *  @param count 数量
 *  @param name  标题
 *
 */
- (instancetype) initWithCount:(NSString *)count andName :(NSString *)name size:(CGSize)size;

@end
