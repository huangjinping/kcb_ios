//
//  BYPayONlineViewController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/14.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "DataSigner.h"
#import "BaoYangModel.h"
#import "InfoModel.h"
@interface BYPayONlineViewController : BasicViewController
@property (nonatomic)   NSString        *price;
@property (nonatomic)   NSString        *goodsName;
@property (nonatomic)   NSString        *companyName;
@property (nonatomic)   NSString        *orderNo;
@property (nonatomic,copy) NSString    *key;
@property (nonatomic)   NSString        *jmorderid;
@property (nonatomic)   NSString        *jminsuredName;

@property (nonatomic,copy) NSString      *dingDan;
@property (nonatomic,assign) CGFloat     needPayAccount;

@property(nonatomic,assign)BOOL         ZhiFuBao;

@property (nonatomic, strong) BaoYangModel *baoyang;
@property (nonatomic, strong) InfoModel *infoModel;
@end
