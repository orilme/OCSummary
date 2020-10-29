//
//  ToolMothod.m
//  ZhiZhu
//
//  Created by wt-vrs on 15/11/12.
//  Copyright © 2015年 wt-vrs. All rights reserved.
//

#import "ToolMothod.h"
#import "AppDelegate.h"
//#import "Reachability.h"
//#import "LoginViewController.h"
//#import <AFNetworking.h>

@interface ToolMothod()

//@property (nonatomic, strong) Reachability *conn;

@end


@implementation ToolMothod

//绘制线
+ (UIView *)createLineWithWidth:(CGFloat)width andHeight:(CGFloat)height andColor:(UIColor *)color{

    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    line.backgroundColor = color;
    
    return line;
}
//创建Button
+ (UIButton *)createRaiseQuestionsBtn{
    
    UIButton *raiseQueBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
    raiseQueBtn.layer.cornerRadius = 30;
//    raiseQueBtn.backgroundColor = RGBA(25, 88, 176, 1.0);
    [raiseQueBtn setImage:[UIImage imageNamed:@"btn_ask_n"] forState:UIControlStateNormal];
    
    return raiseQueBtn; 

}

/**
 *  获取字符串尺寸
 *
 */
+(CGSize)getStringSize:(NSString *)string CGSize:(CGSize)size attributes:(NSDictionary *)attribute
{
    return [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
}

/**
 *  时间戳转换为日期
 *
 *  @param dateStr 时间戳字符串
 *
 */
+(NSString *)changeDateWithString:(NSString *)dateStr
{
    if (dateStr) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateStr doubleValue]*0.001];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd"];
        return [dateFormat stringFromDate:date];
    }else
        return @"";
}

+(NSString *)changeDateTimeWithString:(NSString *)dateTimeStr
{
    if (dateTimeStr) {
        NSDate *date = [NSDate dateWithTimeIntervalSince1970:[dateTimeStr doubleValue]*0.001];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        return [dateFormat stringFromDate:date];
    }else
        return @"";
}

+(NSString *)getDateTimeString
{
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        // 设置日期格式
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        return [formatter stringFromDate:[NSDate date]];
}

+ (UIImage *)circleImageWithName:(NSString *)name borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    // 1.加载原图
    UIImage *oldImage = [UIImage imageNamed:name];
    
    // 2.开启上下文
    CGFloat imageW = oldImage.size.width + 22 * borderWidth;
    CGFloat imageH = oldImage.size.height + 22 * borderWidth;
    CGSize imageSize = CGSizeMake(imageW, imageH);
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    
    // 3.取得当前的上下文,这里得到的就是上面刚创建的那个图片上下文
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    // 4.画边框(大圆)
    [borderColor set];
    CGFloat bigRadius = imageW * 0.5; // 大圆半径
    CGFloat centerX = bigRadius; // 圆心
    CGFloat centerY = bigRadius;
    CGContextAddArc(ctx, centerX, centerY, bigRadius, 0, M_PI * 2, 0);
    CGContextFillPath(ctx); // 画圆。As a side effect when you call this function, Quartz clears the current path.
    
    // 5.小圆
    CGFloat smallRadius = bigRadius - borderWidth;
    CGContextAddArc(ctx, centerX, centerY, smallRadius, 0, M_PI * 2, 0);
    // 裁剪(后面画的东西才会受裁剪的影响)
    CGContextClip(ctx);
    
    // 6.画图
    [oldImage drawInRect:CGRectMake(borderWidth, borderWidth, oldImage.size.width, oldImage.size.height)];
    
    // 7.取图
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 8.结束上下文
    UIGraphicsEndImageContext();
    
    return newImage;
}

/**
 *  字符串转Url
 *
 */
//+(NSURL *)urlWithStr:(NSString *)urlStr
//{
//    if (urlStr) {
//        NSString *urlString = [testUrlString stringByAppendingString:urlStr];
//        NSURL *url = [NSURL URLWithString:urlString];
//        return url;
//    }
// 
//    return nil;
//}
/**
 *  弹窗
 *
 *  @param message 提示信息
 */
