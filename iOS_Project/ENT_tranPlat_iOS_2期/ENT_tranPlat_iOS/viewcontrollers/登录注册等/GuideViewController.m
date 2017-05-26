//
//  GuideViewController.m
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import "GuideViewController.h"

@interface GuideViewController ()<
CLLocationManagerDelegate
>
{
    NSTimer *_timer;
    UIScrollView *_scrollView;
    UIPageControl *_pageCon;
    
    CLGeocoder *_geocoder;
    CLLocationManager *_locationManager;
    
    CGFloat             _pageCount;
}
@end

@implementation GuideViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#define GUIDE_HEIGHT            iOS7 ? ([UIScreen mainScreen].bounds.size.height):([UIScreen mainScreen].bounds.size.height - 20)

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    if (!iOS7) {
        [[UIApplication sharedApplication] setStatusBarHidden:NO];

    }
    
    _pageCount = 4;
    UIImage *downloadImage = [UIImage imageWithContentsOfFile:GUIDE_IMG_LOCAL_PATH];
    if (!downloadImage) {
        _pageCount = 3;
    }
    
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(APP_X, 0, APP_WIDTH, GUIDE_HEIGHT)];
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.pagingEnabled = YES;
    [_scrollView setDelegate:self];
    [_scrollView setBounces:NO];
    [self.view addSubview:_scrollView];
    [_scrollView setContentSize:CGSizeMake(APP_WIDTH * _pageCount, GUIDE_HEIGHT - 20)];
    
    for (int i = 0; i < _pageCount; i ++) {
        
        UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(i*APP_WIDTH, 0, APP_WIDTH, GUIDE_HEIGHT)];
        [_scrollView addSubview:bgView];
        [bgView setBackgroundColor:[UIHelper getColor:@"#43b853"]];
        //1242  2208
        
        if (i == 2) {
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:LGRectMake((APP_PX_WIDTH - bgView.h * (1242/2208.0))/2.0, 0, bgView.h * (1242/2208.0), bgView.h)];
            if (downloadImage) {
                [imgv setImage:downloadImage];
            }else{
                [imgv setImage:[UIImage imageNamed:@"guide3.png"]];
            }
            [bgView addSubview:imgv];
            continue;
        }else{
            UIImageView *imgv = [[UIImageView alloc] initWithFrame:LGRectMake((APP_PX_WIDTH - bgView.h * (1242/2208.0))/2.0, 0, bgView.h * (1242/2208.0), bgView.h)];
            NSString *imgName = [NSString stringWithFormat:@"guide%d", i];
            UIImage *img = [UIImage imageNamed:imgName];
            [imgv setImage:img];
            [bgView addSubview:imgv];
        }
        
    }
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setFrame:CGRectMake(APP_WIDTH*(_pageCount - 1) + (APP_WIDTH - 150)/2, APP_HEIGHT - 85, 150, 30)];
    [btn setTitle:@"立即体验 >" forState:UIControlStateNormal];
    [btn setTitleColor:[UIHelper getColor:@"#ffffff"] forState:UIControlStateNormal];
     btn.titleLabel.font = [UIFont systemFontOfSize:22];
    [btn addTarget:self action:@selector(enterHome) forControlEvents:UIControlEventTouchUpInside];
    [_scrollView addSubview:btn];
    
    _pageCon = [[UIPageControl alloc] init];
    [_pageCon setNumberOfPages:_pageCount];
    
    CGRect frame = CGRectMake(0, APP_HEIGHT - 50, 100, 20);
    if (iOS7) {
        frame = CGRectMake((APP_WIDTH - 100)/2, APP_HEIGHT - 50, 100, 20);
    }
    
    [_pageCon setFrame:frame];
    
    
    if (iOS6) {
        [_pageCon setPageIndicatorTintColor:COLOR_BUTTON_YELLOW];
        //UIImage *img = [UIImage imageNamed:@"page_point_current.png"];
        [_pageCon setCurrentPageIndicatorTintColor:[UIColor whiteColor]];
    }
    
    [_pageCon setCurrentPage:0];
    //if (iOS7) {
        [self.view addSubview:_pageCon];
    //}
    
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(scroll) userInfo:nil repeats:YES];
}

- (void)viewDidAppear:(BOOL)animated{
    
    [super viewDidAppear:YES];
    [self startLocation];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:YES];
   
}

- (void)scroll{
    
    CGFloat x = _scrollView.contentOffset.x;
    
    [UIView animateWithDuration:0.5f animations:^{
        
        [_scrollView scrollRectToVisible:CGRectMake(x+APP_WIDTH, 0, APP_WIDTH, GUIDE_HEIGHT) animated:NO];
        
    }];
}

#pragma mark- delegates
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_pageCon setCurrentPage:(_scrollView.contentOffset.x/APP_WIDTH)];
    if (scrollView.contentOffset.x > APP_WIDTH*(_pageCount - 2)) {//正在滚动至最后页
        //[_scrollView setScrollEnabled:NO];
        [_timer invalidate];
        [_pageCon setHidden:YES];
    }else{
        [_pageCon setHidden:NO];
    }
}



