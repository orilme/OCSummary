//
//  Tool.h
//
//  Created by apple on 15/6/24.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define IOS7_OR_LATER		( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )
#define kAPPMAINBGCOLOR [Tool colorWithHexString:@"f0f2ed"]
#define kDEFAULTIMAGE [UIImage imageNamed:@"default_person"]
#define kBLACKTITLECOLOR [Tool colorWithHexString:@"a47945"]
#define kSEPARATORCOLOR [Tool colorWithHexString:@"d9d9d9"]
#define kLEFTVIEWCOLOR [Tool colorWithHexString:@"3d3d3d"]
#define kTITLECOLOR [Tool colorWithHexString:@"ff444f"]


@interface Tool : NSObject

////判断是否是正确的手机号
//+ (BOOL)checkTel:(NSString *)str;
//
//+(BOOL)checkFaxNumber:(NSString *)number;
////ip地址校验
//+ (BOOL)checkIpAddress:(NSString *)str;
////判断是否是正确的车牌号
//+ (BOOL)checkCar:(NSString *)str;
////判断是否是正确的身份证号
//+ (BOOL)checkPerson:(NSString *)str;
////设置导航条颜色 默认BgColor为全局使用颜色  titleColor为白色
//+ (void)setNavBarBgColor:(UINavigationController *)nav;
//+ (void)setNavBarBgColor1:(UINavigationController *)nav;
////延迟执行的block
//+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
//
////调出键盘时屏幕上移
//+ (void)moveSelfView:(UIViewController *)ctrl withHeightAwayfromCenter:(CGFloat) height;
////将self.view设置回初始位置
//+ (void)setSeleViewBackDefault:(UIViewController *)ctrl;
//
////添加导航栏左侧返回按钮
//+ (void)addBackButton:(UIViewController*)ctrl withClickAction:(SEL)action;
////添加导航栏右侧图片按钮
//+ (void)addNavRightButton:(UIViewController*)ctrl withPicName:(NSString *)picName withClickAction:(SEL)action;
////添加导航栏右侧标题按钮
//+ (void)addoriginalNavRightButton:(UIViewController*)ctrl withPicName:(NSString *)picName withClickAction:(SEL)action;
//
////添加无数据默认背景图
//+ (void)addNoDataBackgroundImageView:(UIImageView *)imgView forViewController:(UIViewController*)ctrl;
//+ (void)addNoDataBackgroundforViewController:(UIViewController*)ctrl;
////页面从nav下开始计算
//+ (void)setEdgesForExtendedLayout:(UIViewController*)ctrl;
//
////设置button点击效果
//+ (void)setBtnSelectedStyle:(UIButton*)sender Image:(NSString*)image;
//
////十六进制的颜色转换为UIColor
//+ (UIColor *) colorWithHexString: (NSString *)color;
//
////设置nav的titleview
//+ (void)setNavTitleView:(UIViewController*)ctrl;
//
////图片缩放到指定大小尺寸
//+ (UIImage *)imageFromView:(UIView *)viewBac;
//
////根据文字获取label大小
//+ (CGSize)getLabelSizeWithText:(NSString*)str AndSize:(CGSize)siz AndFont:(UIFont*)font;
//
////时间戳转时间
//+ (NSString*)timestampToString:(NSString*)stamp Format:(NSString*)format;
//
////获取当前系统的时间戳
//+(long)getTimeSp;
//
////时间转日期
//+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate;
//
////比较日期大小
//+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay;
////将时间戳转换成NSDate
//+(NSDate *)changeSpToTime:(NSString*)spString;
//
////将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
//+(NSString*)nsdateToString:(NSDate *)date;
////判断字符串是否为空
//+ (BOOL) isBlankString:(NSString *)string;
//
////+ (BOOL)isExistenceNetwork;
////数组拼接为字符串
//+ (NSString *)StringConversionWithArr:(NSArray *)array;
//
////图片颜色生成图片
//+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;
//
////显示提示信息
//+ (void)ShowpromptWithMsg:(NSString *)Msg;
//
////显示提示信息
//+ (void)ShowpromptWithMsg1:(NSString *)Msg;
//
////视图点击事件
//+ (void)addTapgestureforView:(UIView *)TapView withPicName:(UIViewController *)ctrl withClickAction:(SEL)action;
//
//+ (void)addoriginalNavRightButton:(UIViewController*)ctrl WithTitleName:(NSString *)TitleName withClickAction:(SEL)action;
//
////月份的英文显示
//+ (NSString *)changeTime:(int)num;
//
//+ (CGRect)MDCGRectMakeOrginX:(CGFloat)OrginX OrginY:(CGFloat)OrginY SizeWidth:(CGFloat)SizeWidth SizeHeight:(CGFloat)SizeHeight;
//+ (CGFloat)MDOrginX:(CGFloat)OrginX;
//+ (CGFloat)MDOrginY:(CGFloat)OrginY;
//+ (CGFloat)MDSizeWidth:(CGFloat)SizeWidth;
//+ (CGFloat)MDSizeHeight:(CGFloat)SizeHeight;
//
////截屏
//+(UIImage *)screenImageWithSize:(CGSize )imgSize;
////合成图片
//+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect;
////保存截图是否成功提示
//+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo;
//
//// 根据图片url获取图片尺寸
//+(CGSize)getImageSizeWithURL:(id)imageURL;
////  获取PNG图片的大小
//+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request;
////  获取gif图片的大小
//+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request;
////  获取jpg图片的大小
//+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request;
//
////判断是否是手机号码
//- (BOOL)isMobile;
//
////创建lable
//+(UILabel *)lableWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color;
////创建button
//+(UIButton *)btnWithTitle:(NSString *)title frame:(CGRect)frame imageName:(NSString *)imageName tag:(NSInteger)tag;

@end
