//
//  CYHDSendTopicViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-8-4.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuView.h"
#import <CoreLocation/CoreLocation.h>


@interface CYHDSendTopicViewController : BasicViewController<
UIImagePickerControllerDelegate,
UINavigationControllerDelegate,
UITextViewDelegate,
UIGestureRecognizerDelegate,
CLLocationManagerDelegate,
MenuViewDelegate
>
{
    UITextView                      *_textView;
    UIButton                        *_addImageButton;
    
   // NSData                  *_imgData;
    
    NSMutableArray                  *_uploadPhotos;
    NSMutableArray                  *_uploadedPhotoUrls;
    MenuView                        *_addMenuView;
    UIButton                        *_locationButton;
    UILabel                         *_locationLabel;
    NSMutableDictionary             *_citysDict;
    NSMutableArray                  *_provinceArr;
    
    UIView                          *_locationView;
    UIActivityIndicatorView         *_testActivityIndicator;
    MBProgressHUD                   *_locateHud;
//  定位服务状态 YES 完成(除进行中以外的情况) NO 进行中
    BOOL                            _locateState;
    NSMutableString                 *_selectBSort;
    

}
//定位管理器
@property (nonatomic, strong) CLLocationManager       * locationManager;
//地理编码
@property (nonatomic, strong) CLGeocoder               *geocoder;


@property (nonatomic, retain)   NSString        *bsort;

@property (nonatomic, retain)   NSString        *locatedCityString;
//是否来自互动主界面
@property (nonatomic, assign)   BOOL            isHu;
//导航条标题
@property (nonatomic, retain)   NSString        *navTitleStr;

@property (nonatomic, retain)   NSArray         *bsortArray;

@property (nonatomic, retain)   NSArray         *titleArray;

@end
