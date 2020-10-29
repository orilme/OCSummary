//
//  HttpCacheVC.m
//  ORIOSSummary
//
//  Created by orilme on 2020/3/11.
//  Copyright © 2020 orilme. All rights reserved.
//

#import "HttpCacheVC.h"
#import "QFHttpConnection.h"

#define kUrl @"https://www.baidu.com"

@interface HttpCacheVC ()

@end

@implementation HttpCacheVC {
    int _currentPage;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _currentPage = 1;
}

- (IBAction)onBtnPreClicked:(id)sender {
    if (_currentPage>1) {
        _currentPage--;
        
        NSLog(@"下载第%d页数据",_currentPage);
        
        NSString *strUrl = [NSString stringWithFormat:kUrl,_currentPage];
        QFHttpConnection *http = [[QFHttpConnection alloc]init];
        [http getDataWithUrl:strUrl onSuccess:^(NSData *data) {
            
        } onFailure:^(NSError *error) {
            
        }];
    }else {//清缓存
        [QFHttpConnection clearCache];
    }
}

- (IBAction)onBtnNextClicked:(id)sender {
    _currentPage++;
       NSLog(@"下载第%d页数据",_currentPage);
       
       NSString *strUrl = [NSString stringWithFormat:kUrl,_currentPage];
       QFHttpConnection *http = [[QFHttpConnection alloc]init];
       [http getDataWithUrl:strUrl onSuccess:^(NSData *data) {
           
       } onFailure:^(NSError *error) {
           
       }];
}

@end
