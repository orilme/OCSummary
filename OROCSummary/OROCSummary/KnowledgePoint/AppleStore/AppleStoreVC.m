//
//  AppleStoreVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/12/21.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "AppleStoreVC.h"
#import <StoreKit/StoreKit.h>

/* 内购
 * 1.请求想要销售的商品(自己的服务器)
 * 2.向苹果服务器请求可销售商品(produceId—>NSSet) 1>SKProductRequest 2>设置代理 3>start
 * 3.请求到可销售商品(response->.products->SKProduct- >price->localTitle)
 * 4.⽤用户点击某⼀一个商品的时候开始购买 1>SKPayment—>SKProduct 2>添加观察者 3>SKPaymentQueue addPayment:
 * 5.观察者的协议的⽅方法 -payment updateTransaction:(NSArray *)transactions SKPaymentTransaction state
     1>正在购买
     2>购买成功(结束交易 queue finish)
     3>购买失败
     4>恢复购买(结束交易)
     5>未决定状态
 * 6.恢复购买 [queue restoreAllTransactions]
 * 7.添加观察者和移除观察者 -viewWillAppear:添加观察者 -viewWillDisAppear:移除观察者
 */

@interface AppleStoreVC ()<SKProductsRequestDelegate, SKPaymentTransactionObserver>

@property (nonatomic, strong) NSArray *products;

@end

@implementation AppleStoreVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor redColor];
    btn.bounds = CGRectMake(0, 0, 80, 31);
    [btn setTitle:@"恢复购买" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(restoreBuy) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    // 1.从服务器请求想要销售的产品
    [self loadProducts];
}

// 点击之后,恢复购买
- (void)restoreBuy {
    // 恢复所有的购买
    [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
}

/**
 *  从服务器请求想要销售的产品
 */
- (void)loadProducts {
    // 1.获取所有想要销售的商品
    NSString *path = [[NSBundle mainBundle] pathForResource:@"products.plist" ofType:nil];
    NSArray *products = [NSArray arrayWithContentsOfFile:path];
    
    // 2.像苹果请求所有可销售商品
    // 2.1.取出所有想要销售商品的productId，放入到NSSet当中
    NSArray *productIds = [products valueForKeyPath:@"productId"];
    NSSet *productSet = [NSSet setWithArray:productIds];
    // 2.2.创建SKProductsRequest请求对象
    SKProductsRequest *request = [[SKProductsRequest alloc] initWithProductIdentifiers:productSet];
    // 2.3.设置代理
    request.delegate = self;
    // 2.4.开始请求
    [request start];
}

/**
 *  请求可销售的商品,当请求回来的时候,调用该方法
 *  @param response 请求的回应(里面存放所有的可销售商品)
 */
- (void)productsRequest:(SKProductsRequest *)request didReceiveResponse:(SKProductsResponse *)response {
    // 1.获取所有可销售的商品
    NSArray *products = response.products;
    NSLog(@"%lu", (unsigned long)products.count);
    // 2.展示所有可销售商品给用户
    self.products = products;
    dispatch_async(dispatch_get_main_queue(), ^{
        // 3.刷新数据
        [self.tableView reloadData];
    });
}

#pragma mark - SKPaymentQueue的观察者的代理方法
/**
 *  当交易队列中的交易状态发生改变的时候,会调用该方法
 *  @param transactions 交易队列中的所有交易
 */
- (void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    /*
     SKPaymentTransactionStatePurchasing, 正在购买
     SKPaymentTransactionStatePurchased, 已经购买,购买成功时,需要终止交易,否则会一直停留在队列中
     SKPaymentTransactionStateFailed, 购买失败,由于网络等原因购买失败,无需终止交易
     SKPaymentTransactionStateRestored, 恢复购买,恢复购买成功后,需要终止交易,否则交易会一直停留在队列中
     SKPaymentTransactionStateDeferred 用户未决定的,可能由于账号问题,未购买,也未失败
     */
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                NSLog(@"正在购买");
                break;
            case SKPaymentTransactionStatePurchased:
                NSLog(@"已经购买");
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateFailed:
                NSLog(@"购买失败");
                break;
            case SKPaymentTransactionStateRestored:
                NSLog(@"恢复购买");
                [queue finishTransaction:transaction];
                break;
            case SKPaymentTransactionStateDeferred:
                NSLog(@"用户未决定的");
                break;
            default:
                break;
        }
    }
}

#pragma mark - 让控制器成为或者移除观察者
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[SKPaymentQueue defaultQueue] removeTransactionObserver:self];
}

#pragma mark - 实现TableView的数据源和代理方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.products.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    }
    SKProduct *product = self.products[indexPath.row];
    cell.textLabel.text = product.localizedTitle;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", product.price];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // 1.取出SKProduct对象
    SKProduct *product = self.products[indexPath.row];
    // 2.创建SKPayment对象
    SKPayment *payment = [SKPayment paymentWithProduct:product];
    // 3.添加一个观察者
    //[[SKPaymentQueue defaultQueue] addTransactionObserver:self];
    // 3.将SKPayment对象添加到SKPaymentQueue对象当中
    [[SKPaymentQueue defaultQueue] addPayment:payment];
}


@end
