//
//  UIDynamicController.m
//  ORIOSSummary
//
//  Created by orilme on 2020/1/12.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "UIDynamicController.h"
#import "DemoViewController.h"

@interface UIDynamicController ()

@property (strong, nonatomic) UIDynamicAnimator *animatator;

@property (weak, nonatomic) IBOutlet UIImageView *bird;
@property (weak, nonatomic) IBOutlet UIImageView *ice1;
@property (weak, nonatomic) IBOutlet UIImageView *ice2;
@property (weak, nonatomic) IBOutlet UIImageView *ice3;
@property (weak, nonatomic) IBOutlet UIImageView *ice4;

@property (nonatomic, strong) UIImageView *redView;

@end

@implementation UIDynamicController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *btn1 = [[UIButton alloc]initWithFrame:CGRectMake(10, 100, 100, 30)];
    btn1.tag = 0;
    btn1.backgroundColor = [UIColor redColor];
    [btn1 setTitle:@"吸附行为" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    UIButton *btn2 = [[UIButton alloc]initWithFrame:CGRectMake(120, 100, 130, 30)];
    btn2.tag = 1;
    btn2.backgroundColor = [UIColor redColor];
    [btn2 setTitle:@"推动行为" forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [[UIButton alloc]initWithFrame:CGRectMake(260, 100, 130, 30)];
    btn3.tag = 2;
    btn3.backgroundColor = [UIColor redColor];
    [btn3 setTitle:@"刚附性行为" forState:UIControlStateNormal];
    [btn3 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn3];
    
    UIButton *btn4 = [[UIButton alloc]initWithFrame:CGRectMake(10, 140, 100, 30)];
    btn4.tag = 3;
    btn4.backgroundColor = [UIColor redColor];
    [btn4 setTitle:@"弹性附加行为" forState:UIControlStateNormal];
    [btn4 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn4];
    
    UIButton *btn5 = [[UIButton alloc]initWithFrame:CGRectMake(120, 140, 130, 30)];
    btn5.tag = 4;
    btn5.backgroundColor = [UIColor redColor];
    [btn5 setTitle:@"碰撞检测" forState:UIControlStateNormal];
    [btn5 addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn5];
    
    self.redView = [[UIImageView alloc] initWithFrame:CGRectMake(100, 140, 100,100)];
    UIImage *image1 = [UIImage imageNamed:@"aimage"];
    self.redView.image = image1;
    [self.view addSubview:self.redView];
}

- (void)click:(UIButton *) button {
    NSArray *functions = @[@"吸附行为", @"推动行为", @"刚性附加行为", @"弹性附加行为", @"碰撞检测"];
    DemoViewController *controller = [[DemoViewController alloc] init];
    controller.title = functions[button.tag];
    controller.function = button.tag;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 创建重力仿真行为
    NSArray *items = @[self.bird, self.ice1, self.ice2, self.ice3 ,self.ice4];
    UIGravityBehavior *gravity1 = [[UIGravityBehavior alloc] initWithItems:items];

    // 创建碰撞仿真行为
    UICollisionBehavior *collision = [[UICollisionBehavior alloc] initWithItems:items];
    // 将参照视图的bounds作为边界
    collision.translatesReferenceBoundsIntoBoundary = YES;

    // 创建推动仿真行为(创建的时候需要传入一个枚举)
    // UIPushBehaviorModeContinuous 持续的
    // UIPushBehaviorModeInstantaneous 非持续的
    UIPushBehavior *push = [[UIPushBehavior alloc] initWithItems:@[self.bird] mode:UIPushBehaviorModeInstantaneous];
    // 设置push作用的向量(方向和大小)
    push.pushDirection = CGVectorMake(1.5, 0);

    // 将仿真行为添加到仿真器中
    [self.animatator addBehavior:gravity1];
    [self.animatator addBehavior:collision];
    [self.animatator addBehavior:push];
    
    // test2===============
    //获取触摸点
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:touch.view];
    //创建捕捉行为
    UISnapBehavior *snapBehavior = [[UISnapBehavior alloc] initWithItem:self.redView snapToPoint:point];
    //设置反弹系数（反弹幅度越大，值越大，反弹幅度越小）
    snapBehavior.damping = 0.5;
    //将行为添加到仿真器
    [self.animatator addBehavior:snapBehavior];
}

- (UIDynamicAnimator *)animatator {
    if (!_animatator) {
        _animatator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    }
    return _animatator;
}

@end
