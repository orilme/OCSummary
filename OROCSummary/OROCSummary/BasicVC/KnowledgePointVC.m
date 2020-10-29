//
//  KnowledgePointVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/30.
//  Copyright © 2019 orilme. All rights reserved.
//  知识点

#import "KnowledgePointVC.h"
#import "CustomBadgeVC.h"
#import "UITabBar+CustomBadge.h"

@interface KnowledgePointVC ()
@property (nonatomic, copy) NSArray *meunArr;
@end

@implementation KnowledgePointVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.navigationItem.title = @"基础知识点~~";
    self.meunArr = @[
    // 基础"
    @{@"headName": @"基础",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"知识点", @"className": @"BasicKnowledgeVC"},
                @{@"menuName": @"算法-递归", @"className": @"RecursiveVC"},
                @{@"menuName": @"VC生命周期", @"className": @"LifeCycleOneVC"},
                @{@"menuName": @"继承", @"className": @"InheritVC"},
                @{@"menuName": @"枚举", @"className": @"EnumVC"},
                @{@"menuName": @"分类和类扩展", @"className": @"CategoryVC"},
                @{@"menuName": @"协议", @"className": @"ProtocolVC"},
                @{@"menuName": @"Block", @"className": @"BlockVC"},
                @{@"menuName": @"单例", @"className": @"SingletonVC"},
                @{@"menuName": @"Block", @"className": @"BlockVC"},
                @{@"menuName": @"KVC", @"className": @"KVCStudyVC"},
                @{@"menuName": @"KVO", @"className": @"KVOStudyVC"},
                @{@"menuName": @"WKWebView与JS交互", @"className": @"WKWebViewJSVC"},
                @{@"menuName": @"UIWebView与JS交互", @"className": @"UIWebViewJSVC"},
                @{@"menuName": @"Touch事件", @"className": @"TouchVC"},
                @{@"menuName": @"UITextView自适应高度", @"className": @"UITextViewAutoHeightVC"},
                @{@"menuName": @"CustomBadge", @"className": @"CustomBadgeVC"},
                @{@"menuName": @"CollectionLayout使用", @"className": @"CircleCollectionVC"},
                @{@"menuName": @"CollectionLayout使用2", @"className": @"LayoutBaseUseVC"},
                @{@"menuName": @"苹果内购", @"className": @"AppleStoreVC"},
                @{@"menuName": @"ARKit", @"className": @"ARSCNViewVC"},
                @{@"menuName": @"CoreMotion(陀螺仪、陀螺仪、加速剂)", @"className": @"CoreMotionVC"},
                @{@"menuName": @"距离传感器、摇一摇", @"className": @"ProximityMonitorVC"},
                @{@"menuName": @"加速计举例", @"className": @"CoreMotionExampleVC"},
                @{@"menuName": @"NSString、NSData、typedef、static", @"className": @"BasicTypeVC"},
                @{@"menuName": @"Exception", @"className": @"ExceptionVC"},
                @{@"menuName": @"导航栏基础使用", @"className": @"NavigationOneVC"},
                @{@"menuName": @"导航栏透明度", @"className": @"NavTableViewController"},
                @{@"menuName": @"键盘弹出视图移动通知", @"className": @"KeyboardOneVC"},
                @{@"menuName": @"KeyboardToolbarTestVC", @"className": @"KeyboardToolbarTestVC"},
                @{@"menuName": @"指针", @"className": @"PointerVC"},
                @{@"menuName": @"应用间的跳转", @"className": @"JumpVC"},
                @{@"menuName": @"通讯录有UI", @"className": @"AddressBookUIVC"},
                @{@"menuName": @"通讯录无UI", @"className": @"AddressBookVC"},
                @{@"menuName": @"发短信", @"className": @"SendMessageVC"},]}.mutableCopy,
    // UITableview
    @{@"headName": @"UITableview",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"Tableview左滑菜单", @"className": @"EditTableViewVC"},
                @{@"menuName": @"通讯录点击效果", @"className": @"AdressBookTableVC"},
                @{@"menuName": @"模拟TableView Delegate、Datasource", @"className": @"SimulateTableViewDelegateDatasourceVC"},]}.mutableCopy,
    // Runtime
    @{@"headName": @"Runtime",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"Runtime探索", @"className": @"RuntimeExploreVC"},
                @{@"menuName": @"RuntimeResolveMethod", @"className": @"RuntimeResolveMethodVC"},
                @{@"menuName": @"RuntimeForwardMethod", @"className": @"RuntimeForwardMethodVC"},
                @{@"menuName": @"RuntimeSignatureMethod", @"className": @"RuntimeSignatureMethodVC"},
                @{@"menuName": @"Runtime实现防止button的快读点击", @"className":@"RuntimeButtonVC"},]}.mutableCopy,
    // RunLoop
    @{@"headName": @"RunLoop",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"RunLoop", @"className": @"RunLoopVC"}]}.mutableCopy,
    // 多线程
    @{@"headName": @"多线程",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"GCD", @"className": @"GCDVC"},
                 @{@"menuName": @"GCDBarrier", @"className": @"GCDBarrierVC"},
                 @{@"menuName": @"GCDGroupDemo", @"className": @"GCDGroupDemoVC"},
                 @{@"menuName": @"GCD 信号量使用 弹窗依次弹出", @"className": @"GCDSemaphoreVC"},
                 @{@"menuName": @"NSOperation", @"className": @"NSOperationVC"},
                 @{@"menuName": @"NSThread", @"className": @"NSThreadVC"},
                 @{@"menuName": @"锁(NSLock、@synchronized、NSCondition)", @"className": @"ThreadLockVC"},]}.mutableCopy,
    // 组件化
    @{@"headName": @"组件化",
      @"isFold": @"1",
      @"value": @[@{@"menuName": @"组件化举例", @"className": @"ModuleVC"}]}.mutableCopy,
    // 内存管理
    @{@"headName": @"内存管理",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"AutoreleasePool", @"className": @"AutoreleasePoolVC"},
                    @{@"menuName": @"引用计数", @"className": @"MemManagementCountVC"},]}.mutableCopy,
    // 通知
    @{@"headName": @"通知",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"Notification", @"className": @"NotificationVC"},
                    @{@"menuName": @"通知-本地通知", @"className": @"LocalNotificationVC"},
                    @{@"menuName": @"KVC", @"className": @"KVCViewController"},
                    @{@"menuName": @"KVO", @"className": @"KVOViewController"},]}.mutableCopy,
    // 网络相关
    @{@"headName": @"网络相关",
    @"isFold": @"1",
    @"value":   @[@{@"menuName": @"URLSeccion基本试用", @"className": @"URLSeccionOneVC"},
                 @{@"menuName": @"URLSeccion断点续传", @"className": @"URLSeccionTwoVC"},
                 @{@"menuName": @"HTTPCookieStorage基本使用", @"className": @"HTTPCookieStorageVC"},]}.mutableCopy,
    // 自定义视图
    @{@"headName": @"自定义视图",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"Quartz2D(基于CoreGraphics API的绘图框架，C语言）", @"className": @"Quartz2DVC"},
                    @{@"menuName": @"UIBezierPath1(属于UIKit，对Core Graphics的封装，OC语言)", @"className": @"CoreGraphicsVC"},
                    @{@"menuName": @"UIBezierPath2", @"className": @"CoreGraphicsTwoVC"},
                    @{@"menuName": @"CALayer基本使用(拉伸、旋转、圆角图片、CALayer)", @"className": @"CALayerVC"},
                    @{@"menuName": @"自定义图层（位置和锚点）", @"className": @"CALayerCustomVC"},
                    @{@"menuName": @"DrawRect示例", @"className": @"DrawRectDemoVC"},
                    @{@"menuName": @"DrawRect示例2", @"className": @"DrawRectDemoaTwoVC"},
                    @{@"menuName": @"DrawRect涂鸦", @"className": @"DrawRectScrawlVC"},
                    @{@"menuName": @"DrawRect涂鸦2", @"className": @"DrawRectScrawlColorVC"},]}.mutableCopy,
    
    // 动画
    @{@"headName": @"动画",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"CABasicAnimation", @"className": @"CABasicAnimationVC"},
                    @{@"menuName": @"CAKeyframeAnimation", @"className": @"CAKeyframeAnimationVC"},
                    @{@"menuName": @"图层的隐式动画(CATransaction)", @"className": @"CATransitionVC"},
                    @{@"menuName": @"CAAnimationGroup", @"className": @"CAAnimationGroupVC"},
                    @{@"menuName": @"UIViewAnimation", @"className": @"UIViewAnimationVC"},
                    @{@"menuName": @"AnimationDemo", @"className": @"AnimationDemoVC"},
                    @{@"menuName": @"AnimationDemo2", @"className": @"AnimationDemoTwoVC"},
                    @{@"menuName": @"AnimationDemo3", @"className": @"AnimationDemoThreeVC"},
                    @{@"menuName": @"类似于探探翻页动画", @"className": @"AnimationDemoFourVC"},
                    @{@"menuName": @"仿真动画", @"className": @"UIDynamicController"},]}.mutableCopy,
    // 持久化存储
    @{@"headName": @"持久化存储",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"Plist存储", @"className": @"PlistVC"},
                    @{@"menuName": @"UserDefaults", @"className": @"UserDefaultsVC"},
                    @{@"menuName": @"NSCoding(NSKeyedArchiver、NSKeyedUnarchiver)", @"className": @"NSCodingVC"},
                    @{@"menuName": @"ArchiveDemo", @"className": @"ArchiveDemoVC"},
                    @{@"menuName": @"NSCache", @"className": @"NSCacheVC"},
                    @{@"menuName": @"FileManager", @"className": @"FileManagerVC"},
                    @{@"menuName": @"FMDB（将任意对象存进数据库）", @"className": @"FMDBDemoVC"},]}.mutableCopy,
    // 响应链
    @{@"headName": @"响应链",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"响应链", @"className": @"ResponderChainVC"},
                    @{@"menuName": @"触摸事件的传递", @"className": @"TouchChainVC"},]}.mutableCopy,
    // 手势
    @{@"headName": @"手势",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"手势", @"className": @"GestureVC"},
                  @{@"menuName": @"手势拼图demo", @"className": @"GesturePuzzleVC"},
                  @{@"menuName": @"CAAnimationGroup", @"className": @"CAAnimationGroupVC"},
                  @{@"menuName": @"CAAnimationGroup", @"className": @"CAAnimationGroupVC"},
                  @{@"menuName": @"CAAnimationGroup", @"className": @"CAAnimationGroupVC"},
                  @{@"menuName": @"CAAnimationGroup", @"className": @"CAAnimationGroupVC"},]}.mutableCopy,
    // 音频
    @{@"headName": @"音频",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"Audio-短音频播放", @"className": @"ShortAudioPlayVC"},
                  @{@"menuName": @"Audio-MP3播放", @"className": @"AudioPlayVC"},
                  @{@"menuName": @"Audio-录音", @"className": @"VoiceRecorderVC"},
                  @{@"menuName": @"Audio-歌词同步", @"className": @"AudioLyricSyncVC"},]}.mutableCopy,
    // 其他
    @{@"headName": @"其他",
      @"isFold": @"1",
      @"value":   @[@{@"menuName": @"游戏中心", @"className": @"GameKitVC"},
                   @{@"menuName": @"加密", @"className": @"EncryptVC"},]}.mutableCopy,
    ];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.meunArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *array = self.meunArr[section][@"value"];
    return [self.meunArr[section][@"isFold"]  isEqual: @"1"] ? 0 : array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text =  self.meunArr[indexPath.section][@"value"][indexPath.row][@"menuName"];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *dict = self.meunArr[indexPath.section][@"value"][indexPath.row];
    if ([dict[@"className"] isEqualToString:@"LifeCycleOneVC"]) {
        UIStoryboard *secondStoryBoard = [UIStoryboard storyboardWithName:@"LifeCycle" bundle:nil];
        UIViewController* test2obj = [secondStoryBoard instantiateViewControllerWithIdentifier:@"LifeCycleOneVC"];
        [self.navigationController pushViewController:test2obj animated:YES];
    }else if ([dict[@"className"] isEqualToString:@"UIDynamicController"]
              || [dict[@"className"] isEqualToString:@"UITextViewAutoHeightVC"]) {
        UIViewController *vc = [[NSClassFromString(dict[@"className"]) alloc]initWithNibName:dict[@"className"] bundle:nil];
        vc.title = dict[@"menuName"];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([dict[@"className"] isEqualToString:@"CustomBadgeVC"]) {
        UITabBarController *tabController = [UITabBarController new];
        CustomBadgeVC *controller1 = [[CustomBadgeVC alloc] initWithText:@"haha"];
        CustomBadgeVC *controller2 = [[CustomBadgeVC alloc] initWithText:@"hehe"];
        tabController.viewControllers = @[ controller1, controller2];
        
        UITabBarItem *item0 = tabController.tabBar.items[0];
        item0.title = @"haha";
        item0.image = [UIImage imageNamed:@"icon_info"];
        
        UITabBarItem *item1 = tabController.tabBar.items[1];
        item1.title = @"hehe";
        item1.image = [UIImage imageNamed:@"icon_news"];
        
        //通过这两个参数来调整badge位置
        [tabController.tabBar setTabIconWidth:29];
        [tabController.tabBar setBadgeTop:9];

        [self.navigationController pushViewController:tabController animated:YES];
    }else {
        UIViewController *vc = [[NSClassFromString(dict[@"className"]) alloc]init];
        vc.title = dict[@"menuName"];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Screen_Width, 60)];
    headerView.backgroundColor = UIColor.groupTableViewBackgroundColor;
    UIButton *headerBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    headerBtn.frame = CGRectMake(0, 1, Screen_Width, 58);
    headerBtn.tag = section;
    headerBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    headerBtn.titleEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
    headerBtn.backgroundColor = UIColor.whiteColor;
    headerBtn.titleLabel.font = [UIFont systemFontOfSize:20];
    [headerBtn setTitle:self.meunArr[section][@"headName"] forState:UIControlStateNormal];
    [headerBtn addTarget:self action:@selector(onBtnheaderBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [headerView addSubview:headerBtn];
    return headerView;
}

- (void)onBtnheaderBtnClicked:(UIButton *)sender {
    if ([self.meunArr[sender.tag][@"isFold"]  isEqual: @"1"]) {
        self.meunArr[sender.tag][@"isFold"] = @"0";
    }else {
        self.meunArr[sender.tag][@"isFold"] = @"1";
    }
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:sender.tag];//只刷新当前行
    [self.tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end

