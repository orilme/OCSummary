//
//  MitchellCell.m
//  纯代码不等高Cell
//
//  Created by MENGCHEN on 15/8/12.
//  Copyright (c) 2015年 Mcking. All rights reserved.
//

#import "MitchellCell.h"
#define MitchellNameFont [UIFont systemFontOfSize:17]
#define MitchellTextFont [UIFont systemFontOfSize:14]
@interface MitchellCell()

/** 头像 */
@property (nonatomic, weak) UIImageView *iconImageView;
/** 名称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipImageView;
/** 文字 */
@property (nonatomic, weak) UILabel *text_label;
/** 配图 */
@property (nonatomic, weak) UIImageView *pictureImageView;

@end


@implementation MitchellCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        NSLog(@"%s",__func__);
        // 头像
        UIImageView *iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:iconImageView];
        self.iconImageView = iconImageView;
        
        // 会员图标
        UIImageView *vipImageView = [[UIImageView alloc] init];
        vipImageView.image = [UIImage imageNamed:@"vip"];
        vipImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:vipImageView];
        self.vipImageView = vipImageView;
        
        // 配图
        UIImageView *pictureImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:pictureImageView];
        self.pictureImageView = pictureImageView;
        
        // 名称
        UILabel *nameLabel = [[UILabel alloc] init];
        nameLabel.font = MitchellNameFont;
        [self.contentView addSubview:nameLabel];
        self.nameLabel = nameLabel;
        
        // 文字
        UILabel *text_label = [[UILabel alloc] init];
        text_label.numberOfLines = 0;
        text_label.font = MitchellTextFont;
        [self.contentView addSubview:text_label];
        self.text_label = text_label;
    }
    return  self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _iconImageView.frame = _frameModel.iconFrame;
    _text_label.frame = _frameModel.textFrame;
    _nameLabel.frame = _frameModel.nameFrame;
    _vipImageView.frame = _frameModel.vipFrame;
    _pictureImageView.frame = _frameModel.pictureFrame;
    
}


-(void)setModel:(MitchellModel *)model{
    _model = model;
    if (model.picture) {
        _pictureImageView.image = [UIImage imageNamed:model.picture];
    }
    _nameLabel.text = _model.name;
    if (_model.vip) {
        _vipImageView.hidden = NO;
    }else{
        _vipImageView.hidden = YES;
    }
    _text_label.text = _model.text;
    _iconImageView.image = [UIImage imageNamed:model.icon];
    
}
@end
