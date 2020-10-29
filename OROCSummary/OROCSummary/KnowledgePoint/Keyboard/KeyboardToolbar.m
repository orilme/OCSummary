//
//  KeyboardToolbar.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/14.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "KeyboardToolbar.h"

@implementation KeyboardToolbar

+(instancetype)toolbar{
    return [[[NSBundle mainBundle] loadNibNamed:@"KeyboardToolbar" owner:nil options:nil] lastObject];
}

- (IBAction)itemBtnClick:(id)sender {
    //判断代理有没有实现方法
    if ([self.kbDelegate respondsToSelector:@selector(keyboardToolbar:btndidSelected:)]) {
        [self.kbDelegate keyboardToolbar:self btndidSelected:sender];
    }
}

@end
