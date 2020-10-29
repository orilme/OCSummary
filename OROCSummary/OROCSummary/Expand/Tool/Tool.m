
#import "Tool.h"

@implementation Tool

////手机号校验
//+ (BOOL)checkTel:(NSString *)str
//{
//    
//    if ([str length] == 0) {
//        //手机号为空
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"手机号不能为空" message:@"请键入手机号" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
//        [alertView show];
//        return NO;
//    }
//    NSString *regex = @"^((13[0-9])|(14[0-9])|(17[0-9])|(15[0-9])|(18[0-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:str];
//    if (!isMatch) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//        [alert show];
//        return NO;
//    }
//    return YES;
//}
//
////传真,固话校验
//+ (BOOL)checkFaxNumber:(NSString *)number{
//    
//    
//    //验证输入的固话中不带 "-"符号
//    
//    NSString * strNum = @"^(0[0-9]{2,3})?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
//    
//    //验证输入的固话中带 "-"符号
//    
//    NSString * strNum1 = @"^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$|(^(13[0-9]|15[0|3|6|7|8|9]|18[8|9])\\d{8}$)";
//    
//    NSPredicate *checktest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum];
//    NSPredicate *checktest1 = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", strNum1];
//   
//
//    return [checktest evaluateWithObject:number]||[checktest1 evaluateWithObject:number];
//    
//    
//}
//
////车牌号校验
//+ (BOOL)checkCar:(NSString *)str
//
//{
//    
//    if ([str length] == 0) {
//        //车牌号为空
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"车牌号不能为空" message:@"请键入车牌号号" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
//        [alertView show];
//        
//        return NO;
//        
//    }
//    
//    NSString *regex = @"^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$";
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    BOOL isMatch = [pred evaluateWithObject:str];
//    
//    if (!isMatch) {
//        
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的车牌号" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//        
//        [alert show];
//        return NO;
//        
//    }
//    
//    return YES;
//    
//}
//
////身份证号校验
//+ (BOOL)checkPerson:(NSString *)str{
//    if ([str length] == 0) {
//        //身份证号为空
//        UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"身份证号不能为空" message:@"请键入身份证号" delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
//        [alertView show];
//        
//        return NO;
//        
//    }
//    
//    NSString *regex = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    BOOL isMatch = [pred evaluateWithObject:str];
//    
//    if (!isMatch) {
//        
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的身份证号" delegate:nil cancelButtonTitle:@"好" otherButtonTitles:nil, nil];
//        
//        [alert show];
//        return NO;
//        
//    }
//    
//    return YES;
//
//}
//
////ip地址校验
//+ (BOOL)checkIpAddress:(NSString *)str{
//
//    NSString *regex = @"^(http|https)://([\\w-]+\\.)+[\\w-]+(/[\\w-./?%&=]*)?$";
//    
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    
//    BOOL isMatch = [pred evaluateWithObject:str];
//    
//    if (!isMatch) {
//        return NO;
//    }else{
//        return YES;
//    }
//    return YES;
//}
//
////设置导航条颜色 默认BgColor为全局使用颜色  titleColor为白色
//+ (void)setNavBarBgColor:(UINavigationController *)nav{
//    //设置title颜色
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//    nav.navigationBar.titleTextAttributes = dict;
//    
//    if ( IOS7_OR_LATER )
//    {
//        nav.navigationBar.tintColor = [UIColor whiteColor];
//        
//        if ([nav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//            
//            [nav.navigationBar setBackgroundImage:[Tool imageWithColor:[Tool colorWithHexString:@"0086e1"] size:CGSizeMake(Screen_Width, 64)] forBarMetrics:UIBarMetricsDefault];
//        }
//    }
//    else
//    {
//        [nav.navigationBar insertSubview:[[UIImageView alloc] initWithImage:[Tool imageWithColor:[Tool colorWithHexString:@"0086e1"] size:CGSizeMake(Screen_Width, 64)]] atIndex:1];
//    }
//    
//}
//
//+ (void)setNavBarBgColor1:(UINavigationController *)nav{
//    //设置title颜色
//    NSDictionary *dict = [NSDictionary dictionaryWithObject:[UIColor whiteColor] forKey:NSForegroundColorAttributeName];
//    nav.navigationBar.titleTextAttributes = dict;
//    
//    if ( IOS7_OR_LATER )
//    {
//        nav.navigationBar.tintColor = [UIColor whiteColor];
//        
//        if ([nav.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]) {
//            
//            [nav.navigationBar setBackgroundImage:[Tool imageWithColor:[Tool colorWithHexString:@"23599d"] size:CGSizeMake(Screen_Width, 64)] forBarMetrics:UIBarMetricsDefault];
//        }
//    }
//    else
//    {
//        [nav.navigationBar insertSubview:[[UIImageView alloc] initWithImage:[Tool imageWithColor:[Tool colorWithHexString:@"23599d"] size:CGSizeMake(Screen_Width, 64)]] atIndex:1];
//    }
//    
//}
//
////设置nav的titleview
//+ (void)setNavTitleView:(UIViewController*)ctrl{
//    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo3_03.png"]];
//    ctrl.navigationItem.titleView = imageView;
//}
//
////延迟执行的block
//+ (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay
//{
//    block = [block copy];
//    [self performSelector:@selector(fireBlockAfterDelay:) withObject:block afterDelay:delay];
//}
//
//+ (void)fireBlockAfterDelay:(void (^)(void))block
//{
//    block();
//}
//
////调出键盘时屏幕上移
//+ (void)moveSelfView:(UIViewController *)ctrl withHeightAwayfromCenter:(CGFloat) height {
//    NSNumber * duration = @0.25;
//    NSNumber * curve = @7;
//    [UIView animateWithDuration:duration.doubleValue animations:^{
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationCurve:[curve intValue]];
//        [ctrl.view setCenter:CGPointMake(Screen_Width / 2, Screen_Height / 2 - height)];
//    }];
//}
//
////将self.view设置回初始位置
//+ (void)setSeleViewBackDefault:(UIViewController *)ctrl
//{
//    NSNumber * duration = @0.25;
//    NSNumber * curve = @7;
//    [UIView animateWithDuration:duration.doubleValue animations:^{
//        [UIView setAnimationBeginsFromCurrentState:YES];
//        [UIView setAnimationCurve:[curve intValue]];
//        [ctrl.view setCenter:CGPointMake(Screen_Width / 2, Screen_Height / 2 + 32)];
//    }];
//}
//
////添加导航栏左侧返回按钮
//+ (void)addBackButton:(UIViewController*)ctrl withClickAction:(SEL)action{
//    if(isIOS10){
//        ctrl.tabBarController.tabBar.hidden = YES;
//    }
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [backBtn setFrame:CGRectMake(0, 10, 20, 20)];
//    [backBtn setContentMode:UIViewContentModeScaleAspectFill];
//    //    [backBtn setContentEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)];
//    [backBtn setImage:[UIImage imageNamed:@"所有导航栏上返回图标"] forState:UIControlStateNormal];
//    [backBtn addTarget:ctrl action:action forControlEvents:UIControlEventTouchUpInside];
//    ctrl.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
//    ctrl.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
//}
//
////添加导航栏右侧按钮
//+ (void)addNavRightButton:(UIViewController*)ctrl withPicName:(NSString *)picName withClickAction:(SEL)action
//{
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setFrame:CGRectMake(0, 0, 30, 30)];
//    [addBtn setContentMode:UIViewContentModeScaleAspectFill];
//    [addBtn setImage:[UIImage imageNamed:picName] forState:UIControlStateNormal];
//    [addBtn addTarget:ctrl action:action forControlEvents:UIControlEventTouchUpInside];
//    ctrl.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:addBtn];
//}
//
////添加导航栏右侧图片按钮
//+ (void)addoriginalNavRightButton:(UIViewController*)ctrl withPicName:(NSString *)picName withClickAction:(SEL)action
//{
//    UIView *itemview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setFrame:CGRectMake(12, 0, 30, 30)];
//    [addBtn setImage:[UIImage imageNamed:picName] forState:UIControlStateNormal];
//    [itemview addSubview:addBtn];
//    itemview.userInteractionEnabled = YES;
//    addBtn.userInteractionEnabled = NO;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:ctrl action:action];
//    [itemview addGestureRecognizer:tap];
//    ctrl.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemview];
//}
//
////添加导航栏右侧标题按钮
//+ (void)addoriginalNavRightButton:(UIViewController*)ctrl WithTitleName:(NSString *)TitleName withClickAction:(SEL)action
//{
//    UIView *itemview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
//    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [addBtn setFrame:CGRectMake(25, 0, 60, 30)];
//    [addBtn setTitle:TitleName forState:UIControlStateNormal];
//    addBtn.titleLabel.font = [UIFont systemFontOfSize:14];
////    addBtn.layer.borderWidth = 1;
////    addBtn.layer.borderColor = [[UIColor groupTableViewBackgroundColor]CGColor];
//    [itemview addSubview:addBtn];
//    itemview.userInteractionEnabled = YES;
//    addBtn.userInteractionEnabled = NO;
//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:ctrl action:action];
//    [itemview addGestureRecognizer:tap];
//    ctrl.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:itemview];
//}
//
////添加无数据默认背景图
//+ (void)addNoDataBackgroundImageView:(UIImageView *)imgView forViewController:(UIViewController*)ctrl {
//    imgView.frame = [UIScreen mainScreen].bounds;
//    imgView.image = [UIImage imageNamed:@"add_no_msg1"];
//    [ctrl.view addSubview:imgView];
//}
//+ (void)addNoDataBackgroundforViewController:(UIViewController*)ctrl {
//    UIImageView *imgView = [[UIImageView alloc]init];
//    imgView.frame = [UIScreen mainScreen].bounds;
//    imgView.image = [UIImage imageNamed:@"add_no_msg1"];
//    [ctrl.view addSubview:imgView];
//}
//
////从nav以下开始算页面
//+ (void)setEdgesForExtendedLayout:(UIViewController*)ctrl{
//    if ([ctrl respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
//        [ctrl setEdgesForExtendedLayout:UIRectEdgeNone];
//    }
//}
//
////设置button点击效果
//+ (void)setBtnSelectedStyle:(UIButton*)sender Image:(NSString*)image{
//    if (image) {
//        [sender setBackgroundImage:[UIImage imageNamed:image] forState:UIControlStateSelected];
//    }
//    [sender setSelected:YES];
//    
//    [Tool performBlock:^{
//        [sender setSelected:NO];
//    } afterDelay:0.05];
//    
//}
//
////十六进制的颜色转换为UIColor
//+ (UIColor *) colorWithHexString: (NSString *)color
//{
//    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
//    
//    // String should be 6 or 8 characters
//    if ([cString length] < 6) {
//        return [UIColor clearColor];
//    }
//    
//    // strip 0X if it appears
//    if ([cString hasPrefix:@"0X"])
//        cString = [cString substringFromIndex:2];
//    if ([cString hasPrefix:@"#"])
//        cString = [cString substringFromIndex:1];
//    if ([cString length] != 6)
//        return [UIColor clearColor];
//    
//    // Separate into r, g, b substrings
//    NSRange range;
//    range.location = 0;
//    range.length = 2;
//    
//    //r
//    NSString *rString = [cString substringWithRange:range];
//    
//    //g
//    range.location = 2;
//    NSString *gString = [cString substringWithRange:range];
//    
//    //b
//    range.location = 4;
//    NSString *bString = [cString substringWithRange:range];
//    
//    // Scan values
//    unsigned int r, g, b;
//    [[NSScanner scannerWithString:rString] scanHexInt:&r];
//    [[NSScanner scannerWithString:gString] scanHexInt:&g];
//    [[NSScanner scannerWithString:bString] scanHexInt:&b];
//    
//    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
//}
//
////图片缩放到指定大小尺寸
//+ (UIImage *)imageFromView:(UIView *)viewBac
//{
//    UIGraphicsBeginImageContextWithOptions(viewBac.bounds.size, YES, viewBac.layer.contentsScale);
//    [viewBac.layer renderInContext:UIGraphicsGetCurrentContext()];
//    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//    return image;
//}
//
////根据文字获取label大小
//+ (CGSize)getLabelSizeWithText:(NSString*)str AndSize:(CGSize)siz AndFont:(UIFont*)font {
//    CGSize size;
//    
//    if ([[[UIDevice currentDevice] systemVersion] intValue]>=7.0) {
//        NSDictionary *attribute = @{NSFontAttributeName: font};
//        size = [str boundingRectWithSize:siz options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
//    }
//    else{
//        size = [str sizeWithFont:font constrainedToSize:siz lineBreakMode:NSLineBreakByCharWrapping];
//    }
//    
//    return size;
//}
//
////时间戳转时间
//+ (NSString*)timestampToString:(NSString*)stamp Format:(NSString*)format{
//    
//    if (stamp.length==13) {
//        stamp = [stamp substringToIndex:10];
//    }
//    if (![stamp isKindOfClass:[NSNumber class]]) {
//        if (stamp.length==0) {
//            return @"";
//        }
//    }
//    
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    
//    NSArray *weekdayAry = [NSArray arrayWithObjects:@"星期日", @"星期一", @"星期二", @"星期三", @"星期四", @"星期五", @"星期六", nil];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
//    [dateFormatter setShortWeekdaySymbols:weekdayAry];
//    
//    if (format) {
//        [dateFormatter setDateFormat:format];
//    }
//    
//    NSDate *time = [NSDate dateWithTimeIntervalSince1970:[stamp intValue]];
//    
//    NSString *dateStr = [dateFormatter stringFromDate:time];
//    return dateStr;
//}
//
////获取当前系统的时间戳
//+(long)getTimeSp{
//    long time;
//    NSDate *fromdate=[NSDate date];
//    time=(long)[fromdate timeIntervalSince1970];
//    return time;
//}
//
////将时间戳转换成NSDate
//+(NSDate *)changeSpToTime:(NSString*)spString{
//    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[spString intValue]];
//    return confromTimesp;
//}
////比较日期大小
//+(int)compareOneDay:(NSDate *)oneDay withAnotherDay:(NSDate *)anotherDay{
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString *oneDayStr = [dateFormatter stringFromDate:oneDay];
//    NSString *anotherDayStr = [dateFormatter stringFromDate:anotherDay];
//    NSDate *dateA = [dateFormatter dateFromString:oneDayStr];
//    NSDate *dateB = [dateFormatter dateFromString:anotherDayStr];
//    NSComparisonResult result = [dateA compare:dateB];
//    NSLog(@"date1 : %@, date2 : %@", oneDay, anotherDay);
//    if (result == NSOrderedDescending) {
//        //NSLog(@"Date1  is in the future");
//        return 1;
//    }
//    else if (result == NSOrderedAscending){
//        //NSLog(@"Date1 is in the past");
//        return -1;
//    }
//    //NSLog(@"Both dates are the same");
//    return 0;
//}
//
////时间转日期
//+ (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
//    
//    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
//    
//    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    
//    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
//    
//    [calendar setTimeZone: timeZone];
//    
//    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
//    
//    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
//    
//    return [weekdays objectAtIndex:theComponents.weekday];
//    
//}
//
////将NSDate按yyyy-MM-dd HH:mm:ss格式时间输出
//+(NSString*)nsdateToString:(NSDate *)date{
//    NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
//    [dateFormat setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSString* string=[dateFormat stringFromDate:date];
//    return string;
//}
////判断字符串是否为空
//+ (BOOL) isBlankString:(NSString *)string {
//    if (string == nil || string == NULL || [string isEqual:[NSNull null]] || [string isEqualToString:@"(null)"]) {
//        return YES;
//    }
//    if ([string isEqualToString:@""]) {
//        return YES;
//    }
//    if ([string isKindOfClass:[NSNull class]]) {
//        return YES;
//    }
//    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
//        return YES;
//    }
//    return NO;
//}
//
////判断字典或数组是否为空
//+ (BOOL) isBlankDic:(NSDictionary *)dic {
//    if (dic == nil || dic == NULL || [dic isEqual:[NSNull null]]) {
//        return YES;
//    }
//    if ([dic isKindOfClass:[NSNull class]]) {
//        return YES;
//    }
//    if (!([dic allKeys].count > 0)) {
//        return YES;
//    }
//    return NO;
//}
//
////显示提示信息
//+ (void)ShowpromptWithMsg:(NSString *)Msg{
//    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:Msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
//    [errorAlert show];
//    [self performSelector:@selector(removeAlertView:) withObject:errorAlert afterDelay:1.0];
//}
//+ (void)ShowpromptWithMsg1:(NSString *)Msg{
//    UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:Msg delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
//    [errorAlert show];
//    [self performSelector:@selector(removeAlertView:) withObject:errorAlert afterDelay:0.5];
//}
//
////数组拼接为字符串
//+ (NSString *)StringConversionWithArr:(NSArray *)array{
//   NSString *quetionStr = [[NSString alloc]init];
//    for (int i = 0; i < array.count; i++) {
//        NSString *tmpStr = array[i];
//        if (tmpStr.length != 0) {
//            quetionStr = [quetionStr stringByAppendingString:[NSString stringWithFormat:@",%@",array[i]]];
//        }
//    }
//    quetionStr = [quetionStr substringFromIndex:1];
//    return quetionStr;
//}
//
////图片颜色生成图片
//+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
//{
//    CGRect rect = CGRectMake(0, 0, size.width, size.height);
//    UIGraphicsBeginImageContext(rect.size);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(context,color.CGColor);
//    CGContextFillRect(context, rect);
//    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    return img;
//}
//
////月份的英文显示
//+ (NSString *)changeTime:(int)num{
//    switch (num) {
//        case 1:
//            return @"Jan.";
//            break;
//        case 2:
//            return @"Feb.";
//            break;
//        case 3:
//            return @"Mar.";
//            break;
//        case 4:
//            return @"Apr.";
//            break;
//        case 5:
//            return @"May.";
//            break;
//        case 6:
//            return @"Jun.";
//            break;
//        case 7:
//            return @"Jul.";
//            break;
//        case 8:
//            return @"Aug.";
//            break;
//        case 9:
//            return @"Sep.";
//            break;
//        case 10:
//            return @"Oct.";
//            break;
//        case 11:
//            return @"Nov.";
//            break;
//        case 12:
//            return @"Dec.";
//            break;
//            
//        default:
//            break;
//    }
//    return nil;
//}
//
////添加视图点击事件
//+ (void)addTapgestureforView:(UIView *)TapView withPicName:(UIViewController *)ctrl withClickAction:(SEL)action
//{
//    TapView.userInteractionEnabled = YES;
//    UITapGestureRecognizer *tapges = [[UITapGestureRecognizer alloc]initWithTarget:ctrl action:@selector(action)];
//    [TapView addGestureRecognizer:tapges];
//}
//
////移除alertView
//+(void)removeAlertView:(UIAlertView*)alertView
//{
//    [alertView dismissWithClickedButtonIndex:0 animated:YES];
//}
//
//+ (CGRect)MDCGRectMakeOrginX:(CGFloat)OrginX OrginY:(CGFloat)OrginY SizeWidth:(CGFloat)SizeWidth SizeHeight:(CGFloat)SizeHeight
//{
//    CGRect rect;
//    rect.origin.x = (OrginX / 360) * Screen_Width; rect.origin.y = (OrginY / 640) * Screen_Height;
//    rect.size.width = (SizeWidth / 360) * Screen_Width; rect.size.height = (SizeHeight / 640) * Screen_Height;
//    return rect;
//}
//
//+ (CGFloat)MDOrginX:(CGFloat)OrginX{
//    return (OrginX / 360) * Screen_Width;
//}
//+ (CGFloat)MDOrginY:(CGFloat)OrginY{
//    return (OrginY / 640) * Screen_Height;
//}
//+ (CGFloat)MDSizeWidth:(CGFloat)SizeWidth{
//    return (SizeWidth / 360) * Screen_Width;
//}
//+ (CGFloat)MDSizeHeight:(CGFloat)SizeHeight{
//    return (SizeHeight / 640) * Screen_Height;
//}
//
////截屏
//+(UIImage *)screenImageWithSize:(CGSize )imgSize{
//    UIGraphicsBeginImageContext(imgSize);
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    
//    AppDelegate * app = (AppDelegate *)[UIApplication sharedApplication].delegate; //获取app的appdelegate，便于取到当前的window用来截屏
//    [app.window.layer renderInContext:context];
//    
//    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    
//    UIImage * newImg = [self imageFromImage:img inRect:CGRectMake(0, 64, Screen_Width, Screen_Height)];
//    
//    UIImageWriteToSavedPhotosAlbum(newImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
//    
//    return img;
//}
////合成图片
//+ (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
//    CGImageRef sourceImageRef = [image CGImage];
//    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
//    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
//    return newImage;
//}
//
////保存截图是否成功提示
//+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
//    
//    if (error == nil) {
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"已存入手机相册" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//        
//    }else{
//        
//        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"保存失败" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//        [alert show];
//    }
//    
//}
//
//
//// 根据图片url获取图片尺寸(不用下载下来，速度更快)
//+(CGSize)getImageSizeWithURL:(id)imageURL
//{
//    NSURL* URL = nil;
//    if([imageURL isKindOfClass:[NSURL class]]){
//        URL = imageURL;
//    }
//    if([imageURL isKindOfClass:[NSString class]]){
//        URL = [NSURL URLWithString:imageURL];
//    }
//    if(URL == nil){
//        return CGSizeZero;                  // url不正确返回CGSizeZero
//    }
//    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
//    NSString* pathExtendsion = [URL.pathExtension lowercaseString];
//    
//    CGSize size = CGSizeZero;
//    if([pathExtendsion isEqualToString:@"png"]){
//        size =  [self getPNGImageSizeWithRequest:request];
//    }
//    else if([pathExtendsion isEqual:@"gif"])
//    {
//        size =  [self getGIFImageSizeWithRequest:request];
//    }
//    else{
//        size = [self getJPGImageSizeWithRequest:request];
//    }
//    if(CGSizeEqualToSize(CGSizeZero, size)) //如果获取文件头信息失败,发送异步请求请求原图
//    {
//        NSData* data = [NSData dataWithContentsOfURL:URL];
//        UIImage* image = [UIImage imageWithData:data];
//        if(image)
//        {
//            size = image.size;
//        }
//    }
//    return size;
//}
////  获取PNG图片的大小
//+(CGSize)getPNGImageSizeWithRequest:(NSMutableURLRequest*)request
//{
//    [request setValue:@"bytes=16-23" forHTTPHeaderField:@"Range"];
//    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if(data.length == 8)
//    {
//        int w1 = 0, w2 = 0, w3 = 0, w4 = 0;
//        [data getBytes:&w1 range:NSMakeRange(0, 1)];
//        [data getBytes:&w2 range:NSMakeRange(1, 1)];
//        [data getBytes:&w3 range:NSMakeRange(2, 1)];
//        [data getBytes:&w4 range:NSMakeRange(3, 1)];
//        int w = (w1 << 24) + (w2 << 16) + (w3 << 8) + w4;
//        int h1 = 0, h2 = 0, h3 = 0, h4 = 0;
//        [data getBytes:&h1 range:NSMakeRange(4, 1)];
//        [data getBytes:&h2 range:NSMakeRange(5, 1)];
//        [data getBytes:&h3 range:NSMakeRange(6, 1)];
//        [data getBytes:&h4 range:NSMakeRange(7, 1)];
//        int h = (h1 << 24) + (h2 << 16) + (h3 << 8) + h4;
//        return CGSizeMake(w, h);
//    }
//    return CGSizeZero;
//}
////  获取gif图片的大小
//+(CGSize)getGIFImageSizeWithRequest:(NSMutableURLRequest*)request
//{
//    [request setValue:@"bytes=6-9" forHTTPHeaderField:@"Range"];
//    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    if(data.length == 4)
//    {
//        short w1 = 0, w2 = 0;
//        [data getBytes:&w1 range:NSMakeRange(0, 1)];
//        [data getBytes:&w2 range:NSMakeRange(1, 1)];
//        short w = w1 + (w2 << 8);
//        short h1 = 0, h2 = 0;
//        [data getBytes:&h1 range:NSMakeRange(2, 1)];
//        [data getBytes:&h2 range:NSMakeRange(3, 1)];
//        short h = h1 + (h2 << 8);
//        return CGSizeMake(w, h);
//    }
//    return CGSizeZero;
//}
////  获取jpg图片的大小
//+(CGSize)getJPGImageSizeWithRequest:(NSMutableURLRequest*)request
//{
//    [request setValue:@"bytes=0-209" forHTTPHeaderField:@"Range"];
//    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//    
//    if ([data length] <= 0x58) {
//        return CGSizeZero;
//    }
//    
//    if ([data length] < 210) {// 肯定只有一个DQT字段
//        short w1 = 0, w2 = 0;
//        [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
//        [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
//        short w = (w1 << 8) + w2;
//        short h1 = 0, h2 = 0;
//        [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
//        [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
//        short h = (h1 << 8) + h2;
//        return CGSizeMake(w, h);
//    } else {
//        short word = 0x0;
//        [data getBytes:&word range:NSMakeRange(0x15, 0x1)];
//        if (word == 0xdb) {
//            [data getBytes:&word range:NSMakeRange(0x5a, 0x1)];
//            if (word == 0xdb) {// 两个DQT字段
//                short w1 = 0, w2 = 0;
//                [data getBytes:&w1 range:NSMakeRange(0xa5, 0x1)];
//                [data getBytes:&w2 range:NSMakeRange(0xa6, 0x1)];
//                short w = (w1 << 8) + w2;
//                short h1 = 0, h2 = 0;
//                [data getBytes:&h1 range:NSMakeRange(0xa3, 0x1)];
//                [data getBytes:&h2 range:NSMakeRange(0xa4, 0x1)];
//                short h = (h1 << 8) + h2;
//                return CGSizeMake(w, h);
//            } else {// 一个DQT字段
//                short w1 = 0, w2 = 0;
//                [data getBytes:&w1 range:NSMakeRange(0x60, 0x1)];
//                [data getBytes:&w2 range:NSMakeRange(0x61, 0x1)];
//                short w = (w1 << 8) + w2;
//                short h1 = 0, h2 = 0;
//                [data getBytes:&h1 range:NSMakeRange(0x5e, 0x1)];
//                [data getBytes:&h2 range:NSMakeRange(0x5f, 0x1)];
//                short h = (h1 << 8) + h2;
//                return CGSizeMake(w, h);
//            }
//        } else {
//            return CGSizeZero;
//        }
//    }
//}
//
////判断是否是手机号码
//- (BOOL)isMobile {
//    
//    if (self.length != 11) return NO;
//    
//    /**
//     * 手机号码
//     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     * 联通：130,131,132,152,155,156,185,186
//     * 电信：133,1349,153,180,189,181(增加)
//     */
//    NSString * MOBIL = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
//    /**
//     10         * 中国移动：China Mobile
//     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
//     12         */
//    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[2378])\\d)\\d{7}$";
//    /**
//     15         * 中国联通：China Unicom
//     16         * 130,131,132,152,155,156,185,186
//     17         */
//    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
//    /**
//     20         * 中国电信：China Telecom
//     21         * 133,1349,153,180,189,181(增加)
//     22         */
//    NSString * CT = @"^1((33|53|8[019])[0-9]|349)\\d{7}$";
//    
//    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
//    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
//    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
//    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
//    
//    if (([regextestmobile evaluateWithObject:self]
//         || [regextestcm evaluateWithObject:self]
//         || [regextestct evaluateWithObject:self]
//         || [regextestcu evaluateWithObject:self])) {
//        return YES;
//    }
//    
//    return NO;
//}
//
////创建lable
//+(UILabel *)lableWithTitle:(NSString *)title frame:(CGRect)frame font:(UIFont *)font textColor:(UIColor *)color{
//    UILabel *label = [[UILabel alloc] initWithFrame:frame];
//    label.text = title;
//    label.font = font;
//    label.textColor = color;
//    return label;
//}
////创建button
//+(UIButton *)btnWithTitle:(NSString *)title frame:(CGRect)frame imageName:(NSString *)imageName tag:(NSInteger)tag{
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setFrame:frame];
//    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [btn setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
//    btn.tag = tag;
//    return btn;
//}

@end
