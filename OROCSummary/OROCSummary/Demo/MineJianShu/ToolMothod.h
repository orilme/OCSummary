//
//  ToolMothod.h
//  ZhiZhu
//
//  Created by wt-vrs on 15/11/12.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import <Masonry.h>

typedef NS_ENUM(NSInteger, NetworkStatusType) {
    NetworkStatusWiFi,
    NetworkStatusWWAN,
    NetworkStatusNONet
};

@protocol PleaseLoginDelegate <NSObject>

- (void)pleaseLogin;  //登录
@optional
- (void)goNewsVC; //消息弹窗

@end


@interface ToolMothod : NSObject

//+ (void)clickLeftSlider;

+(UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color;
//
//+ (UIButton *)createRaiseQuestionsBtn;

+(CGSize)getStringSize:(NSString *)string CGSize:(CGSize)size attributes:(NSDictionary *)attribute;

+(NSString *)changeDateWithString:(NSString *)dateStr;

+(NSString *)changeDateTimeWithString:(NSString *)dateTimeStr;

+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

//+(NSURL *)urlWithStr:(NSString *)urlStr;
//
//-(void)pleaseLogin:(id)VC title:(NSString *)title;
//
//+(void)alertView:(id)VC title:(NSString *)title;
//
//-(void)newsAlertView:(id)VC title:(NSString *)title;

+(BOOL)isLogin;

+(NSString *)getDateTimeString;

//+ (NetworkStatusType)checkNetworkState;
//
//+(void)userOut:(UIViewController *)VC;
//
//+ (void)bottomMoveTop:(UIViewController *)VC To:(UIViewController *)VC; //转场动画:从下往上
//
//+ (void)topMoveBottom:(UIViewController *)VC; //转场动画:从上往下

//+ (NSString *)judgeTimeStr:(NSString *)timeStr;
@property (nonatomic,weak)id<PleaseLoginDelegate>delegate;
@end