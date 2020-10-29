//
//  CZMusicTool.h
//  A01_传智音乐
//
//  Created by apple on 15-3-2.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Singleton.h"

@class CZMusic;
@interface CZMusicTool : NSObject
singleton_interface(CZMusicTool)
@property(nonatomic,strong)AVAudioPlayer *player;//播放器
/*
 *音乐播放前的准备工作
 */
-(void)prepareToPlayWithMusic:(CZMusic *)music;

/*
 *播放
 */
-(void)play;
/*
 *暂停
 */
-(void)pause;

@end
