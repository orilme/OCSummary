//
//  CoreLocationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "CoreLocationVC.h"
#import <CoreLocation/CoreLocation.h>

@interface CoreLocationVC ()<CLLocationManagerDelegate>
@property(nonatomic,strong)CLLocationManager *mgr;
@end

@implementation CoreLocationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 开始定位
    [self.mgr startUpdatingLocation];
    
    // 如果是iOS8,需要请求授权方式(进行判断,否则在iOS7会崩溃,需要先在info.plist中配置)
    // 1.通过判断系统判断来确定是否需要请求requestAlwaysAuthorization授权
//    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
//        [self.mgr requestAlwaysAuthorization];
//    }
    // 2.通过判断是否有该方法来判断是否需要请求requestAlwaysAuthorization授权
    if ([self.mgr respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        [self.mgr requestAlwaysAuthorization];
    }
    
    // 计算两个经纬度之间的距离
    [self countDistance];
}

// 计算两个经纬度之间的距离
- (void)countDistance {
    CLLocation *location1 = [[CLLocation alloc] initWithLatitude:23.23 longitude:113.33];
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:40.06 longitude:116.39];
    
    CLLocationDistance distance = [location1 distanceFromLocation:location2];
    NSLog(@"苹果地图---计算两个经纬度之间的距离---%f", distance);
}

/**
 *  定位到用户的位置会调用该方法(并且该方法调用非常频繁)
 *  @param locations 存放着定位的所有位置
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    // 1.获取用户位置的对象
    CLLocation *location = [locations lastObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
    NSLog(@"苹果地图---当前位置---纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    // 2.停止定位
    [manager stopUpdatingLocation];
}

#pragma mark - 懒加载
- (CLLocationManager *)mgr {
    if (_mgr == nil) {
        // 1.创建定位管理者
        _mgr = [[CLLocationManager alloc] init];
        
        // 2.设置代理
        _mgr.delegate = self;
        
        // 3.位置间隔之后重新定位
        _mgr.distanceFilter = 10;
        
        // 4.定位的精确度
        _mgr.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    }
    return _mgr;
}

@end
