//
//  DrawRectDemoaTwoVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/6.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "DrawRectDemoaTwoVC.h"

@interface DrawRectDemoaTwoVC ()

@end

@implementation DrawRectDemoaTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self testImgBackground];
}

- (void)testImgBackground {
    
    // 添加控制器的背景
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"textBg"]];
    
    // 0.从bundle的neww文件获取文字
    // 0.1获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"news" ofType:nil];
    
    // 0.2读取里面文字
    NSString *news = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    // 1.把文字显示上去
    // 显示多行数据，并且可编辑
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    
    // 设置文本
    textView.text = news;
    // 设置文字的大小
    //textView.font = [UIFont systemFontOfSize:20];
    textView.font = [UIFont fontWithName:@"Verdana" size:20];
    
    // 当前系统可用的字体
    NSLog(@"%@",[UIFont familyNames]);
    
    
#warning 图片不放在suportingfile，有可能是图片问题,图片放在images.xcassests
    
    textView.backgroundColor = [UIColor clearColor];
    // 设置TextView的背景
    textView.alpha = 0.5;
    [self.view addSubview:textView];
    
    
    // 2.设置文字背景
    // 2.1 画一个虚线的背景图片
    UIImage *dashBgImage = [self dashBgImage];
    
    // 2.2虚线的背影图片平铺在TextView的backgroundColor
    //textView.backgroundColor = [UIColor colorWithPatternImage:dashBgImage];
    
    // 2.2创建一个ImageView，添加到TextView的第一个位置
    UIImageView *bgImageView = [[UIImageView alloc] init];

    // 背景设置大小的时候，是根文字的字数和字体大小决定
    // 计算文本的size
    CGFloat screnW = [UIScreen mainScreen].bounds.size.width;
    
    // 文字需要的尺寸
    CGSize textNeedSize = [news boundingRectWithSize:CGSizeMake(screnW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:textView.font} context:nil].size;
    
    bgImageView.frame = CGRectMake(0, 0, textNeedSize.width, textNeedSize.height);
    bgImageView.backgroundColor = [UIColor colorWithPatternImage:dashBgImage];
    
    [textView insertSubview:bgImageView atIndex:0];
    
    
}



#pragma mark 带虚线的背景图片
-(UIImage *)dashBgImage{
    // 使用位图上下文
    CGFloat bgW = [UIScreen mainScreen].bounds.size.width;
    CGFloat bgH = 22;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(bgW, bgH), NO, 0.0);
    //UIGraphicsBeginImageContext(CGSizeMake(bgW, bgH));
    
    
    CGContextRef bitmapContext =  UIGraphicsGetCurrentContext();
    
    // 画虚线
    // 计算线的位置
    CGFloat lineH = 1;
    CGFloat lineY = bgH - lineH;

    // 设置虚线每一段距离长度
    CGFloat lengths[3] = {20,5,10};
    
    // 设置虚线
    [[UIColor blueColor] set];
    CGContextSetLineDash(bitmapContext, 0, lengths, 3);
    CGPoint points[2] = {{0,lineY},{bgW,lineY}};
    CGContextAddLines(bitmapContext, points, 2);
    CGContextStrokePath(bitmapContext);
    
    
    // 获取背景图片
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    
    
    // 结束编辑
    UIGraphicsEndImageContext();
    
    return bgImage;
}

@end
