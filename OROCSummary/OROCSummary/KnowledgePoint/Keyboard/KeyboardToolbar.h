//
//  KeyboardToolbar.h
//  ORIOSSummary
//
//  Created by orilme on 2019/11/14.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <UIKit/UIKit.h>
@class KeyboardToolbar;
@protocol KeyboardToolbarDelegate <NSObject>

@optional

/**
 *  item.tag  0 表示上一个按钮 1:下一个按钮 2:done完成按钮
 */
-(void)keyboardToolbar:(KeyboardToolbar *)toolbar btndidSelected:(UIBarButtonItem *)item;

@end


@interface KeyboardToolbar : UIToolbar

+(instancetype)toolbar;

@property (weak, nonatomic) id<KeyboardToolbarDelegate> kbDelegate;//键盘的代理


/**
 *  上一个按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *previousItem;

/**
 *  下一个按钮
 */
@property (weak, nonatomic) IBOutlet UIBarButtonItem *nextItem;

@end

