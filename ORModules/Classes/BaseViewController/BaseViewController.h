//
//  BastViewController.h
//  Axc项目BaseViewController框架架构
//
//  Created by Axc_5324 on 16/6/22.
//  Copyright © 2016年 赵新. All rights reserved.
//

#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

#import <UIKit/UIKit.h>

/**
 *  宏指针定义 __nonnull 类型
 *
 */
NS_ASSUME_NONNULL_BEGIN

/**
 *  BaseViewController代理方法
 */
@protocol BaseViewControllerDelegate <NSObject>

/**
 *  预留代理接口
 */

@end


/**
 *  Controller基类：BaseViewController
 */
@interface BaseViewController : UIViewController

/**
 *  打印日志情况默认YES
 */
@property(nonatomic,assign)BOOL axcBasePrintLog;

/**
 *  上拉加载下拉刷新页数page
 */
@property(nonatomic,assign)int page;

/**
 *  自带声明一个tableView对象
 */
@property(nonatomic,strong)UITableView * tableView;

/**
 *  是否开启全继承左滑返回手势 默认NO
 */
@property(nonatomic,assign)BOOL OpenTheLeftBackOfAll;

/**
 *  预留代理
 */
@property(nonatomic,weak)id <BaseViewControllerDelegate> delegate;

/**
 *  屏幕高
 */
@property(nonatomic,assign)CGFloat screenHight;

/**
 *  屏幕宽
 */
@property(nonatomic,assign)CGFloat screenWidth;

/**
 *  基类请求数据
 */
- (void)axcBaseRequestData;

/**
 *  基类添加右图片按钮
 *
 *  @param image image类型
 */
- (void)axcBaseAddRightBtnWithImage:(UIImage * )image;

/**
 *  基类右图片按钮触发方法
 *
 *  @param sender UIButton
 */
- (void)axcBaseClickBaseRightImageBtn:(UIButton * )sender;

/**
 *  基类添加右系统风格按钮
 *
 *  @param type UIBarButtonSystemItem类型
 */
- (void)axcBaseAddRightBtnWithType:(UIBarButtonSystemItem)type;

/**
 *  基类右图片按钮触发方法
 *
 *  @param sender UIBarButtonItem
 */
- (void)axcBaseClickBaseRightTypeBtn:(UIBarButtonItem * )sender;

/**
 *  AlertView警告框
 *
 *  @param message 警告消息
 */
- (void)axcBasePopUpWarningAlertViewWithMessage:(NSString * )message;

/**
 *  AlertView提示框
 *
 *  @param message 提示信息
 *  @param target  代理
 */
- (void)axcBasePopUpPromptAlertViewWithMessage:(NSString * )message addTarget:(nullable id)target;

/**
 *  下拉刷新
 */
- (void)axcBaseLoadNewData;

/**
 *  上拉加载
 */
- (void)axcBaseLoadMoreData;

/**
 *  开启左滑返回上一页手势(当OpenTheLeftBackOfAll失效时可以调用，特殊情况需要在viewDidAppear:(BOOL)animated中加入    [super viewDidAppear:animated] 方法即可
 */
- (void)axcBaseOpenTheLeftBackSkip;



/**
 *  宏指针定义下文
 */
NS_ASSUME_NONNULL_END

@end
