//
//  EditTableVC.m
//  OROCSummary
//
//  Created by orilme on 2021/3/12.
//  Copyright © 2021 orilme. All rights reserved.
//

#import "EditTableVC.h"

@interface EditTableVC () <UITableViewDelegate, UITableViewDataSource>
{
    //当前的编辑模式
    UITableViewCellEditingStyle _editingStyle;
}
 
@property (nonatomic, strong) UITableView *mainTableView;
@property (nonatomic, strong) NSMutableArray *mainArray;
@property (nonatomic, strong) NSMutableArray *deleteMultipleArray; //多选删除
 
@end
 
@implementation EditTableVC
 
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setUI];
}
 
- (void)viewDidUnload
{
    [super viewDidUnload];
    self.mainArray = nil;
}
 
- (void)dealloc
{
    self.mainTableView = nil;
    self.mainArray = nil;
}
 
#pragma mark -创建视图
 
- (void)setUI
{
    [self setEditButton];
    
    NSInteger count = arc4random() % 20 + 1;
    self.mainArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count; i++)
    {
        NSString *text = [NSString stringWithFormat:@"tableview edit-%i", i];
        [self.mainArray addObject:text];
    }
    
    self.mainTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.mainTableView];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.mainTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.deleteMultipleArray = [NSMutableArray arrayWithCapacity:count];
}
 
#pragma mark - UITableViewDelegate, UITableViewDataSource
 
//行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.mainArray.count;
}
 
//内容显示
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *const identifier = @"UITableViewCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.detailTextLabel.text = @"详细描述";
    }
    
    NSString *title = [self.mainArray objectAtIndex:indexPath.row];
    cell.textLabel.text = title;
    
    return cell;
}
 
//行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.0;
}
 
 
 
#pragma mark列表编辑
 
//提交编辑操作时会调用这个方法(删除，添加)
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //删除操作
        
        //删除数据
        [self.mainArray removeObjectAtIndex:indexPath.row];
        
        //更新UITableView UI界面
        NSArray *deleteArray = [NSArray arrayWithObjects:indexPath, nil];
        [tableView deleteRowsAtIndexPaths:deleteArray withRowAnimation:UITableViewRowAnimationNone];
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert)
    {
        //添加操作
        
        //添加数据
        NSInteger addIndex = indexPath.row + 1;
        [self.mainArray insertObject:@"新添加的数据" atIndex:addIndex];
        
        //更新UI界面
        NSIndexPath *addIndxPath = [NSIndexPath indexPathForRow:addIndex inSection:0];
        NSArray *addArray = [NSArray arrayWithObjects:addIndxPath, nil];
        [tableView insertRowsAtIndexPaths:addArray withRowAnimation:UITableViewRowAnimationNone];
    }
}
 
//删除时的标题
- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *title = [NSString stringWithFormat:@"删除%ld行", indexPath.row];
    return title;
}
 
//决定tableview的编辑模式
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return _editingStyle;
}
 
//只有实现这个方法，编辑模式中才允许移动Cell
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
{
    // NSLog(@"from(%i)-to(%i)", sourceIndexPath.row, destinationIndexPath.row);
    //更换数据的顺序
    [self.mainArray exchangeObjectAtIndex:sourceIndexPath.row withObjectAtIndex:destinationIndexPath.row];
}
 
 
 
#pragma mark多选删除操作
//选择行-多选选中
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_editingStyle == UITableViewCellEditingStyleDelete)
    {
        id addObject = [self.mainArray objectAtIndex:indexPath.row];
        if (![self.deleteMultipleArray containsObject:addObject])
        {
            [self.deleteMultipleArray addObject:addObject];
        }
    }
    else
    {
       // 非删除状态时才有效，否则多选图标无选中效果
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}
 
//取消选择行-多选选中取消
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_editingStyle == UITableViewCellEditingStyleDelete)
    {
        id deleteObject = [self.mainArray objectAtIndex:indexPath.row];
        if ([self.deleteMultipleArray containsObject:deleteObject])
        {
            [self.deleteMultipleArray removeObject:deleteObject];
        }
    }
}
 
 
 
#pragma mark -编辑模式设置
 
