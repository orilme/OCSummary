//
//  HMMusicTool.h
//  03-单例模式-Singleton（掌握）
//
//  Created by apple on 14-9-16.
//  Copyright (c) 2014年 heima. All rights reserved.
//  播放音乐

#import <Foundation/Foundation.h>

@interface HMMusicTool : NSObject
+ (instancetype)sharedMusicTool;
@end
