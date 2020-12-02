//
//  AlBinaryTreeVC.m
//  OROCSummary
//
//  Created by orilme on 2020/11/12.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "AlBinaryTreeVC.h"
#import "BinaryTreeNode.h"

@interface AlBinaryTreeVC ()

@end

@implementation AlBinaryTreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor purpleColor];
    
}

// 计算树的高度
- (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
    if (!rootNode) {
        return 0;
    }
    if (!rootNode.leftNode && ! rootNode.rightNode) {
            return 1;
    }
    NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
    NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
    return MAX(leftDepth, rightDepth) + 1;
}


//2、二叉树
//1. /**
//2. * 先序遍历
//3. * 先访问根，再遍历左子树，再遍历右子树
//4. *
//5. * @param rootNode 根节点
//6. * @param handler 访问节点处理函数
//7. */
//8. + (void)preOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
//9. if (rootNode) {
//10. if (handler) {
//11. handler(rootNode);
//12. }
//13. [self preOrderTraverseTree:rootNode.leftNode handler:handler];
//14. [self preOrderTraverseTree:rootNode.rightNode handler:handler];
//15. }
//16. }
//17. /**
//18. * 中序遍历
//19. * 先遍历左子树，再访问根，再遍历右子树
//20. *
//21. * @param rootNode 根节点
//22. * @param handler 访问节点处理函数
//23. */
//24. + (void)inOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
//25. if (rootNode) {
//26. [self inOrderTraverseTree:rootNode.leftNode handler:handler];
//27. if (handler) {
//28. handler(rootNode);
//29. }
//30. [self inOrderTraverseTree:rootNode.rightNode handler:handler];
//31. }
//32. }
//33. /**
//34. * 后序遍历
//35. * 先遍历左子树，再遍历右子树，再访问根
//36. *
//37. * @param rootNode 根节点
//38. * @param handler 访问节点处理函数
//39. */
//40. + (void)postOrderTraverseTree:(BinaryTreeNode *)rootNode handler:(void(^)(BinaryTreeNode *treeNode))handler {
//41. if (rootNode) {
//42. [self postOrderTraverseTree:rootNode.leftNode handler:handler];
//43. [self postOrderTraverseTree:rootNode.rightNode handler:handler];
//44. if (handler) {
//45. handler(rootNode);
//46. }
//47. }
//48. }
//49. /**
//50. * 二叉树的深度
//51. *
//52. * @param rootNode 二叉树根节点
//53. *
//54. * @return 二叉树的深度
//55. */
//56. + (NSInteger)depthOfTree:(BinaryTreeNode *)rootNode {
//57. if (!rootNode) {
//58. return 0;
//59. }
//60. if (!rootNode.leftNode && !rootNode.rightNode) {
//61. return 1;
//62. }
//63. //左子树深度
//64. NSInteger leftDepth = [self depthOfTree:rootNode.leftNode];
//65. //右子树深度
//66. NSInteger rightDepth = [self depthOfTree:rootNode.rightNode];
//67. return MAX(leftDepth, rightDepth) + 1;
//68. }
//69. /**
//70. * 翻转二叉树（又叫：二叉树的镜像）
//71. *
//72. * @param rootNode 根节点
//73. *
//74. * @return 翻转后的树根节点（其实就是原二叉树的根节点）
//75. */
//76. + (BinaryTreeNode *)invertBinaryTree:(BinaryTreeNode *)rootNode {
//77. if (!rootNode) {
//78. return nil;
//79. }
//80. if (!rootNode.leftNode && !rootNode.rightNode) {
//81. return rootNode;
//82. }
//83. [self invertBinaryTree:rootNode.leftNode];
//84. [self invertBinaryTree:rootNode.rightNode];
//85. BinaryTreeNode *tempNode = rootNode.leftNode;
//86. rootNode.leftNode = rootNode.rightNode;
//87. rootNode.rightNode = tempNode;
//88. return rootNode;
//89. }
//90. /**
//91. * 是否平衡二叉树
//92. * 平衡二叉树：即AVL树，它是一棵空树或它的左右两个子树的高度差的绝对值不超过1，并且左右两个子树都是一棵平衡二叉树
//93. *
//94. * @param rootNode 根节点
//95. *
//96. * @return YES：平衡二叉树，NO：非平衡二叉树
//97. */
//98. + (BOOL)isAVLBinaryTree:(BinaryTreeNode *)rootNode {
//99. static NSInteger height;
//100. if (!rootNode) {
//101. height = 0;
//102. return YES;
//103. }
//104. if (!rootNode.leftNode && !rootNode.rightNode) {
//105. height = 1;
//106. return YES;
//107. }
//108. BOOL isAVLLeft = [self isAVLBinaryTree:rootNode.leftNode];
//109. NSInteger heightLeft = height;
//110. BOOL isAVLRight = [self isAVLBinaryTree:rootNode.rightNode];
//111. NSInteger heightRight = height;
//112. height = MAX(heightLeft, heightRight)+1;
//113. if (isAVLLeft && isAVLRight && ABS(heightLeft-heightRight) <= 1) {
//114. return YES;
//115. }
//116. return NO;
//117. }
//3、字符串数字逻辑类
//1. // 字符串反转
//2. - (NSString *)stringByReversed:(NSString *)str {
//3. NSMutableString *mutStr = [NSMutableString string];
//4. for (NSInteger i = str.length; i > 0; i--) {
//5. [mutStr appendString:[str substringWithRange:NSMakeRange(i-1, 1)]];
//6. }
//7. return mutStr;
//8. }
//9. // 比如输入3 得出 1+ 2 + 3 // 正数
//10. - (NSInteger)getAddResult:(NSInteger)x {
//11. if (x == 0) {
//12. return 0;
//13. }
//14. return x + [self getAddResult:x-1];
//15. }
//16. // 求一个数的n次方
//17. - (NSInteger)getResult:(NSInteger)x ciFang:(NSInteger)n {
//18. if (n==0) {
//19. return 1;
//20. }
//21. return x * [self getResult:x ciFang:n-1];
//22. }
//23. // 两个数字字符串相减（忽略初始负数的情况）
//24. - (NSString *)numStr:(NSString *)firstStr subStr:(NSString *)secondStr {
//25. NSMutableArray *firstArray = [self getArrayWithStr:firstStr];
//26. NSMutableArray *secondArray = [self getArrayWithStr:secondStr];
//27. NSMutableArray *resultArray;
//28. if (firstArray.count > secondArray.count) {
//29. resultArray = [NSMutableArray arrayWithArray:firstArray];
//30. } else{
//31. resultArray = [NSMutableArray arrayWithArray:secondArray];
//32. }
//33. // 1、直接减并存储
//34. for (NSInteger i = 1; i <= resultArray.count; i++) {
//35. NSInteger first = 0;
//36. if (firstArray.count >= i) {
//37. first = [firstArray[firstArray.count - i ] integerValue];
//38. }
//39. NSInteger second = 0;
//40. if (secondArray.count >= i) {
//41. second = [secondArray[secondArray.count - i] integerValue];
//42. }
//43. resultArray[resultArray.count - i] = @(first - second);
//44. }
//45. // 2、检查第一位是否为负 并提出来
//46. NSString *preStr = @"";
//47. NSMutableArray *removePreArray = [NSMutableArray array];
//48. if ([resultArray[0] integerValue] < 0) {
//49. preStr = @"-";
//50. for (NSInteger i = 0; i < resultArray.count; i++) {
//51. [removePreArray addObject:@(-[resultArray[i] integerValue])];
//52. }
//53. } else {
//54. removePreArray = resultArray;
//55. }
//56. // 3、干掉负数（借位处理）
//57. for (NSInteger i = 1; i < removePreArray.count; i++) {
//58. // 此处负数的情况不可能为为第一个（之前已经判断了）,所以至少为第二个
//59. if ([removePreArray[removePreArray.count - i] integerValue] < 0) {
//60. removePreArray[removePreArray.count - i] = @(10 + [removePreArray[removePreArray.count - i] integerValue]);
//61. removePreArray[removePreArray.count - i - 1] = @([removePreArray[removePreArray.count - i - 1] integerValue] - 1);
//62. } else {
//63. removePreArray[removePreArray.count - i] = removePreArray[removePreArray.count - i];
//64. }
//65. }
//66. // 4、检测前半部分为0的去掉
//67. NSInteger index = 0;
//68. for (int i = 0; i < removePreArray.count; i++) {
//69. if ([removePreArray[i] integerValue] != 0) {
//70. break;
//71. } else {
//72. index = i + 1;
//73. }
//74. }
//75. NSArray *zuiZhongArray = [removePreArray subarrayWithRange:NSMakeRange(index, removePreArray.count-index)];
//76. NSString *str = [zuiZhongArray componentsJoinedByString:@""];
//77. if (str.length <= 0) {
//78. str = @"0";
//79. }
//80. return [NSString stringWithFormat:@"%@%@",preStr,str];
//81. }
//82. - (NSMutableArray *)getArrayWithStr:(NSString *)str {
//83. NSMutableArray *arr = [NSMutableArray array];
//84. for (int i = 0; i < str.length; i++) {
//85. [arr addObject:[str substringWithRange:NSMakeRange(i, 1)]];
//86. }
//87. return arr;
//88. }

@end
