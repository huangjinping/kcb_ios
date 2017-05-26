//
//  BYPayInfoViewController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/17.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "BaoYangModel.h"
@interface BYPayInfoViewController : BasicViewController

@property (nonatomic)   NSString  *titLabel;
@property (nonatomic)   NSString        *price;
@property (nonatomic)   NSString        *goodsName;
@property (nonatomic)   NSString        *companyName;
@property (nonatomic)   NSString        *orderNo;

@property (nonatomic)   NSString        *jmorderid;
@property (nonatomic)   NSString        *jminsuredName;

@property (nonatomic, assign) BOOL isSucceed;
@property (nonatomic, assign) BOOL isIng;
@property (nonatomic, copy) NSString *DDInfo;

@property (nonatomic, strong) BaoYangModel *baoyang;
@end
