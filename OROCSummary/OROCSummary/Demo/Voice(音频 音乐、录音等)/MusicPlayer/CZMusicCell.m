//
//  CZMusicCell.m
//  A01_传智音乐
//
//  Created by apple on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import "CZMusicCell.h"
#import "CZMusic.h"

@implementation CZMusicCell

+(instancetype)musicCellWithTableView:(UITableView *)tableView{
    static NSString *ID = @"MusicCell";
    return [tableView dequeueReusableCellWithIdentifier:ID];

}

//显示cell的数据
-(void)setMusic:(CZMusic *)music{
    _music = music;
    
    
    self.textLabel.text = music.name;
    self.detailTextLabel.text = music.singer;
}
@end
