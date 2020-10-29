//
//  Quartz2DPieVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/17.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "Quartz2DPieVC.h"
#import "CZPieView.h"//饼状图
#import "CircleImageView.h"
#import "UIImage+CZ.h"

@interface Quartz2DPieVC ()
@property (weak, nonatomic) CircleImageView *imageView;
@end

@implementation Quartz2DPieVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 分类显示裁剪的图片
    //直接显示裁剪的图片
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 400, 200, 200)];
    imgView.image =[UIImage circleImageWithImageName:@"aimage" borderColor:[UIColor yellowColor] borderWidth:3];
    [self.view addSubview:imgView];
    
    
    //实现饼状图 - quartz2d 画不同比例的扇形
    //1.自定义view
    CZPieView *pieView =[[CZPieView alloc] init];
    pieView.frame = CGRectMake(10, 100, 200, 200);
    pieView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:pieView];
    
    
    //2.在自定义的view给个数据属性[NSArray]，往sections添加数据
    pieView.sections = @[@20,@30,@40,@10];
    
    // 设置颜色
    pieView.sectionColors = @[[UIColor redColor],[UIColor greenColor],[UIColor purpleColor],[UIColor yellowColor]];
    
    
    
    // 裁切圆角================
    //1.自定义一个CircleImageView控件，在drawRect中，获取上下文，往上下文中添加一个圆的路径
    // 2.自定义的控制中，添加一个imageName属性，
    
    // 3.把自定的view添加到控制器View
    CircleImageView *imageView = [[CircleImageView alloc] initWithFrame:CGRectMake(10, 230, 100, 100)];
    
    // 设置图片
    imageView.imageName = @"aimage";
    
    // 设置边框颜色和边框宽度
    imageView.borderColor = [UIColor blueColor];
    imageView.borderWidth = 3;
    
    imageView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    
    // 4.然后回到drawrect方法画图 调用CGContextClip的方法，裁剪路径之外多余的部分

    // 5.画圆的边框，使用CGContextAddEllipseInRect添加圆的路径，并使用CGContextStrokePath画空心圆;
    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    //更换图片
    self.imageView.imageName = @"aimage2";
    
}

@end
