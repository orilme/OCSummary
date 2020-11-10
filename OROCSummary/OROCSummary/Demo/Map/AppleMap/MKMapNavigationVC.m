//
//  MKMapNavigationVC.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "MKMapNavigationVC.h"
#import <MapKit/MapKit.h>

@interface MKMapNavigationVC ()
// 目的地的输入框
@property (weak, nonatomic) IBOutlet UITextField *destinationField;

/**
 *  点击按钮之后开始导航
 */
- (IBAction)navigate;
@end

@implementation MKMapNavigationVC

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)navigate {
    // 1.拿到用户输入的目的地
    NSString *destination = self.destinationField.text;
    if (destination.length == 0) {
        return;
    }
    
    // 2.地理编码
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:destination completionHandler:^(NSArray *placemarks, NSError *error) {
        if (placemarks.count == 0 || error) return ;
        
        // 2.1.取出地理编码出的地标
        CLPlacemark *clpm = [placemarks firstObject];
        
        // 2.2.利用CLPlacemark来创建MKPlacemark
        MKPlacemark *mkpm = [[MKPlacemark alloc] initWithPlacemark:clpm];
        
        // 2.3.利用MKPlacemark来创建目的地的MKMapItem
        MKMapItem *destinationItem = [[MKMapItem alloc] initWithPlacemark:mkpm];
        
        // 2.4.拿到起点的MKMapItem
        //MKMapItem *sourceItem = [MKMapItem mapItemForCurrentLocation];
        MKMapItem *sourceItem = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc]initWithCoordinate:CLLocationCoordinate2DMake(40.06, 116.39)]];
        
        // 2.5.开始导航
        [self startNavigateWithSourceItem:sourceItem destinationItem:destinationItem];
    }];
}

/**
 *  开始导航
 *
 *  @param sourceItem      起点的Item
 *  @param destinationItem 终点的Item
 */
- (void)startNavigateWithSourceItem:(MKMapItem *)sourceItem destinationItem:(MKMapItem *)destinationItem {
    // 1.将起点和终点item放入数组中
    NSArray *items = @[sourceItem, destinationItem];
    
    // 2.设置Options参数(字典)
    NSDictionary *options = @{
            MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
            MKLaunchOptionsMapTypeKey : @(MKMapTypeHybrid),
            MKLaunchOptionsShowsTrafficKey : @YES
                    };
    
    // 3.开始导航
    [MKMapItem openMapsWithItems:items launchOptions:options];
}


@end
