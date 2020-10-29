//
//  ShortAudioTool.h
//  ORIOSSummary
//
//  Created by orilme on 2019/11/9.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

@interface ShortAudioTool : NSObject

singleton_interface(ShortAudioTool);
/**
 *  通过MP3的名字播放音频
 *
 */
-(void)playMp3WithName:(NSString *)mp3Name;

@end
