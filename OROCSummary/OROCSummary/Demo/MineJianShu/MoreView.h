//
//  MoreView.h
//  简书userCenter
//
//  Created by 周陆洲 on 16/4/19.
//  Copyright © 2016年 MuChen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MoreView : UIView<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,weak)UITableView *tableview;

@end
