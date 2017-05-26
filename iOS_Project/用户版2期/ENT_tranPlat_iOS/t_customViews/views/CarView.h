//
//  CarView.h
//  ENT_tranPlat_iOS
//
//  Created by 张永维 on 14-7-16.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TAG_BUTTON_ACTION_ENTER_PECCANCY        404
#define TAG_BUTTON_ACTION_RELOAD_PECCANCY       405
#define TAG_BUTTON_ACTION_RE_BIND               406

@class CarView;
typedef enum{
    bindSucc = 0,
    bindFailed = 1,
    bindNull = 2
} BindStatus;


typedef enum{
    actionEnterPeccancyRecord = 0,
    actionReloadPeccancyRecord = 1,
    actionRebind = 2
} Action;

@protocol CarViewDelegate <NSObject>

@optional
- (void)carView:(CarView*)carView respondAction:(Action)action;

- (void)carView:(CarView*)carView tapCar:(CarInfo*)car;

- (void)carViewDidTapBlank;


@end


@interface CarView : UIView
{
    UILabel                 *_carNumL;
    UIImageView             *_lineImgView;
    UILabel                 *_recordL;
    UILabel                 *_statusL;
    
    
    BindStatus              _bindStatus;
}

@property(nonatomic,retain) CarInfo         *car;
@property(nonatomic,assign) id<CarViewDelegate>             _delegate;


//初始化视图
- (void)setViewWithCar:(CarInfo *)car ;//peccancyCount:(NSInteger)peccancyCount andLoadingPeccancyRecordStatus:(LoadingPeccancyRecordStatus)loadingPeccancyRecordStatus;
@end
