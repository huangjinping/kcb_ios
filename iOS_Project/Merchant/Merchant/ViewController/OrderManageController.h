//
//  OrderManageController.h
//  Merchant
//
//  Created by Wendy on 15/12/18.
//  Copyright © 2015年 tranPlat. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderManageController : BaseViewController
@property (nonatomic,assign) BOOL isFromSearch;
@property (nonatomic,copy) NSString *startTime;
@property (nonatomic,copy) NSString *endTime;
@property (nonatomic,copy) NSString *orderNo;
@property (nonatomic,copy) NSString *statusValue;
@property (nonatomic,copy) NSString *appraiseValue;
@end
