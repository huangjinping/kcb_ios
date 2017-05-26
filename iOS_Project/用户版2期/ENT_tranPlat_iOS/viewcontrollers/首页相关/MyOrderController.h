//
//  MyOrderController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/8.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "BaoYangModel.h"
#import "BaoYangServiewModel.h"
@interface MyOrderController : BasicViewController
@property (nonatomic, strong) BaoYangModel *baoyang;
@property (nonatomic)   CarInfo *car;
@end
