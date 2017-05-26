//
//  CarPartListController.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/8.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CarPartListController : BaseTableViewController

@property (nonatomic, copy)void (^commplete)(NSDictionary *);
@property (nonatomic, strong) NSString *volume;
@property (nonatomic, strong) NSString *groupid;
@property (nonatomic, strong) NSString *merid;
@property (nonatomic, strong) NSString *carid;

@end
