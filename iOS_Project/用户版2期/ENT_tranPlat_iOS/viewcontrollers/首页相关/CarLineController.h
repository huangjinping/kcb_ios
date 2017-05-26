//
//  CarLineController.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/7.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CarLineController : BaseTableViewController

@property (nonatomic, assign) BOOL saveCarInfo;
@property (nonatomic, strong) NSString *Id;
@property (nonatomic, strong) NSString *clpp1;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, assign) BOOL needHome;

@end
