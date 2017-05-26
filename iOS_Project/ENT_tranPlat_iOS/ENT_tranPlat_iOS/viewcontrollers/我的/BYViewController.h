//
//  BYViewController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/30.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "InfoModel.h"
#import "BaoYangModel.h"

@interface BYViewController : BasicViewController
@property(nonatomic,strong)InfoModel *model;
@property (nonatomic, strong) BaoYangModel *baoyang;
@property (nonatomic)   CarInfo *car;
@end
