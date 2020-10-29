//
//  HLShareView.h
//  HLShareView
//
//  Created by 杜海龙 on 16/9/2.
//  Copyright © 2016年 DHL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HLShareViewDelegate <NSObject>

- (void)shareView:(UIView *)self didSelectButWithBtnTag:(NSInteger)btnTag;

@end


@interface HLShareView : UIView

@property (nonatomic,weak)id<HLShareViewDelegate> delegate;

- (void)shareShow;

@end
