//
//  MitchellFrameModel.m
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import "MitchellFrameModel.h"

@implementation MitchellFrameModel

+ (instancetype)frameModelWithModel:(MitchellModel *)model{
    return [[self alloc] initWithModel:model];
}
+(NSMutableArray *)frameModelWithArray:(NSMutableArray *)arr{
    NSMutableArray*data = [NSMutableArray array];
    for (MitchellModel*mo in arr) {
       MitchellFrameModel*newM =  [self frameModelWithModel:mo];
        [data addObject:newM];
    }
    return data;
}
- (instancetype)initWithModel:(MitchellModel*)model{
    if (self = [super init]) {
        self.model = model;
    }
    return self;
}
-(CGFloat)cellHeight{
    if (_cellHeight == 0) {
        CGFloat margin = 10;
        
        // 头像
        CGFloat iconX = margin;
        CGFloat iconY = margin;
        CGFloat iconWH = 30;
        self.iconFrame = CGRectMake(iconX, iconY, iconWH, iconWH);
        
        // 昵称(姓名)
        CGFloat nameY = iconY;
        CGFloat nameX = CGRectGetMaxX(self.iconFrame) + margin;
        // 计算文字所占据的尺寸
        NSDictionary *nameAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:17]};
        CGSize nameSize = [self.model.name sizeWithAttributes:nameAttrs];
        self.nameFrame = (CGRect){{nameX, nameY}, nameSize};
        
        // 会员图标
        if (self.model.vip) {
            CGFloat vipW = 14;
            CGFloat vipH = nameSize.height;
            CGFloat vipY = nameY;
            CGFloat vipX = CGRectGetMaxX(self.nameFrame) + margin;
            self.vipFrame = CGRectMake(vipX, vipY, vipW, vipH);
        }
        
        // 文字
        CGFloat textX = iconX;
        CGFloat textY = CGRectGetMaxY(self.iconFrame) + margin;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 2 * textX;
        CGSize textMaxSize = CGSizeMake(textW, MAXFLOAT);
        NSDictionary *textAttrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CGFloat textH = [self.model.text boundingRectWithSize:textMaxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:textAttrs context:nil].size.height;
        self.textFrame = CGRectMake(textX, textY, textW, textH);
        
        // 配图
        if (self.model.picture) {
            CGFloat pictureWH = 100;
            CGFloat pictureX = textX;
            CGFloat pictureY = CGRectGetMaxY(self.textFrame) + margin;
            self.pictureFrame = CGRectMake(pictureX, pictureY, pictureWH, pictureWH);
            
            _cellHeight = CGRectGetMaxY(self.pictureFrame);
        } else {
            _cellHeight = CGRectGetMaxY(self.textFrame);
        }
        _cellHeight += margin;
    }
    return _cellHeight;
}
@end
