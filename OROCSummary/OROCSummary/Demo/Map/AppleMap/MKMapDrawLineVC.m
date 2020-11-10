//
//  MKMapDrawLineVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "MKMapDrawLineVC.h"
#import <MapKit/MapKit.h>

#define kLatitudeDelta 0.4003
#define kLongitudeDelta 0.3017

@interface MKMapDrawLineVC ()<MKMapViewDelegate>

// 地图的View
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

// 目的地的输入框
@property (weak, nonatomic) IBOutlet UITextField *destinationField;

/**
 *  点击之后开始画线
 */
- (IBAction)drawLine;

@end

@implementation MKMapDrawLineVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView.delegate = self;
    
    // 设置用户的位置为地图的中心点
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(40.06, 116.39) animated:YES];
    // 设置mapView的显示区域
    MKCoordinateSpan span = MKCoordinateSpanMake(kLatitudeDelta, kLongitudeDelta);
    MKCoordinateRegion region = MKCoordinateRegionMake(CLLocationCoordinate2DMake(40.06, 116.39), span);
    [self.mapView setRegion:region animated:YES];
}

- (IBAction)drawLine {
    // 0.退出键盘
    [self.view endEditing:YES];
    
    // 1.获取用户输入的目的地
    NSString *destination = self.destinationField.text;
    if (destination.length == 0) {
        return;
    }
    
    // 2.地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) return;
        
        // 2.1.获取CLPlaceMark对象
        CLPlacemark *clpm = [placemarks firstObject];
        
        // 2.2.利用CLPlacemark来创建MKPlacemark
        MKPlacemark *mkpm = [[MKPlacemark alloc] initWithPlacemark:clpm];
        
        // 2.3.创建目的地的MKMapItem对象
        MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:mkpm];
        
        // 2.4.起点的MKMapItem
        MKMapItem *sourceItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(40.06, 116.39)]];
        //MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
        
        // 2.5.开始画线
        [self drawLineWithSourceItem:sourceItem destinationItem:destinationItem];
    }];
}

/**
 *  开始画线
 *
 *  @param sourceItem      起点的Item
 *  @param destinationItem 终点的Item
 */
- (void)drawLineWithSourceItem:(MKMapItem *)sourceItem destinationItem:(MKMapItem *)destinationItem
{
    // 1.创建MKDirectionsRequest对象
    MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
    
    // 1.1.设置起点的Item
    request.source = sourceItem;
    
    // 1.2.设置终点的Item
    request.destination = destinationItem;
    
    // 2.创建MKDirections对象
    MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
    
    // 3.请求/计算(当请求到路线信息的时候会来到该方法)
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        // 3.1.当有错误,或者路线数量为0直接返回
        if (error || response.routes.count == 0) return;
        
        NSLog(@"%ld", response.routes.count);
        
        // 3.2.遍历所有的路线
        for (MKRoute *route in response.routes) {
            
            // 3.3.取出路线(遵守MKOverlay)
            MKPolyline *polyLine = route.polyline;
            
            // 3.4.将路线添加到地图上
            [self.mapView addOverlay:polyLine];
        }
    }];
}

/**
 *  当一个遮盖添加到地图上时会执行该方法
 *
 *  @param overlay 遵守MKOverlay的对象
 *
 *  @return 画线的渲染
 */
- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(MKPolyline *)overlay
{
    MKPolylineRenderer *poly = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    
    poly.strokeColor = [UIColor yellowColor];
    poly.lineWidth = 5.0;
    
    return poly;
}

@end