- (void)enterHome{
    
    //第一次启动，游客身份的进入.
    TabBarViewController *tabVC = [[TabBarViewController alloc] init];
    self.navigationController.navigationBar.hidden = NO;

    [self.navigationController pushViewController:tabVC animated:YES];
}



- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    CLLocation *loc = [locations firstObject];
    NSString *longitudeStr = [NSString stringWithFormat:@"%f",loc.coordinate.longitude];
    NSString *latitudeStr = [NSString stringWithFormat:@"%f",loc.coordinate.latitude];
    [self reverseGeocodeWithLatitude:latitudeStr Longtitude:longitudeStr];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    [[self locationManager] stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    switch (status)
    {
        case kCLAuthorizationStatusNotDetermined:
            if ([manager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
                [manager requestWhenInUseAuthorization];
            }
            break;
        default:
            break;
    }
}

//arc 中 locationManager容易被释放，故如此获取
- (CLLocationManager*)locationManager{
    if (_locationManager == nil) {
        _locationManager = [[CLLocationManager alloc]init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        _locationManager.distanceFilter = kCLDistanceFilterNone;


    }
    return _locationManager;
}
//arc 中 locationManager容易被释放，故如此获取
- (CLGeocoder*)geocoder{
    if (_geocoder == nil) {
        _geocoder=[[CLGeocoder alloc]init];
    }
    return _geocoder;
}

- (void)startLocation{
    
    [Helper locationServiceEnable];
    
    [[self locationManager] startUpdatingLocation];

}



- (void)reverseGeocodeWithLatitude:(NSString *)latitudeStr Longtitude:(NSString *)longtitudeStr {
    //1.获得输入的经纬度
    if (longtitudeStr.length==0||latitudeStr.length==0) return;
    
    [[self locationManager] stopUpdatingLocation];
    CLLocationDegrees latitude=[latitudeStr doubleValue];
    CLLocationDegrees longitude=[longtitudeStr doubleValue];
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude longitude:longitude];
    //2.反地理编码
    
    [[self geocoder] reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
            //[self.view showAlertText:@"定位超时,请重新定位"];
        }
        else//编码成功
        {
            //显示最前面的地标信息
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            
            NSMutableString *cityMStr = nil;
            if ([firstPlacemark.locality length] > 0 ) {
                cityMStr = [NSMutableString stringWithString:firstPlacemark.locality];
            }
            else{
                cityMStr = [NSMutableString stringWithString:firstPlacemark.administrativeArea];
            }
            
            //    //read
            NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"city" ofType:@"txt"];
            NSData *resourceData = [NSData dataWithContentsOfFile:resourcePath];
            SBJsonParser *parser = [[SBJsonParser alloc] init];
            NSDictionary *resourceDict = [parser objectWithData:resourceData];
            
            NSArray *resourceArr = [resourceDict objectForKey:@"pl"];
            NSMutableDictionary *citysDict = [[NSMutableDictionary alloc] initWithCapacity:0];
            NSMutableArray *provinceArr= [[NSMutableArray alloc] initWithCapacity:0];
            for (NSDictionary *dict in resourceArr) {
                NSString *pname = [dict objectForKey:@"pname"];
                NSArray *citys = [dict objectForKey:@"list"];
                [provinceArr addObject:pname];
                [citysDict setObject:citys forKey:pname];
            }

            NSString *cityStr = [cityMStr substringWithRange:NSMakeRange(0, [cityMStr length]-1)];
            for (NSString *princeStr in provinceArr) {
                NSMutableArray *subArray = [citysDict objectForKey:princeStr];
                for (NSDictionary *subDict in subArray) {
                    NSMutableString *cityString = [NSMutableString stringWithString:[subDict objectForKey:@"name"]];
                    if ([cityStr rangeOfString:cityString].location != NSNotFound) {
                        NSDictionary *cityAndCode = [NSDictionary dictionaryWithDictionary:subDict];
//                        UserInfo *user = [[[DataBase sharedDataBase] selectActiveUser] lastObject];
//                        user.citySet = [cityAndCode objectForKey:@"name"];
//                        [user update];
                        NSString *city = @"";
                        NSString *code = @"";
                        //if ([firstPlacemark.locality length] > 0) {
                            city = [cityAndCode objectForKey:@"name"];
                            code = [cityAndCode objectForKey:@"code"];
                        //}
                        
                        [[NSUserDefaults standardUserDefaults] setObject:city forKey:KEY_CITY_NAME_IN_USERDEFAULT];
                        [[NSUserDefaults standardUserDefaults] setObject:code forKey:KEY_CITY_CODE_IN_USERDEFAULT];

                        [[NSNotificationCenter defaultCenter] postNotificationName:NOTIFICATION_CITY_SET_CHANGED object:nil];
                        break;
                        //[self.view showAlertText:@"定位成功"];
                        
                    }
                }
                if (![[[NSUserDefaults standardUserDefaults] objectForKey:KEY_CITY_NAME_IN_USERDEFAULT] isEqualToString:@""]) {
                    break;
                }
            }
            
        }
    }];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
