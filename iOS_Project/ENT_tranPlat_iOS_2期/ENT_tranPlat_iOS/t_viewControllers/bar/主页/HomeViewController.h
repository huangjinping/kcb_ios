//
//  HomeViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-14.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

//menu触发
#import "JDSBHSearchPayViewController.h"
#import "SettingViewController.h"
#import "CarManagerViewController.h"
#import "DriveLicenseManageViewController.h"

#import "AdvertisementViewController.h"

//绑定
#import "CarBindViewController.h"
#import "CarInfoViewController.h"
#import "DriverBindViewController.h"
//进入违章
#import "PeccancyRecordViewController.h"


#import "MenuView.h"
#import "DriverView.h"
#import "AdvertisementScrollView.h"

//#define TAG_BUTTON_TOP_LIST_SHOW_NO    1000
//#define TAG_BUTTON_TOP_LIST_SHOW_YES    1001

#define TAG_MENU_VIEW_LEFT          909
#define TAG_MENU_VIEW_RIGHT         908

#define TAG_ALERT_APP_NEW_VERSION_YES        300
#define TAG_ALERT_APP_NEW_VERSION_NO         301

#define PECCANCY_NET_STATUS_SUCC        @"SUCC"
#define PECCANCY_NET_STATUS_FAILED      @"FAILED"

#define WEATHER_VIEW_HEIGHT             25

//#define CAR_VIEW_HEIGHT    ((200.0/(480 - 44 - 46 - 20))*([[UIScreen mainScreen] bounds].size.height - 44 - 46 - 20))

#define CAR_VIEW_HEIGHT     ((30 + 140 + 30 + 20 + 30 + 20 + 30 + 20 + 20 + 30 + 30 + 20)*PX_Y_SCALE)

//#define HOME_VIEW_SPACE    ((5.0*3/480)*([[UIScreen mainScreen] bounds].size.height)/3)


@class DriverView;

@interface HomeViewController : BasicViewController
//<
//MenuViewDelegate,
//CarInfoScrollViewDelegate,
//DriverViewDelegate,
//AdvertisementImageViewDelegate,
//UIAlertViewDelegate
//>
//{
//
////    DriverView                      *_dView;
//    UIView                          *_weatherView;
//    UIView                          *_advertisementView;
//    
//    
//    
//    
////    BOOL                    _netCarPeccancySucc;
////    BOOL                    _netDriverPeccancySucc;
//
//    NSMutableDictionary             *_carNetStatusDict;
//    
//    //UIImageView                     *_topHphmBgImgView;
//    //UIImageView                     *_carInfoBgImgView;
//    CarInfoScrollView                 *_carInfoScrollView;
//
//    
//    //    UIImageView *driverView;
//    
//
//}
//
//@property(nonatomic,assign)NSInteger selectIndex;
//@property(nonatomic,strong)NSDictionary *dataDic;
//
//
@property(nonatomic,assign)BOOL doLoginNetWork;
//
//@property (nonatomic, retain)   NSString             *appUpdateUrlString;//appStore更新地址
//
//
//@property (nonatomic, retain)   NSMutableArray          *cars;//当前用户所有车
////@property (nonatomic, retain)   NSMutableArray          *driveLicenses;//当前用户驾驶证--只有一条数据
//@property (nonatomic, retain)   NSMutableDictionary     *carPeccancyRecordDict;//车辆违章记录字典
////@property (nonatomic, retain)   NSMutableDictionary     *driveLicensePeccancyRecordDict;//驾驶证违章记录字典

@end
