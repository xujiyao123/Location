//
//  ViewController.h
//  Location
//
//  Created by 徐继垚 on 15/7/6.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "XUAnnotation.h"
@interface ViewController : UIViewController
{
    CLLocationManager *_locationManager;
    CLGeocoder *_geocoder;
    MKMapView *_mapView;
}

@end

