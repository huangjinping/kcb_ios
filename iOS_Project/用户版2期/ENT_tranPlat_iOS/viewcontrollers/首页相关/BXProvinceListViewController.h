//
//  BXProvinceListViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/23.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baoxian.h"

#define ADDR_TYPE_PROVINCE          @"P省"
#define ADDR_TYPE_CITY              @"C市"
#define ADDR_TYPE_REGION            @"R区"
@interface BXProvinceListViewController : BasicViewController

@property (nonatomic)       NSMutableDictionary     *infoDict;
@property (nonatomic)       NSArray                 *listDataArr;
@property (nonatomic)       NSString                 *type;

@end