- (void)setEditButton
{
    UIBarButtonItem *moveButton = [[UIBarButtonItem alloc] initWithTitle:@"移动" style:UIBarButtonItemStylePlain target:self action:@selector(moveClick:)];
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addClick:)];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"单删" style:UIBarButtonItemStylePlain target:self action:@selector(deleteClick:)];
    UIBarButtonItem *deleteMultipleButton = [[UIBarButtonItem alloc] initWithTitle:@"多删" style:UIBarButtonItemStylePlain target:self action:@selector(deleteMultipleClick:)];
    UIBarButtonItem *showButton = [[UIBarButtonItem alloc] initWithTitle:@"显示" style:UIBarButtonItemStylePlain target:self action:@selector(showClick:)];
    
    NSArray *rightArray = [NSArray arrayWithObjects:moveButton, addButton, deleteButton, deleteMultipleButton, showButton, nil];
    self.navigationItem.rightBarButtonItems = rightArray;
}
 
//移动数据
- (void)moveClick:(UIBarButtonItem *)button
{
    _editingStyle = UITableViewCellEditingStyleNone;
    
    BOOL isEditing = self.mainTableView.isEditing;
    [self.mainTableView setEditing:!isEditing animated:YES];
}
 
//添加数据
- (void)addClick:(UIBarButtonItem *)button
{
    if (_editingStyle == UITableViewCellEditingStyleInsert)
    {
        _editingStyle = UITableViewCellEditingStyleNone;
    }
    else
    {
        _editingStyle = UITableViewCellEditingStyleInsert;
    }
    
    BOOL isEditing = self.mainTableView.isEditing;
    [self.mainTableView setEditing:!isEditing animated:YES];
}
 
//删除数据-单选删除
- (void)deleteClick:(UIBarButtonItem *)button
{
    if (_editingStyle == UITableViewCellEditingStyleDelete)
    {
        _editingStyle = UITableViewCellEditingStyleNone;
    }
    else
    {
        _editingStyle = UITableViewCellEditingStyleDelete;
    }
    
   // 若屏蔽则不会出现删除时的样式，可以通过手势滑动出现删除按钮
    BOOL isEditing = self.mainTableView.isEditing;
    [self.mainTableView setEditing:!isEditing animated:YES];
}
 
//删除数据-多选删除
- (void)deleteMultipleClick:(UIBarButtonItem *)button
{
    if (_editingStyle == UITableViewCellEditingStyleDelete)
    {
        _editingStyle = UITableViewCellEditingStyleNone;
        
        self.mainTableView.allowsSelection = NO; //设置tableView可不可以选中
        self.mainTableView.allowsMultipleSelection = NO; //允许tableview多选
        self.mainTableView.allowsSelectionDuringEditing = NO; //编辑模式下是否可以选中
        self.mainTableView.allowsMultipleSelectionDuringEditing = NO; //编辑模式下是否可以多选
    }
    else
    {
        _editingStyle = UITableViewCellEditingStyleDelete;
        
        self.mainTableView.allowsSelection = YES; //设置tableView可不可以选中
        self.mainTableView.allowsMultipleSelection = YES; //允许tableview多选
        self.mainTableView.allowsSelectionDuringEditing = YES; //编辑模式下是否可以选中
        self.mainTableView.allowsMultipleSelectionDuringEditing = YES; //编辑模式下是否可以多选
    }
 
    BOOL isEditing = self.mainTableView.isEditing;
    [self.mainTableView setEditing:!isEditing animated:YES];
    
    if (isEditing)
    {
        button.title = @"多删";
        button.tintColor = [UIColor blueColor];
        
        if (self.deleteMultipleArray.count > 0)
        {
            //删除已经勾选的数据
            [self.mainArray removeObjectsInArray:self.deleteMultipleArray];
            //重新加载
            [self.mainTableView reloadData];
            //清空已经勾选了的数据列表
            [self.deleteMultipleArray removeAllObjects];
        }
    }
    else
    {
        button.title = @"删除";
        button.tintColor = [UIColor redColor];
    }
}
 
//显示修改后信息
- (void)showClick:(UIBarButtonItem *)button
{
    NSLog(@"delete array %ld\n %@\n", self.deleteMultipleArray.count, self.deleteMultipleArray);
    NSLog(@"main array %ld\n %@\n", self.mainArray.count, self.mainArray);
}
 
@end
