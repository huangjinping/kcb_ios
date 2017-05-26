//
//  BXOrderFormViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/17.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baoxian.h"

@interface BXOrderFormViewController : BasicViewController

@property (nonatomic)           Baoxian                 *baoxian;
@property (nonatomic)           NSMutableDictionary     *insDetailPriceDict;

@property (nonatomic, assign)   NSInteger               ins_name_code;

@end
