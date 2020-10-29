//
//  KeyboardToolbarTestVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/14.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "KeyboardToolbarTestVC.h"
#import "KeyboardToolbar.h"

@interface KeyboardToolbarTestVC ()<KeyboardToolbarDelegate>

@property (weak, nonatomic) IBOutlet UIView *registerContainer;

@property (nonatomic,strong)KeyboardToolbar *toolbar;

@property (nonatomic,strong)NSArray *fields;//将所有的输入框放入一个数组里

@end


@implementation KeyboardToolbarTestVC

/**
 *  懒加载toolbar
 *
 */
-(KeyboardToolbar *)toolbar{
    if (!_toolbar) {
        _toolbar = [KeyboardToolbar toolbar];
        _toolbar.kbDelegate = self;
    }
    return _toolbar;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    //定义一个可变数组
    NSMutableArray *fieldsM = [NSMutableArray array];
    
#warning sizeClasses导航注册框窗口的子控件器为空，去掉storyboard的sizeClasse
    //遍历UITextFiled添加键盘盘工具条
    NSLog(@"%@",self.registerContainer.subviews);
    for (UIView *subView in self.registerContainer.subviews) {
        if ([subView isKindOfClass:[UITextField class]]) {
            UITextField *tf = (UITextField *)subView;
            tf.inputAccessoryView = self.toolbar;
            //绑定tag
            tf.tag = fieldsM.count;
            
            [fieldsM addObject:tf];
        }
    }
    
    
    self.fields = fieldsM;
    
    
    //监听键盘事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willHide) name:UIKeyboardWillHideNotification object:nil];
}

/**
 *  键盘弹出
 *
 */
-(void)willShow:(NSNotification *)notifi{
    NSLog(@"%@",notifi.userInfo);
    
    //当键盘挡住UITextField，TextField所在父控件往上移
    
    //1.获取当前选中的UITextField在控制器view的最大Y值
    //当前获取焦点的textfield
    UITextField *currentTf = self.fields[[self indexOfFirstResponder]];
    
    //键盘一弹出，就判断上一个，下一个按钮可不可用
    if(currentTf.tag == 0){
        self.toolbar.previousItem.enabled = NO;
    }
    
    if(currentTf.tag == self.fields.count - 1){
        self.toolbar.nextItem.enabled = NO;
    }
    
    //currentTf.frame.origin.y +  currentTf.frame.size.height
    CGFloat maxY = CGRectGetMaxY(currentTf.frame) + self.registerContainer.frame.origin.y;
    
    
    //2.获取键盘的y值
    CGRect kbEndFrm = [notifi.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat kbY = kbEndFrm.origin.y;
    
    //3.进行比较
    //计算距离
    CGFloat delta = kbY - maxY;
    if(delta < 0){//需要往上移
        //添加个动画
        [UIView animateWithDuration:0.25 animations:^{
            self.view.transform = CGAffineTransformMakeTranslation(0, delta);
        }];

    }
}

/**
 *  隐藏键盘
 */
-(void)willHide{
    /*
     * 恢复原状
     */
    [UIView animateWithDuration:0.25 animations:^{
        self.view.transform = CGAffineTransformIdentity;
    }];
    
    
//    //还原工具条的item为可用
    self.toolbar.previousItem.enabled = YES;
    self.toolbar.nextItem.enabled = YES;

}

/**
 *  获取当前的响应者的索引
 */
-(NSInteger)indexOfFirstResponder{
    
    for (UITextField *tf in self.fields) {
        if (tf.isFirstResponder) {
            return tf.tag;
        }
    }
   
    //返回一1没有当前响应者
    return -1;
}

-(void)keyboardToolbar:(KeyboardToolbar *)toolbar btndidSelected:(UIBarButtonItem *)item{
    switch (item.tag) {
        case 0://上一个
            [self previous];
            break;
        case 1://下一个
            [self next];
            break;
        case 2://完成
            [self.view endEditing:YES];
            break;
        default:
            break;
    }
}

-(void)previous{
    //获取当前焦点
    NSInteger currentIndex = [self indexOfFirstResponder];
    NSLog(@"%ld",currentIndex);
    
    self.toolbar.nextItem.enabled = YES;
//    if(currentIndex == 1){
//        //禁止上一个按钮
//        self.toolbar.previousItem.enabled = NO;
//    }
//
    //获取上一个索引
    NSInteger previouesIndex = currentIndex - 1;
  
    //不当响应者
    [self.fields[currentIndex] resignFirstResponder];
    
    //索引要大于等0
    if (previouesIndex >= 0) {

        [self.fields[previouesIndex] becomeFirstResponder];
    }
    
   
  
    
}
-(void)next {
    //获取当前焦点
    NSInteger currentIndex = [self indexOfFirstResponder];
    NSLog(@"%ld",currentIndex);
    
    self.toolbar.previousItem.enabled = YES;
    
//    //判断当前索引等于什么的时候，下个按钮不可以？
//    if (currentIndex == self.fields.count - 2) {
//        self.toolbar.nextItem.enabled = NO;
//    }
    
    //不当响应者
    [self.fields[currentIndex] resignFirstResponder];
    
    //设置下一个焦点
    if (currentIndex != -1 && currentIndex != self.fields.count -1) {
        NSInteger nextIndex = currentIndex + 1;
        [self.fields[nextIndex] becomeFirstResponder];
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    //键盘退出
    [self.view endEditing:YES];
}

#pragma mark - <UITextFieldDelegate>
// 当点击键盘右下角的return key时,就会调用这个方法
- (BOOL)textFieldShouldReturn:(UITextField *)textField {

    [self next];
    return YES;
}

@end
