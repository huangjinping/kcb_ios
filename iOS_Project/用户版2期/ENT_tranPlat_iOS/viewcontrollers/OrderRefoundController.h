//
//  OrderRefoundController.h
//  ENT_tranPlat_iOS
//
//  Created by 辛鹏贺 on 16/1/28.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BasicViewController.h"

@interface OrderRefoundController : BasicViewController

@property (nonatomic, strong) NSString *orderNo;
@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, strong) void(^commplete)(void);

@end

@interface RefoundHeaderView : UIView

@end

@interface RefoundCell : UITableViewCell

@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIButton *icon;
@property (nonatomic, copy)void(^commplete)(void);

@end