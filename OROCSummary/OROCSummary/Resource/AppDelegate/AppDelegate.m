//
//  AppDelegate.m
//  OROCSummary
//
//  Created by orilme on 2019/3/25.
//  Copyright © 2019年 orilme. All rights reserved.
//

#import "AppDelegate.h"
// 公共controller
#import "ORHomeViewController.h"
// 引导页，需要添加Tool中的引导页文件夹，同时导入三方库GVUserDefaults，和category中的GVUserDefaults+BBProperties文件
#import "introductoryPagesHelper.h"
// 启动广告
#import "AdvertiseHelper.h"
// 本地通知
#import <UserNotifications/UserNotifications.h>
// MusicPlayerVC音乐播放用
#import <AVFoundation/AVFoundation.h>

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self setupHomeViewController];
    
    //引导页面加载
    [self setupIntroductoryPage];
    
    //启动广告（记得放最后，才可以盖在页面上面）
    //[self setupAdveriseView];
    
    // 注册通知
    [self registerAPN];
    // 是否是通知打开app
    if (launchOptions[UIApplicationLaunchOptionsLocalNotificationKey]) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = CGRectMake(0, 300, 300, 300);
        label.backgroundColor = [UIColor blueColor];
        label.text = [NSString stringWithFormat:@"%@", launchOptions];
        label.font = [UIFont systemFontOfSize:14.0];
        label.textColor = [UIColor whiteColor];
        label.numberOfLines = 0;
        [self.window.rootViewController.view addSubview:label];
    }
    
    // MusicPlayerVC音乐播放用 设置音乐后台播放的会话类型
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    [session setActive:YES error:nil];
    
    return YES;
}

//首页
- (void)setupHomeViewController {
    ORHomeViewController *tabBarController = [[ORHomeViewController alloc] init];
    [self.window setRootViewController:tabBarController];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
    //获取箭头所指的控制器
    //id vc = [mainStoryboard instantiateInitialViewController];
    
    //通过标识获取storyboard的控制器
    //id vc = [mainStoryboard instantiateViewControllerWithIdentifier:@"RedVc"];
    
    //直接创建控制器
    //UIViewController *vc = [[UIViewController alloc] init];
    //vc.view.backgroundColor = [UIColor greenColor];
    
    //使用xib方法创建控制器
    //为什么是nib，因为程序打包运行后，xib会放在bundle目录下，并且后缀名为nib
    //OneViewController *vc = [[OneViewController alloc] initWithNibName:@"OneViewController" bundle:nil];
    
    //不指定xib
    //如果不指定xib,默认会先打同名但是没有controler后缀的xib,如果找不到，再找同名的xib去加载控制器view
    //使用init方法创建控制器，如果当前项目中有与类名相同的xib,会加载xib的界面成功控制器的视图，如果没有，就返回一个白色的View
    //BlueViewController *blueVc = [[BlueViewController alloc] init];
    
//    window.backgroundColor = [UIColor whiteColor];
//    self.window = window;
//    [window makeKeyAndVisible];
//
//    NormalDemoVC *menuVC = [[NormalDemoVC alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:menuVC];
//    window.rootViewController = nav;
    
    // 为什么控制器view直接添加到窗口上去不会旋转?
    // 旋转事件 -> UIApplication -> UIWindow -> 控制器里
    // [window addSubview:vc.view]; //内部是添加控制器的view到窗口上
}

#pragma mark 引导页
- (void)setupIntroductoryPage {
    if (BBUserDefault.isNoFirstLaunch) {
        return;
    }
    BBUserDefault.isNoFirstLaunch = YES;
    NSArray *images = @[@"introductoryPage1", @"introductoryPage2", @"introductoryPage3", @"introductoryPage4"];
    [introductoryPagesHelper showIntroductoryPageView:images];
}

#pragma mark 启动广告
- (void)setupAdveriseView {
    // TODO 请求广告接口 获取广告图片
    // 现在了一些固定的图片url代替
    NSArray *imageArray = @[@"http://imgsrc.baidu.com/forum/pic/item/9213b07eca80653846dc8fab97dda144ad348257.jpg", @"http://pic.paopaoche.net/up/2012-2/20122220201612322865.png", @"http://img5.pcpop.com/ArticleImages/picshow/0x0/20110801/2011080114495843125.jpg", @"http://www.mangowed.com/uploads/allimg/130410/1-130410215449417.jpg"];
    [AdvertiseHelper showAdvertiserView:imageArray];
}

- (void)registerAPN {
    // 注册通知
    if (@available(iOS 10.0, *)) { // iOS10 以上
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionAlert + UNAuthorizationOptionSound) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            
        }];
    } else {// iOS8.0 以上
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:setting];
    }
}

/**
 *  如果应用在后台,通过点击通知的时候打开应用会来到该代理方法
 *  如果应用在前台,接受到本地通知就会调用该方法
 *
 *  @param notification 通过哪一个通知来这里
 */
- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
//    if (application.applicationState == UIApplicationStateActive) return;
//    if (application.applicationState == UIApplicationStateInactive) {
//        NSLog(@"跳转");
//    }
    UILabel *label = [[UILabel alloc] init];
    label.frame = CGRectMake(0, 0, 300, 300);
    label.backgroundColor = [UIColor redColor];
    label.text = [NSString stringWithFormat:@"%@", notification];
    label.font = [UIFont systemFontOfSize:14.0];
    label.numberOfLines = 0;
    [self.window.rootViewController.view addSubview:label];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return YES;
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    //开启后台任务
    [application beginBackgroundTaskWithExpirationHandler:nil];
}

#pragma 接收远程事件
-(void)remoteControlReceivedWithEvent:(UIEvent *)event {
    // 判断是否为远程事件
    if (event.type == UIEventTypeRemoteControl) {
        NSLog(@"接收到远程事件");
//        UIEventSubtypeRemoteControlPlay                播放
//        UIEventSubtypeRemoteControlPause               暂停,
//        UIEventSubtypeRemoteControlStop                停止,
//        UIEventSubtypeRemoteControlPreviousTrack      上一首
//        UIEventSubtypeRemoteControlNextTrack           下一首,
        //event.subtype = UIEventSubtypeRemoteControlNextTrack
        //调用block
        self.mRemoteEventBlock(event);
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
