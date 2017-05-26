//
//  OrderInfoViewController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/10.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "BaoYangModel.h"
@interface OrderInfoViewController : BasicViewController
@property (nonatomic, strong) BaoYangModel *baoyang;
@property (nonatomic)   CarInfo *car;
@end
