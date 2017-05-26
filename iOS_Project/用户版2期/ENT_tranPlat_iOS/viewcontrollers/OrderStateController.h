//
//  OrderStateController.h
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/2/3.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderStateController : BaseViewController

@property (nonatomic, strong)NSString *orderId;
@property (nonatomic, strong)NSString *orderNo;
@property (nonatomic, strong)void (^commplete)(NSMutableDictionary *);

@end
