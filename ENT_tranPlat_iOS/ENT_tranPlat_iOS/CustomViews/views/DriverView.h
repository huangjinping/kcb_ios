//
//  DriverView.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_BUTTON_ACTION_ENTER_PECCANCY        404
#define TAG_BUTTON_ACTION_RELOAD_PECCANCY       405
#define TAG_BUTTON_ACTION_RE_BIND               406
typedef enum{
    actionEnterPeccancyRecord = 0,
    actionReloadPeccancyRecord = 1,
    actionRebind = 2,
    actionLogoChange = 3,
    actionEnterCarInfo = 4,
    actionEnterZhaohui = 5
} Action;

@class DriverView;


@protocol DriverViewDelegate <NSObject>

@optional
- (void)driverView:(DriverView*)driverView driver:(DriverInfo*)driver didRespondAction:(Action)action;


- (void)driverView:(DriverView*)driverView didTapDriver:(DriverInfo*)driver;

- (void)driverViewDidTapForAdd;

//- (void)didRespondAction:(Action)action;
//
//
//- (void)didTap:(DriverInfo*)driver;
//
//- (void)driverViewAdd;

@end

@interface DriverView : UIView
{
    
}

@property (nonatomic, retain)   DriverInfo              *driver;

@property (nonatomic, assign)   id<DriverViewDelegate>              _delegate;

- (void)loadData:(DriverInfo *)driver;

+ (DriverView *)shareInstance;

@end
