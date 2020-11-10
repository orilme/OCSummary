//
//  MyAnnotationView.m
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import "MyAnnotationView.h"
#import "MyAnnotation.h"

@implementation MyAnnotationView

+ (instancetype)myAnnoViewWithMapView:(MKMapView *)mapView {
    // 2.添加自己的大头针的View
    static NSString *ID = @"myAnnoView";
    MyAnnotationView *myAnnoView = (MyAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:ID];
    if (myAnnoView == nil) {
        myAnnoView = [[MyAnnotationView alloc] initWithAnnotation:nil reuseIdentifier:ID];
        
        // 1.设置标题和子标题可以呼出
        myAnnoView.canShowCallout = YES;
        
        // 2.在左右两侧放一个View
        myAnnoView.leftCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeContactAdd];
        myAnnoView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    }
    
    return myAnnoView;
}


- (void)setAnnotation:(MyAnnotation *)annotation {
    self.image = [UIImage imageNamed:annotation.icon];
    [super setAnnotation:annotation];
}

@end
