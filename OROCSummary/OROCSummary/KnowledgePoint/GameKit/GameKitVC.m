//
//  GameKitVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/20.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "GameKitVC.h"
#import <GameKit/GameKit.h>

#define kHighScore @"airplay.highscores"

@interface GameKitVC ()<GKGameCenterControllerDelegate> {
    int64_t _highScores;
}

@end

@implementation GameKitVC
/**
 1. 在使用游戏中心时，应该用localPlayer=>本地玩家
 
 之所以用本地玩家的原因是：如果用户不登录游戏中心，则建立一个临时用户记录游戏的得分情况。
 
 判断用户是否已经登录游戏中心，如果没有登录，会自动弹出游戏中心的对话框，要求用户登录
 @property(nonatomic, copy) void(^authenticateHandler)(UIViewController *viewController, NSError *error)
 
 2. 在使用游戏中心时，如果网络状态不可用，游戏中心会缓存住玩家的分数，待到网络可用时，重新提交，此过程不需要程序员干预。
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton * btn = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 300, 50)];
    [btn setTitle:@"增加高分榜" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn addTarget:self action:@selector(reportLeadboard) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton * btn2 = [[UIButton alloc]initWithFrame:CGRectMake(10, 170, 300, 50)];
    [btn2 setTitle:@"查看高分榜" forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor purpleColor];
    [btn2 addTarget:self action:@selector(viewHighScore) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    
    // 加载初始化玩家上一次的分数
    _highScores = 1000000;
    
    // 连接到游戏中心
    [[GKLocalPlayer localPlayer] setAuthenticateHandler:^(UIViewController *gameController, NSError *error) {
        
        // 1. 判断用户是否已经登录，如果没有，显示游戏中心视图控制器
        if (![GKLocalPlayer localPlayer].isAuthenticated) {
            
            // 显示视图控制器，要求用户登录本地的游戏中心，以记录所有游戏的游戏记录
            [self presentViewController:gameController animated:YES completion:nil];
        }
    }];
}

#pragma mark - 游戏中心的Banner提示
- (void)showBanner {
    // 通知用户，譬如获取到某一个成就
    [GKNotificationBanner showBannerWithTitle:@"哇哈哈" message:@"你要倒霉了" completionHandler:nil];
}

#pragma mark - 增加高分榜
- (void)reportLeadboard {
    [self showBanner];
    
    GKScore *score = [[GKScore alloc] initWithLeaderboardIdentifier:kHighScore];
    // 设置分值
    _highScores += 100;
    score.value = _highScores;
    
    // 提交分数
    [GKScore reportScores:@[score] withCompletionHandler:^(NSError *error) {
        NSLog(@"提交完成");
    }];
}

- (void)viewHighScore {
    GKGameCenterViewController *controller = [[GKGameCenterViewController alloc] init];
    controller.gameCenterDelegate = self;
//    controller.viewState = GKGameCenterViewControllerStateLeaderboards;
    controller.viewState = GKGameCenterViewControllerStateAchievements;
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark 代理方法
- (void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

