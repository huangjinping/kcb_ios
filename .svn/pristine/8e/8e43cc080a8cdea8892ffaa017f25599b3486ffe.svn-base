//
//  PeccancyRecordViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-17.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DealingViewController.h"
#import "peccancyRecordCell.h"
#import "CarInfo.h"
#import "MWPhotoBrowser.h"
#import "MWPhoto.h"
#import "EGORefreshTableHeaderView.h"
#import "CarPeccancyRecord.h"
#import "PayViewController.h"
#import "AlertTextFieldView.h"
#import "MarkupParser.h"


//#define TAG_ALERT_TEXT_VIEW_NAME                800
//#define TAG_ALERT_TEXT_VIEW_ID                  801
#define TAG_ALERT_BAND_DRIVER_LICENSE           802
#define TAG_ALERT_CAN_FINISHED_PAY_ACTION           804


@interface PeccancyRecordViewController : BasicViewController<
UITableViewDataSource,
UITableViewDelegate,
MWPhotoBrowserDelegate,
UIAlertViewDelegate,
EGORefreshTableHeaderDelegate,
UIWebViewDelegate
>
{
    UITableView                     *_rootTableView;
    EGORefreshTableHeaderView       *_egoView;
    UIButton                        *_leftSegButton;
    UIButton                        *_rightSegButton;
    UIImageView                     *_segSelectedImgView;

    BOOL                _isDealingRecord;
    
    CarPeccancyMsg      *_dealingMsg;
    //NSString            *_inputTextName;
    //NSString            *_inputTextId;
    
    
    CarInfo        *_car_;
}


@property (nonatomic, retain)     NSMutableArray  *carMsgs_dealing;//车辆违章-处理datasource
@property (nonatomic, retain)     NSMutableArray  *carMsgs_pay;//车辆违章-缴款datasource
@property (nonatomic, retain)     CarPeccancyRecord  *carPeccancyRecord;

//违章照片相关
@property (nonatomic, retain)   NSArray     *photos;
@property (nonatomic, retain)   NSString     *xh;


//上个界面传递参数
//@property (nonatomic, retain)     NSString   *hphm;


- (id)initWithHphm:(NSString*)hphm;
@end
