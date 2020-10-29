//
//  EditTableViewVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/7.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "EditTableViewVC.h"
#import "EditTableViewCell.h"
@interface EditTableViewVC ()<UITableViewDataSource,UITableViewDelegate>
{
    EditTableViewCell * cell;
    UITableViewRowAction *deleteRowAction;
    UITableViewRowAction *moreRowAction;
    UITableViewRowAction *sanRowAction;
    UITableViewRowAction *OK;
    NSArray * array;
}
@end

@implementation EditTableViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title=@"滑动编辑";
    _RootViewTab.delegate=self;
    _RootViewTab.dataSource=self;
    array=@[@"滑动编辑一按钮",@"滑动编辑二按钮",@"滑动编辑三按钮",@"滑动编辑四按钮"];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
}
- (BOOL)tableView: (UITableView *)tableView shouldIndentWhileEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellIdentifer = @"cell";
    
    cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"EditTableViewCell" owner:nil options:nil] objectAtIndex:0];
        
    }
    cell.rootlabel.text=array[indexPath.row];
    return cell;
}



- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(indexPath.row==0){
        // 添加一个删除按钮
        deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了删除");
            
        }];
        

    }
    else if (indexPath.row==1){
        // 添加一个删除按钮
        deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了删除");
            
        }];
        
        // 添加一个修改按钮
        moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了修改");
        }];
        moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        

    }
    else if (indexPath.row==2){
        // 添加一个删除按钮
        deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了删除");
            
        }];
        
        // 添加一个修改按钮
        moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了修改");
        }];
        moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        // 添加一个发送按钮
        
        sanRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"发送" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了发送");
        }];
        sanRowAction.backgroundColor=[UIColor orangeColor];

    }
    else{
        // 添加一个删除按钮
        deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了删除");
            
        }];
        
        // 添加一个修改按钮
        moreRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"修改" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了修改");
        }];
        moreRowAction.backgroundEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
        
        // 添加一个发送按钮
        
       sanRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"发送" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了发送");
        }];
        sanRowAction.backgroundColor=[UIColor orangeColor];
        // 添加一个发送按钮
        
        OK = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"OK键" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            NSLog(@"点击了OK");
        }];
        OK.backgroundColor=[UIColor purpleColor];
        

    }
    
    // 将设置好的按钮放到数组中返回
    if (indexPath.row==0) {
        return @[deleteRowAction];

    }else if (indexPath.row==1){
        return @[deleteRowAction,moreRowAction];

    }else if(indexPath.row==2){
        return @[deleteRowAction,moreRowAction,sanRowAction];

    }else if(indexPath.row==3){
        return @[deleteRowAction,moreRowAction,sanRowAction,OK];
        
    }
    return nil;
}








@end
