//
//  PlaceholderTableVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/9.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "PlaceholderTableVC.h"
#import "UIScrollView+EmptyDataSet.h"

@interface PlaceholderTableVC ()<DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@end

@implementation PlaceholderTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.emptyDataSetSource = self;
    self.tableView.emptyDataSetDelegate = self;
}

#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = @"都看了萨迪克萨拉";
    return cell;
}


#pragma mark - DZNEmptyDataSetSource Methods
- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView {
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    NSString *text = @"No Favorites";
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:16.0];
    UIColor *textColor = [UIColor redColor];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

- (NSAttributedString *)descriptionForEmptyDataSet:(UIScrollView *)scrollView {

    NSMutableDictionary *attributes = [NSMutableDictionary new];
    
    NSMutableParagraphStyle *paragraph = [NSMutableParagraphStyle new];
    paragraph.lineBreakMode = NSLineBreakByWordWrapping;
    paragraph.alignment = NSTextAlignmentCenter;
    NSString *text = @"Get started by uploading a photo.";
    UIFont *font = [UIFont boldSystemFontOfSize:15.0];
    UIColor *textColor = [UIColor yellowColor];
    [attributes setObject:font forKey:NSFontAttributeName];
    [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    [attributes setObject:paragraph forKey:NSParagraphStyleAttributeName];

    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text attributes:attributes];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor systemPinkColor] range:[attributedString.string rangeOfString:@"add favorites"]];
    return attributedString;
}

- (UIImage *)imageForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIImage imageNamed:@"aimage2"];
}

- (CAAnimation *)imageAnimationForEmptyDataSet:(UIScrollView *)scrollView {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0.0, 0.0, 1.0) ];
    animation.duration = 0.25;
    animation.cumulative = YES;
    animation.repeatCount = MAXFLOAT;
    return animation;
}

- (NSAttributedString *)buttonTitleForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
    NSString *text = @"Start Browsing";
    UIFont *font = [UIFont boldSystemFontOfSize:16.0];
    UIColor *textColor = [UIColor greenColor];
    NSMutableDictionary *attributes = [NSMutableDictionary new];
    if (font) [attributes setObject:font forKey:NSFontAttributeName];
    if (textColor) [attributes setObject:textColor forKey:NSForegroundColorAttributeName];
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

//- (UIImage *)buttonBackgroundImageForEmptyDataSet:(UIScrollView *)scrollView forState:(UIControlState)state {
//    NSString *imageName = [[NSString stringWithFormat:@"button_background_%@", self.application.displayName] lowercaseString];
//
//    if (state == UIControlStateNormal) imageName = [imageName stringByAppendingString:@"_normal"];
//    if (state == UIControlStateHighlighted) imageName = [imageName stringByAppendingString:@"_highlight"];
//
//    UIEdgeInsets capInsets = UIEdgeInsetsMake(10.0, 10.0, 10.0, 10.0);
//    UIEdgeInsets rectInsets = UIEdgeInsetsZero;
//
//    switch (self.application.type) {
//        case ApplicationTypeFoursquare:
//            capInsets = UIEdgeInsetsMake(25.0, 25.0, 25.0, 25.0);
//            rectInsets = UIEdgeInsetsMake(0.0, 10, 0.0, 10);
//            break;
//        case ApplicationTypeiCloud:
//            rectInsets = UIEdgeInsetsMake(-19.0, -61.0, -19.0, -61.0);
//            break;
//        case ApplicationTypeKickstarter:
//            capInsets = UIEdgeInsetsMake(22.0, 22.0, 22.0, 22.0);
//            rectInsets = UIEdgeInsetsMake(0.0, -20, 0.0, -20);
//            break;
//        default:
//            break;
//    }
//
//    UIImage *image = [UIImage imageNamed:imageName inBundle:[NSBundle bundleForClass:[self class]] compatibleWithTraitCollection:nil];
//
//    return [[image resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch] imageWithAlignmentRectInsets:rectInsets];
//}

- (UIColor *)backgroundColorForEmptyDataSet:(UIScrollView *)scrollView {
    return [UIColor purpleColor];
}

- (CGFloat)verticalOffsetForEmptyDataSet:(UIScrollView *)scrollView {
    return 0.0;
}

- (CGFloat)spaceHeightForEmptyDataSet:(UIScrollView *)scrollView {
    return 10;
}


#pragma mark - DZNEmptyDataSetDelegate Methods

- (BOOL)emptyDataSetShouldDisplay:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowTouch:(UIScrollView *)scrollView {
    return YES;
}

- (BOOL)emptyDataSetShouldAllowScroll:(UIScrollView *)scrollView {
    return YES;
}

//- (BOOL)emptyDataSetShouldAnimateImageView:(UIScrollView *)scrollView {
//    return NO;
//}
//
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapView:(UIView *)view {
//    self.loading = YES;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
//}
//
//- (void)emptyDataSet:(UIScrollView *)scrollView didTapButton:(UIButton *)button {
//    self.loading = YES;
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        self.loading = NO;
//    });
//}

@end

