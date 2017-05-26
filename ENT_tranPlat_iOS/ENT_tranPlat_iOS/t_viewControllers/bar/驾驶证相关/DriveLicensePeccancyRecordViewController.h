//
//  DriveLicensePeccancyRecordViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 14-7-31.
//  Copyright (c) 2014年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PayViewController.h"
#import "DriveLicensePeccancyRecord.h"
#import "EGORefreshTableHeaderView.h"

@interface DriveLicensePeccancyRecordViewController : BasicViewController<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
EGORefreshTableHeaderDelegate,
UIWebViewDelegate
>
{

    UITableView         *_rootTableView;
    EGORefreshTableHeaderView *_egoView;
    BOOL                _isFinishedRefresh;

}


@property (nonatomic, retain)     NSMutableArray  *driveMsgs_pay;//驾驶证违章-缴款datasource
@property (nonatomic, retain)     DriveLicensePeccancyRecord  *driveLPeccancyRecord;


//上个界面传递参数
@property (nonatomic, retain)     DriverInfo   *driver;


@end
