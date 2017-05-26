//
//  CarDisplacementController.h
//  ENT_tranPlat_iOS
//
//  Created by xinpenghe on 16/1/7.
//  Copyright © 2016年 ___ENT___. All rights reserved.
//

#import "BaseTableViewController.h"

@interface CarDisplacementController : BaseTableViewController

@property (nonatomic, assign) BOOL saveCarInfo;
@property (nonatomic, strong) CarInfo *car;
@property (nonatomic, strong) NSString *seriesId;
@property (nonatomic, strong) NSString *level;
@property (nonatomic, strong) NSString *clpp1;
@property (nonatomic, strong) NSString *icon;
@property (nonatomic, strong) NSString *line;

@property (nonatomic, assign) BOOL needHome;

@end
