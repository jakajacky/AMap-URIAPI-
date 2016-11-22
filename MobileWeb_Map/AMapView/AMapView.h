//
//  AMapView.h
//  MobileWeb_Map
//
//  Created by xqzh on 16/11/22.
//  Copyright © 2016年 xqzh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface AMapView : UIView

- (void)setStartCoordinate:(CLLocationCoordinate2D)start StartPlace:(NSString *)startName EndCoordinate:(CLLocationCoordinate2D)end endPlace:(NSString *)endName;

- (void)updateMapView;

@end