//-(void)pleaseLogin:(id)VC title:(NSString *)title{
//
//    if (IOS_8) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        // 创建按钮
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//            
//            [self.delegate pleaseLogin];
//        }];
//        // 创建按钮
//        // 注意取消按钮只能添加一个
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
//            // 点击按钮后的方法直接在这里面写
//            NSLog(@"取消");
//        }];
//        
//        [alert addAction:okAction];
//        [alert addAction:cancelAction];
//        [VC presentViewController:alert animated:YES completion:nil];
//    }else{
//    
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:VC cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [self.delegate pleaseLogin];
//        [alertView show];
//    
//    }
//}
/**
 *  消息弹窗
 *
 *  @param message 提示信息
 */
//-(void)newsAlertView:(id)VC title:(NSString *)title{
//    
//    if (IOS_8) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//
//        // 创建按钮
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"查看" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//    
//            [self.delegate goNewsVC];
//        }];
//        // 创建按钮
//        // 注意取消按钮只能添加一个
//        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"忽略" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction *action) {
//            // 点击按钮后的方法直接在这里面写
//            NSLog(@"取消");
//        }];
//        
//        [alert addAction:okAction];
//        [alert addAction:cancelAction];
//        [VC presentViewController:alert animated:YES completion:nil];
//    }else{
//        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:VC cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//        [self.delegate goNewsVC];
//        [alertView show];
//        
//    }
//}
/**
 *  弹窗
 *
 *  @param message 提示信息
 */
//+(void)alertView:(id)VC title:(NSString *)title{
//    
//    if (IOS_8) {
//        UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
//        
//        // 创建按钮
//        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction *action) {
//            
//        }];
//        
//        [alert addAction:okAction];
//        [VC presentViewController:alert animated:YES completion:nil];
//    }else{
//        
//        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title message:nil delegate:VC cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
//        [alertView show];
//        
//    }
//}
//+(BOOL)isLogin
//{
//    //判断用户状态
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *token = [userDefaults stringForKey:@"token"];
//    if (token && ![token isEqualToString:@""]) {
//        return YES;
//    }else{
//        return NO;
//    }
//}


//+ (NetworkStatusType)checkNetworkState
//{
//    // 1.检测wifi状态
//    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
//    
//    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
//    Reachability *conn = [Reachability reachabilityForInternetConnection];
//    
//    // 3.判断网络状态
//    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
//        NSLog(@"有wifi");
//        return NetworkStatusWiFi;
//        
//    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
//        NSLog(@"使用手机自带网络进行上网");
//        return NetworkStatusWWAN;
//        
//    } else { // 没有
//        NSLog(@"没有网络");
//        return NetworkStatusNONet;
//    }
//}

//+(void)userOut:(UIViewController *)VC
//{
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    [userDefaults removeObjectForKey:@"token"];
//    //移除本地缓存
//    NSString *pathString = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *pathStr = [pathString stringByAppendingPathComponent:@"userInfo.data"];
//    NSFileManager *defaultManager;
//    defaultManager = [NSFileManager defaultManager];
//    BOOL boolValue=[defaultManager removeItemAtPath: pathStr error: nil];
//    if (boolValue){
//        
//    }
//    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
//    appDelegate.personModel = nil;
//    appDelegate.userId = nil;
//    
//    //创建一个消息对象
//    NSNotification * notifi = [NSNotification notificationWithName:@"quitLogin" object:nil userInfo:nil];
//    //发送消息
//    [[NSNotificationCenter defaultCenter] postNotification:notifi];
//    
//    LoginViewController *loginVC = [[LoginViewController alloc]init];
//    [VC presentViewController:loginVC animated:YES completion:nil];
//    
//}
//+ (void)bottomMoveTop:(UIViewController *)selfVC To:(UIViewController *)VC{
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3f;
//    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn];
//    transition.fillMode = kCAFillModeForwards;
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromTop;
//    transition.delegate = self;
//    [selfVC.view.window.layer addAnimation:transition forKey:nil];
//    [selfVC.navigationController pushViewController:VC animated:NO];
//}
//+ (void)topMoveBottom:(UIViewController *)VC{
//    
//    CATransition *transition = [CATransition animation];
//    transition.duration = 0.3f;
//    transition.timingFunction = UIViewAnimationCurveEaseInOut;
//    transition.fillMode = kCAFillModeForwards;
//    transition.type = kCATransitionMoveIn;
//    transition.subtype = kCATransitionFromBottom;
//    transition.delegate = self;
//    [VC.view.window.layer addAnimation:transition forKey:nil];
//}
@end
