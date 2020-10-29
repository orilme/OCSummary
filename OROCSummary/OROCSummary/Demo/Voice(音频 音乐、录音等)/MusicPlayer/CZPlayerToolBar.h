//
//  CZPlayerToolBar.h
//  A01_传智音乐
//
//  Created by apple on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef enum {
    BtnTypePlay,//播放
    BtnTypePause,//暂停
    BtnTypePrevious,//上一首
    BtnTypeNext//下一首
}BtnType;

@class CZMusic,CZPlayerToolBar;

@protocol CZPlayerToolBarDelegate <NSObject>

-(void)playerToolBar:(CZPlayerToolBar *)toolbar btnClickWithType:(BtnType) btnType;

@end

@interface CZPlayerToolBar : UIView

+(instancetype)playerToolBar;


@property(nonatomic,strong)CZMusic *playingMusic;//当前播放的音乐

/*
 *播放状态 默认暂停状态
 */
@property(assign,nonatomic,getter=isPlaying)BOOL playing;


@property(nonatomic,weak)id<CZPlayerToolBarDelegate> delegate;

@end
