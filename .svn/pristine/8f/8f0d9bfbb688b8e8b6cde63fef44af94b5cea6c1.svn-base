//
//  DriverView.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-28.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CarView.h"

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
