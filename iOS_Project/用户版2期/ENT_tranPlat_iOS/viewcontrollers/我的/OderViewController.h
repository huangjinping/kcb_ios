//
//  OderViewController.h
//  ENT_tranPlat_iOS
//
//  Created by Lin_LL on 15/9/25.
//  Copyright (c) 2015年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"
#import "Baoxian.h"

@interface OderViewController : BasicViewController

@property (nonatomic)           Baoxian                 *baoxian;

@property (nonatomic)           NSMutableDictionary     *insDetailPriceDict;
@property (nonatomic)           NSString                *ygSpecialMsg;
@property (nonatomic, assign)   NSInteger               ins_name_code;


@property (nonatomic, assign)   BOOL               showNextButton;
@end
