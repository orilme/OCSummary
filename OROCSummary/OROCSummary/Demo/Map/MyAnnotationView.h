//
//  MyAnnotationView.h
//  ORIOSSummary
//
//  Created by orilme on 2019/11/16.
//  Copyright © 2019 orilme. All rights reserved.
//

#import <MapKit/MapKit.h>

@interface MyAnnotationView : MKAnnotationView

+ (instancetype)myAnnoViewWithMapView:(MKMapView *)mapView;

@end
