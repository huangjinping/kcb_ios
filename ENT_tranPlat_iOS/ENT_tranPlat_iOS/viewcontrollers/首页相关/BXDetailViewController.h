//
//  BXDetailViewController.h
//  ENT_tranPlat_iOS
//
//  Created by yanyan on 15/7/9.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Baoxian.h"

@interface BXDetailViewController : BasicViewController


@property (nonatomic)           Baoxian                 *baoxian;

@property (nonatomic)           NSMutableDictionary     *insDetailPriceDict;
@property (nonatomic)           NSString                *ygSpecialMsg;
@property (nonatomic, assign)   NSInteger               ins_name_code;


@property (nonatomic, assign)   BOOL               showNextButton;

@end
