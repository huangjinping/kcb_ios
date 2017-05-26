//
//  MapViewController.m
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/24.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "MapViewController.h"
#import <MapKit/MapKit.h>

@implementation MapViewController
{
    MAMapView *_mapView;
    CLLocationCoordinate2D _startCoordinate2D;
    CLLocationCoordinate2D _destCoorinate2D;
    NSMutableArray *_availableMaps;
}
- (void)viewDidLoad{
    [super viewDidLoad];
    
    [self configUI];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self setCustomNavigationTitle:@"查找门店"];
}

- (void)configUI{
    NSArray *arr = [self.jwd componentsSeparatedByString:@","];
    _destCoorinate2D = CLLocationCoordinate2DMake([arr.lastObject doubleValue], [arr[0] doubleValue]);
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, APP_VIEW_Y, APP_WIDTH, APP_HEIGHT-APP_VIEW_Y+APP_NAV_HEIGHT)];
    [_mapView setZoomLevel:17.f animated:YES];
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, .5f * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        _mapView.centerCoordinate = _destCoorinate2D;
        MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
        pointAnnotation.coordinate = _destCoorinate2D;
        pointAnnotation.title = self.merName;
        pointAnnotation.subtitle = self.address;
        NSLog(@"%f,%f",pointAnnotation.coordinate.longitude,pointAnnotation.coordinate.latitude);
        [_mapView addAnnotation:pointAnnotation];
        [_mapView selectAnnotation:pointAnnotation animated:YES];
    });
    _availableMaps = [NSMutableArray array];
    _mapView.mapType = MAMapTypeStandard;
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
}

- (void)mapView:(MAMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    
}

- (void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation{
    _startCoordinate2D = userLocation.coordinate;
    
//    NSLog(@"%f,%f",userLocation.coordinate.longitude,userLocation.coordinate.latitude);
//    mapView.centerCoordinate = userLocation.coordinate;
//    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
//    pointAnnotation.coordinate = userLocation.location.coordinate;
//    pointAnnotation.title = self.merName;
//    pointAnnotation.subtitle = self.address;
//    
//    mapView.centerCoordinate = userLocation.coordinate;
//    [_mapView addAnnotation:pointAnnotation];
//    [mapView selectAnnotation:pointAnnotation animated:YES];
//
    if (userLocation.coordinate.longitude == 0 && userLocation.coordinate.latitude == 0) {
        mapView.showsUserLocation = YES;
    }else{
        mapView.showsUserLocation = NO;
    }
}


- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView *annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        if (![self.merName isLegal] || ![self.address isLegal]) {
            btn.frame = CGRectMake(0, 0, 170*x_6_plus, 150*y_6_plus);
            if (self.merName.length <= 4) {
                btn.width = 115*x_6_plus;
            }else{
                btn.width = 170*x_6_plus;
            }
        }else{
            btn.frame = CGRectMake(0, 0, 170*x_6_plus, 150*y_6_plus);
            if (self.merName.length <= 4) {
                btn.width = 115*x_6_plus;
            }else{
                btn.width = 170*x_6_plus;
            }

        }
        [btn addActionBlock:^(id weakSender) {
            [self configMap];
        } forControlEvents:UIControlEventTouchUpInside];
        [btn setTitle:@"导航"];
        [btn setTitleColor:kWhiteColor];
//       [ btn addBorderWithWidth:1 color:kClearColor roundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight cornerRadius:5];
        btn.backgroundColor = COLOR_NAV;
        NSLog(@"annotationView frame = %@",NSStringFromCGRect(annotationView.frame));
        annotationView.rightCalloutAccessoryView = btn;
        annotationView.image = [UIImage imageNamed:@"定位符"];
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        NSLog(@"%f,%f",[(MAPointAnnotation *)annotation coordinate].longitude,[(MAPointAnnotation *)annotation coordinate].latitude);

        return annotationView;
    }
    return nil;
}

