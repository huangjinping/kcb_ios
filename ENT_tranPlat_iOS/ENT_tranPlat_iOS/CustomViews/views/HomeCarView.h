//
//  HomeCarView.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/4/7.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

@class  HomeCarView;
@protocol HomeCarViewDelegate <NSObject>

@optional
- (void)homeCarView:(HomeCarView*)homeCarView tapCarInfoWithHphm:(NSString*)hphm;

- (void)homeCarView:(HomeCarView*)homeCarView tapPeccancyInfoWithHphm:(NSString*)hphm;

- (void)homeCarView:(HomeCarView*)homeCarView tapCarLogoWithHphm:(NSString*)hphm;

- (void)homeCarView:(HomeCarView*)homeCarView tapZhaohuiWithHphm:(NSString*)hphm;

@end

@interface HomeCarView : UIView

@property (nonatomic, assign)       id<HomeCarViewDelegate>    delegate_;
@property (nonatomic, retain)       NSString                 *carHphm;


- (id)initWithCar:(NSString*)carLicenseStr;

- (void)viewReloadAllInfo;
- (void)viewReloadOtherInfo;
- (void)viewReloadCarInfo;
- (void)viewReloadCarPeccancyInfo;

@end
