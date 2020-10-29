//
//  MCCustomBar.m
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import "MCCustomBar.h"
#import "UIView_extra.h"
#import "ToolMothod.h"

#define ItemNorTintColor RGBA(160, 160, 160, 1)

@implementation MCCustomBar

- (instancetype)initWithCount:(NSString *)count andName:(NSString *)name size:(CGSize)size{
    self = [super init];
    if (self) {
        [self createControlBarWithCount:count andName:name size:size];
    }
    return self;
}

//创建item
- (void)createControlBarWithCount:(NSString *)count andName:(NSString *)name size:(CGSize)size{
    
    [self setSize:size];
    
//    //数量
//    _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, 15)];
//    _countLabel.textAlignment = NSTextAlignmentCenter;
//    _countLabel.adjustsFontSizeToFitWidth = YES;
//    _countLabel.font = [UIFont systemFontOfSize:14];
//    //    [countLabel sizeToFit];
//    _countLabel.text = count;
//    [self addSubview:_countLabel];
    
    //标题
    _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
    _nameLabel.textAlignment = NSTextAlignmentCenter;
    _nameLabel.text = name;
    _nameLabel.font = [UIFont systemFontOfSize:16];
    
//    _countLabel.textColor = ItemNorTintColor;
    _nameLabel.textColor = ItemNorTintColor;
    
    [self addSubview:_nameLabel];
    
}




@end