- (void)configMap{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://map/"]]){
        NSString *urlString = [NSString stringWithFormat:@"baidumap://map/direction?origin=latlng:%f,%f|name:我的位置&destination=latlng:%f,%f|name:%@&mode=transit",
                               _startCoordinate2D.latitude, _startCoordinate2D.longitude, _destCoorinate2D.latitude, _destCoorinate2D.longitude, self.merName];
        
        NSDictionary *dic = @{@"name": @"百度地图",
                              @"url": urlString};
        [_availableMaps addObject:dic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"iosamap://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"iosamap://navi?sourceApplication=%@&backScheme=applicationScheme&poiname=fangheng&poiid=BGVIS&lat=%f&lon=%f&dev=0&style=3",
                               @"云华时代", _destCoorinate2D.latitude, _destCoorinate2D.longitude];
        
        NSDictionary *dic = @{@"name": @"高德地图",
                              @"url": urlString};
        [_availableMaps addObject:dic];
    }
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"comgooglemaps://"]]) {
        NSString *urlString = [NSString stringWithFormat:@"comgooglemaps://?saddr=&daddr=%f,%f¢er=%f,%f&directionsmode=transit", _destCoorinate2D.latitude, _destCoorinate2D.longitude, _startCoordinate2D.latitude, _startCoordinate2D.longitude];
        
        NSDictionary *dic = @{@"name": @"Google Maps",
                              @"url": urlString};
        [_availableMaps addObject:dic];
    }
    
//    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:@"选择导航方式" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"苹果导航", @"高德导航", nil];
//    sheet.delegate = self;
    
    UIActionSheet *action = [[UIActionSheet alloc] init];
    
    [action addButtonWithTitle:@"使用系统自带地图导航"];
    for (NSDictionary *dic in _availableMaps) {
        [action addButtonWithTitle:[NSString stringWithFormat:@"使用%@导航", dic[@"name"]]];
    }
    [action addButtonWithTitle:@"取消"];
    action.cancelButtonIndex = _availableMaps.count + 1;
    action.delegate = self;
    [action showInView:self.view];
}

#pragma mark- UIACTIONSHEET DELEGATE
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        
        if (!iOS6) { // ios6以下，调用google map
            
            NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d",_startCoordinate2D.latitude,_startCoordinate2D.longitude,_destCoorinate2D.latitude,_destCoorinate2D.longitude];
            //        @"http://maps.apple.com/?saddr=%f,%f&daddr=%f,%f",startCoor.latitude,startCoor.longitude,endCoor.latitude,endCoor.longitude
            urlString =  [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *aURL = [NSURL URLWithString:urlString];
            [[UIApplication sharedApplication] openURL:aURL];
        } else{// 直接调用ios自己带的apple map
            
            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
            MKPlacemark *placemark = [[MKPlacemark alloc] initWithCoordinate:_destCoorinate2D addressDictionary:nil];
            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:placemark];
            toLocation.name = self.merName;
            
            [MKMapItem openMapsWithItems:@[currentLocation, toLocation]
                           launchOptions:@{MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,MKLaunchOptionsShowsTrafficKey: [NSNumber numberWithBool:YES]}];
            
        }
    }else if (buttonIndex < _availableMaps.count+1) {
        NSDictionary *mapDic = _availableMaps[buttonIndex-1];
        NSString *urlString = mapDic[@"url"];
        urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url = [NSURL URLWithString:urlString];
        NSLog(@"\n%@\n%@\n%@", mapDic[@"name"], mapDic[@"url"], urlString);
        [[UIApplication sharedApplication] openURL:url];
    }
}
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
//    if (buttonIndex == 0){
//        {
//            //当前的位置
//            MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
//            //目的地的位置
//            MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:_destCoorinate2D addressDictionary:nil]];
//            
//            toLocation.name = self.merName;
//            
//            NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
//            NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
//            //打开苹果自身地图应用，并呈现特定的item
//            [MKMapItem openMapsWithItems:items launchOptions:options];
//        }
//
//        
//    }else if (buttonIndex == 1){
//            }else if (buttonIndex == 2){//取消
//        
//        
//    }
//}

@end
