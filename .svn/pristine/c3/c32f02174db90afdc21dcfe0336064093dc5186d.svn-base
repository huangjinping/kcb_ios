//
//  UpeccancyViewController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 16/1/18.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"

#import "CarInfo.h"
#import "CarPeccancyRecord.h"
#import "AlertTextFieldView.h"
#import "UcarpenccanCell.h"
#import "UcarWFModel.h"
#import "EGORefreshTableHeaderView.h"




@interface UpeccancyViewController : BasicViewController<
UITableViewDataSource,
UITableViewDelegate,
UIAlertViewDelegate,
EGORefreshTableHeaderDelegate,
UIWebViewDelegate
>
{
    UITableView                     *_rootTableView;
    UIImageView                     *_segSelectedImgView;
    
    BOOL                _isDealingRecord;
    
    CarPeccancyMsg      *_dealingMsg;

     EGORefreshTableHeaderView       *_egoView;
    
    CarInfo        *_car;
}

@property (nonatomic, retain)     CarPeccancyRecord  *carPeccancyRecord;

//违章照片相关

@property (nonatomic,strong)NSMutableArray *datas;
- (id)initWithHphm:(NSString*)hphm;

@end
