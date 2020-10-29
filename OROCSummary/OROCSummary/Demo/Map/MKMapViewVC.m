//
//  MKMapViewVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "MKMapViewVC.h"
#import <MapKit/MapKit.h>
#import "MyAnnotation.h"

#define kLatitudeDelta 0.4003
#define kLongitudeDelta 0.3017

@interface MKMapViewVC ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation MKMapViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置代理
    self.mapView.delegate = self;
    
    // 跟踪用户的位置
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    
    // 设置地图类型
    self.mapView.mapType = MKMapTypeStandard;
    
    
    // 3.添加两个大头针
    MyAnnotation *anno1 = [[MyAnnotation alloc] init];
    anno1.coordinate = CLLocationCoordinate2DMake(40.06, 116.39);
    anno1.title = @"北京市";
    anno1.subtitle = @"中国北京市昌平区";
    
    MyAnnotation *anno2 = [[MyAnnotation alloc] init];
    anno2.coordinate = CLLocationCoordinate2DMake(30.23, 120.23);
    anno2.title = @"杭州市";
    anno2.subtitle = @"浙江省杭州市萧山区";
    
    [self.mapView addAnnotation:anno1];
    [self.mapView addAnnotation:anno2];
}

/**
 *  定位到用户的位置会执行该方法
 *  @param userLocation 大头针模型
 */
- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    // 取出用户的位置
    CLLocationCoordinate2D coordinate = userLocation.location.coordinate;
    NSLog(@"苹果地图---定位---纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
    
    // 设置用户的位置为地图的中心点
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.06, 116.39) animated:YES];
    //[mapView setCenterCoordinate:userLocation.location.coordinate animated:YES];
    
    
    // 设置mapView显示的位置
    // [mapView setCenterCoordinate:coordinate animated:YES];
    // 设置mapView的显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(coordinate, span);
    [mapView setRegion:region animated:YES];
    
    // 改变大头针显示的内容(通过改变大头针模型的属性)
    // userLocation.title = @"广州市";
    // userLocation.subtitle = @"广东省广州市天河区";
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    CLLocation *location = userLocation.location;
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) return;

        CLPlacemark *pm = [placemarks firstObject];

        if (pm.locality) {
            userLocation.title = pm.locality;
        } else {
            userLocation.title = pm.administrativeArea;
        }
        userLocation.subtitle = pm.name;
    }];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MKCoordinateRegion region = mapView.region;
    CLLocationCoordinate2D center = region.center;
    MKCoordinateSpan span = region.span;
    NSLog(@"苹果地图---纬度:%f 经度:%f", center.latitude, center.longitude);
    NSLog(@"苹果地图---纬度跨度:%f 经度跨度:%f", span.latitudeDelta, span.longitudeDelta);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    // 1.获取用户点击的点
    CGPoint point = [[touches anyObject] locationInView:self.view];
    
    // 2.将该点转化成经纬度(地图上的坐标)
    CLLocationCoordinate2D coordinate = [self.mapView convertPoint:point toCoordinateFromView:self.view];
    
    // 3.添加大头针
    MyAnnotation *anno = [[MyAnnotation alloc] init];
    anno.coordinate = coordinate;
    anno.title = @"传智播客";
    anno.subtitle = @"传智播客是中国IT教育的摇篮";
    [self.mapView addAnnotation:anno];
}

- (IBAction)backToUserLocation {
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(self.mapView.userLocation.location.coordinate, span);
    // [self.mapView setCenterCoordinate:self.mapView.userLocation.location.coordinate animated:YES];
    [self.mapView setRegion:region animated:YES];
}

@end
