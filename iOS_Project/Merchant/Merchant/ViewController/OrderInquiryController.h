//
//  OrderInquiryController.h
//  Merchant
//
//  Created by Wendy on 16/1/4.
//  Copyright © 2016年 tranPlat. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderInquiryController : BaseViewController
@property (nonatomic,copy) void(^commplete)(void);
@end
