//
//  XUAnnotation.h
//  Location
//
//  Created by 徐继垚 on 15/7/6.
//  Copyright (c) 2015年 徐继垚. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
@interface XUAnnotation : NSObject<MKAnnotation>

@property (nonatomic) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;

@end
