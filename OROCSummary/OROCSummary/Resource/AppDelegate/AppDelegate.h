//
//  AppDelegate.h
//  ORIOSSummary
//
//  Created by orilme on 2019/3/25.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import <UIKit/UIKit.h>

// MusicPlayerVC音乐播放用
typedef void (^PlayerRemoteEventBlock)(UIEvent *event);//播放器远程事件block

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// MusicPlayerVC音乐播放用
@property(copy,nonatomic)PlayerRemoteEventBlock mRemoteEventBlock;

@end
