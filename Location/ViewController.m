//
//  ViewController.m
//  Location
//
//  Created by 徐继垚 on 15/7/6.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<CLLocationManagerDelegate,MKMapViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    


    _locationManager = [[CLLocationManager alloc]init];
    
    if (![CLLocationManager locationServicesEnabled]) {
        NSLog(@"无权限");
        return;
    }
    
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined) {
        [_locationManager requestWhenInUseAuthorization];
    }
    else if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        CFLocaleLanguageDirection distance = 10.0;
        _locationManager.distanceFilter = distance;
        [_locationManager startUpdatingLocation];
    }
    
    
    _geocoder = [[CLGeocoder alloc]init];
    
    [self getCoordinateByAddress:@"北京"];
    
    [self initGUI];

    // Do any additional setup after loading the view, typically from a nib.
}
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation * location = [locations firstObject];
    CLLocationCoordinate2D coordinate = location.coordinate;
   NSLog(@"经度：%f,纬度：%f,海拔：%f,航向：%f,行走速度：%f",coordinate.longitude,coordinate.latitude,location.altitude,location.course,location.speed);
    [self getAddressByLatitude:coordinate.latitude longitude:coordinate.longitude];
    
//    [_locationManager stopUpdatingLocation];
}

- (void)getCoordinateByAddress:(NSString *)address{
    [_geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark * placemark = [placemarks firstObject];
        
        CLLocation * location = placemark.location;
        CLRegion * region = placemark.region;
        NSDictionary * addressDic = placemark.addressDictionary;
//        NSString *name=placemark.name;//地名
//        NSString *thoroughfare=placemark.thoroughfare;//街道
//        NSString *subThoroughfare=placemark.subThoroughfare; //街道相关信息，例如门牌等
//        NSString *locality=placemark.locality; // 城市
//        NSString *subLocality=placemark.subLocality; // 城市相关信息，例如标志性建筑
//        NSString *administrativeArea=placemark.administrativeArea; // 州
//        NSString *subAdministrativeArea=placemark.subAdministrativeArea; //其他行政区域信息
//        NSString *postalCode=placemark.postalCode; //邮编
//        NSString *ISOcountryCode=placemark.ISOcountryCode; //国家编码
//        NSString *country=placemark.country; //国家
//        NSString *inlandWater=placemark.inlandWater; //水源、湖泊
//        NSString *ocean=placemark.ocean; // 海洋
//        NSArray *areasOfInterest=placemark.areasOfInterest; //关联的或利益相关的地标
         NSLog(@"位置:%@,区域:%@,详细信息:%@",location,region,addressDic);
    }];
}
- (void)getAddressByLatitude:(CLLocationDegrees)latitude longitude:(CLLocationDegrees)longitude{
    
    CLLocation * location = [[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    
    [_geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placemark=[placemarks firstObject];
        NSLog(@"详细信息:%@",placemark.addressDictionary);
    }];
    
    
    
    
}
- (void)initGUI{
    CGRect rect = [UIScreen mainScreen].bounds;
    _mapView = [[MKMapView alloc]initWithFrame:rect];
    [self.view addSubview:_mapView];
    _mapView.delegate = self;
    
//    _locationManager = [[CLLocationManager alloc]init];
//    if (![CLLocationManager locationServicesEnabled] || [CLLocationManager authorizationStatus] != kCLAuthorizationStatusAuthorizedWhenInUse) {
//        [_locationManager requestWhenInUseAuthorization];
//    }
    _mapView.userTrackingMode = MKUserTrackingModeFollow;
    _mapView.mapType = MKMapTypeStandard;
    //  [_mapView setRegion:MKCoordinateRegionMake(_mapView.centerCoordinate, MKCoordinateSpanMake(0.01f, 0.1f)) animated:YES];
    [self addAnnation];
    
}
- (void)addAnnation{
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(39.95, 116.35);
    XUAnnotation *annotation1=[[XUAnnotation alloc]init];
    annotation1.title=@"呵呵";
    annotation1.subtitle=@"21312313";
    annotation1.coordinate=location1;
    
    [_mapView addAnnotation:annotation1];
    
    CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
    XUAnnotation *annotation2=[[XUAnnotation alloc]init];
    annotation2.title=@"哈哈";
    annotation2.subtitle=@"1321312312";
    annotation2.coordinate=location2;
    [_mapView addAnnotation:annotation2];
    
}
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation{
    
    NSLog(@"%@",userLocation);
     CLLocationCoordinate2D location2=CLLocationCoordinate2DMake(39.87, 116.35);
           MKCoordinateSpan span=MKCoordinateSpanMake(2500, 2500);
        MKCoordinateRegion region=MKCoordinateRegionMake(userLocation.coordinate, span);
        [_mapView setRegion:region animated:true];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
