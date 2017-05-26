//
//  OrderMessController.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/13.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseTableViewController.h"

typedef NS_ENUM(NSInteger,OrderDemandType) {
    DemandAll,
    DemandWaittingForPay,
    DemandWaittingForService,
    DemandWaittingForComment,
    DemandRefund
};

@interface OrderMessController : BaseViewController

@property (nonatomic, assign)OrderDemandType demandType;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)NSString *orderId;

@end
