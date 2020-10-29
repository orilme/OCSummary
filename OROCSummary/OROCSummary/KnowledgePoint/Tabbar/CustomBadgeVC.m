//
//  CustomBadgeVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/2/24.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "CustomBadgeVC.h"
#import "UITabBar+CustomBadge.h"
#import "TabbarBasicUseVC.h"

@interface CustomBadgeVC ()<UITabBarControllerDelegate>

@end

@implementation CustomBadgeVC {
    NSInteger number;
    CustomBadgeType type;
}

-(instancetype)initWithText:(NSString *)text{
    if(self = [super init]){
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 200, 100)];
        label.text = text;
        label.textColor = [UIColor redColor];
        [self.view addSubview:label];
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 200, 100)];
        [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [button setTitle:@"change badge" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(changeBadge:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
        
        UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(100, 400, 200, 100)];
        [button2 setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
        [button2 setTitle:@"tabbar基本使用" forState:UIControlStateNormal];
        [button2 addTarget:self action:@selector(tabbarBasicUse) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button2];
        
        number = 100;
        type = kCustomBadgeStyleNone;
    }
    return self;
}

-(void)changeBadge:(UIButton *)btn{
    NSInteger index = [self.tabBarController.tabBar.items indexOfObject:self.tabBarItem];
    if(type == kCustomBadgeStyleNone){
        type = kCustomBadgeStyleNumber;
    }else if(type  == kCustomBadgeStyleNumber){
        if(number == 100){
            number = 1;
        }else if(number == 1){
            number = 10;
        }else if(number == 10){
            number = 100;
            type = kCustomBadgeStyleRedDot;
        }
    }else if(type == kCustomBadgeStyleRedDot){
        type = kCustomBadgeStyleNone;
    }
    [self.tabBarController.tabBar setBadgeStyle:type value:number atIndex:index];
}

// 分割线====================================
-(void)tabbarBasicUse {
    UITabBarController *tab = [[UITabBarController alloc]init];
    tab.tabBar.tintColor = [UIColor greenColor];
    
    //tab.tabBar表示标签栏
    //标签栏的高度固定为49,所以标签栏对背景图的尺寸也有严格的限制,如果尺寸不对会严重变形
    //设置标签栏的背景图
    //标签栏最多只能同时显示五个控件,如果多余五个会显示一个more控件,用户体验不好
    [tab.tabBar setBackgroundImage:[UIImage imageNamed:@"tabbg"]];
    //tab.tabBar.hidden = YES;//隐藏标签栏
    //因为系统自带的标签栏对图片的支持有限,且字体大小不容易改变,结果就是不够炫
    //为了让B格高一点,可以隐藏标签栏并在原标签栏的的位置放一个imageView,并在imageView上放一些定制的button,点button设置TabBarController的selectedIndex或selectedController实现各页面的切换
    
    TabbarBasicUseVC *first = [[TabbarBasicUseVC alloc]init];
    TabbarBasicUseVC *second = [[TabbarBasicUseVC alloc]init];
    TabbarBasicUseVC *third = [[TabbarBasicUseVC alloc]init];
    TabbarBasicUseVC *nav3 = [[UINavigationController alloc]initWithRootViewController:third];
    TabbarBasicUseVC *fourth = [[TabbarBasicUseVC alloc]init];
    TabbarBasicUseVC *fifth = [[TabbarBasicUseVC alloc]init];
    TabbarBasicUseVC *sixth = [[TabbarBasicUseVC alloc]init];
    //把控制器加入TabBarControllers,系统回个每个视图控制器增加引用计数
    tab.viewControllers = @[first,second,nav3,fourth,fifth,sixth];
    
    
    //任何一个视图控制器都有一个属性,表示其对应标签栏上的标签
    first.tabBarItem.title = @"第一页";
    first.tabBarItem.image = [UIImage imageNamed:@"tab_0"];
    first.tabBarItem.badgeValue = @"8";
    second.tabBarItem.title = @"第二页";
    second.tabBarItem.badgeValue = @"6";
    second.tabBarItem.image = [UIImage imageNamed:@"tab_1"];
    
    //因为第三个页面对应的是导航控制器,所以定制标签的时候应该用导航控制器设tabBarItem置
    //nav3.tabBarItem.title = @"第三页";//等于nav3.title = @"第三页";
    third.title = @"第三页";//这种方法不同于前两种,这种方法既会出现在标签栏上也会出现在导航栏上
    //third.tabBarItem.image = [UIImage imageNamed:@"tab_2"];因为third并没有直接放在TabBarController里,所以不能能这样写
    nav3.tabBarItem.image = [UIImage imageNamed:@"tab_2"];
    
    fourth.tabBarItem.title = @"第四页";
    //设置标签栏上的图标  参数一:选中状态的图标  参数二:默认状态的图标
    [fourth.tabBarItem setFinishedSelectedImage:[UIImage imageNamed:@"tab_s"] withFinishedUnselectedImage:[UIImage imageNamed:@"tab_3"]];//方法已经过时,不建议用了
    
    //创建标签栏上的标签 参数一:标题  参数二:默认状态的图标  参数三:选中状态的图标
    UITabBarItem *tabBarItem = [[UITabBarItem alloc]initWithTitle:@"第五页" image:[UIImage imageNamed:@"tab_0"] selectedImage:[UIImage imageNamed:@"tab_s"]];
    fifth.tabBarItem = tabBarItem;//也会增加引用计数
    
    sixth.tabBarItem.title = @"第六页";
    
    //tab.selectedIndex = 1;//设置第一个(标签二)处于选中状态,默认是第0个
    tab.selectedViewController = second;//设置second对应的标签被选中,效果和上面一样
    
    
    tab.delegate = self;//设置代理
    [UIApplication sharedApplication].keyWindow.rootViewController = tab;
}

//UITabBarController代理的方法(事件),当用户点标签导致页面切换(视图控制器切换)时被自动调用
//参数一:触发事件的TabBarController  参数二:被选中的标签对应的视图控制器
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController{
    NSLog(@"didSelectViewController:%@,index:%lu",viewController,tabBarController.selectedIndex);
}

//代理的方法,开始(标签多于五个)定制标签顺序的时候会被系统自动调用
- (void)tabBarController:(UITabBarController *)tabBarController willBeginCustomizingViewControllers:(NSArray *)viewControllers{
    
}
//代理的方法,结束(标签多于五个)定制标签顺序的时候会被系统自动调用
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed{
    NSLog(@"结束定制 changed :%d, :%@",changed,viewControllers);
}

@end
